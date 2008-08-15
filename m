From: Paul Walmsley <paul@booyaka.com>
Subject: Re: [PATCH 00/10] OMAP3 SRF: OMAP PM interface implemented using  
    Shared resource Framework
Date: Fri, 15 Aug 2008 01:50:19 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0808150100330.6619@utopia.booyaka.com>
References: <44828.192.168.10.89.1218459899.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39960 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724AbYHOHuU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Aug 2008 03:50:20 -0400
In-Reply-To: <44828.192.168.10.89.1218459899.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com


Hello Rajendra,

Here are some comments on the SRF patches, based on a fairly quick look.

By the way, if you haven't already, could you also run checkpatch.pl and 
sparse on it?


Bugs
----

1. In resource_request(), the first 'if' needs braces around the entire 
   block:

+       /* Call the resource specific validate function */
+       if (resp->ops->validate_level)
+               ret = resp->ops->validate_level(resp, level);
+               if (ret)
+                       return ret;

2. There is a potential race in resource_get_level().  A
   resource could be unregistered after the resource_lookup()
   but before the 'ret = resp->curr_level;'.   Consider
   creating a _resource_lookup() function that does not lock, and
   expanding the locked section of resource_get_level() to include
   a call to _resource_lookup().

3. get_lat_res_name() should not use a static shared string buffer, but
   should use a pointer to a string buffer passed in from its caller, and
   should take a maxlength argument as well.  This eliminates races if 
   multiple calls to get_lat_res_name() occur.  This should allow you to
   remove the locking in this function also.

4. The L3 throughput numbers in l3_throughput_db appear to be off by 
   several orders of magnitude - please recheck these.

5. set_opp() for VDD2 appears to use the wrong clock name in one of the
   if-statement branches:  'clk_set_rate(vdd1_clk, l3_freq)'  instead of
   vdd2_clk ?

6. The "virtual clock nodes" patch keeps referring to dpll3_clk, and even
   contains "clk_set_rate(dpll3_clk, ..."  There's no way that can work
   currently since there is no SRAM DPLL rate change function for DPLL3 on 
   OMAP3.  Did you intend to use dpll3_m2_ck instead?

7. Regarding srf_mutex_{lock,unlock}: convert the mutex to a
   spinlock if this needs to execute in atomic or interrupt
   context, and drop these macros:

+#define srf_mutex_lock(x)      { \
+                               if (!(in_atomic() || irqs_disabled()))  \
+                                       mutex_lock(x); \
+                               }
+#define srf_mutex_unlock(x)    { \
+                               if (!(in_atomic() || irqs_disabled()))  \
+                                       mutex_unlock(x); \
+                               }

8. SRF init should presumably belong in omap_pm_if_early_init(), since
   clock framework can call omap_pm_pwrdm_*active() during init.

9. resource_init() contains a test against cpu_is_omap343x().
   Consider converting this into a test against cpu_is_omap34xx(), in case
   cpu_is_omap343x starts becoming sensitive to differences between 
   OMAP3403, 3413, etc.

10. In omap-pm-srf.c, the credit to Amish Lakhani should go to Anand 
    Sawant; I somehow managed to confuse them.  I will update this in the 
    original as well:

+ * Interface developed by (in alphabetical order):
+ * Karthik Dasu, Amish Lakhani, Tony Lindgren, Rajendra Nayak, Sakari
+ * Poussa, Veeramanikandan Raju, Igor Stoppa, Paul Walmsley, Richard
+ * Woodruff


11. In set_pd_latency(), won't the original state of the clockdomain 
    (hwsup vs. swsup) be lost after 'case PWRDM_POWER_RET:' ?  Should the 
    final omap2_clkdm_allow_idle() be skipped if the clockdomain was
    originally in swsup mode?

+       case PWRDM_POWER_RET:
+               /* Errata 1.29: No transitions from INACTIVE to RET/OFF
+                * possible.
+                * Need to be taken care of here.
+                */
+               if (pwrdm_read_pwrst(pwrdm) != PWRDM_POWER_ON) {
+                       /* Force the clock domains to ON */
+                       for (i = 0; pwrdm->pwrdm_clkdms[i]; i++) {
+                               omap2_clkdm_deny_idle(pwrdm->pwrdm_clkdms[i]);
+                               omap2_clkdm_wakeup(pwrdm->pwrdm_clkdms[i]);
+                       }
+                       pwrdm_set_next_pwrst(pwrdm, PWRDM_POWER_ON);
+                       pwrdm_set_next_pwrst(pwrdm, pd_lat_level);
+                       for (i = 0; pwrdm->pwrdm_clkdms[i]; i++) {
+                               omap2_clkdm_sleep(pwrdm->pwrdm_clkdms[i]);
+                               omap2_clkdm_allow_idle(pwrdm->pwrdm_clkdms[i]);
+                       }



Efficiency
----------

12. get_freq(), get_opp(): remove the inline; let the compiler do it. 

13. get_opp(): replace the first return (prcm_config+1)->opp; with a 
    'break';


Style
-----

14. All non-static functions should have at least "omap_" prepended to 
    them, in this case, ideally "omap_srf_".  The idea here is to prevent 
    name collisions with other parts of the kernel and to make it easy to 
    identify what subsystem a particular function belongs to.

15. This if-statement should have braces around both portions:

+void free_user(struct users_list *user)
+{
+       if (user->usage == DYNAMIC_ALLOC)
+               kfree(user);
+       else {
+               user->usage = UNUSED;
+               user->level = RES_DEFAULTLEVEL;
+               user->dev = NULL;
+       }
+}

   In resource_request(), the following code should have braces around it,
   and the parentheses around resp->users_list are superfluous:

+       list_for_each_entry(user, &(resp->users_list), node)
+               if (user->dev == dev) {
+                       found = 1;
+                       break;
+               }

.  In resource_release(), same thing:

+       list_for_each_entry(user, &(resp->users_list), node)
+               if (user->dev == dev) {
+                       found = 1;
+                       break;
+               }


16. The default section in this 'switch' is unnecessary; also, the last 
    branch of the 'else' needs braces:

+       switch (pd_lat_level) {
+       case PWRDM_POWER_OFF:
+       case PWRDM_POWER_RET:
+               /* Errata 1.29: No transitions from INACTIVE to RET/OFF
+                * possible.
+                * Need to be taken care of here.
+                */
+               if (pwrdm_read_pwrst(pwrdm) != PWRDM_POWER_ON) {
+                       /* Force the clock domains to ON */
+                       for (i = 0; pwrdm->pwrdm_clkdms[i]; i++) {
+                               omap2_clkdm_deny_idle(pwrdm->pwrdm_clkdms[i]);
+                               omap2_clkdm_wakeup(pwrdm->pwrdm_clkdms[i]);
+                       }
+                       pwrdm_set_next_pwrst(pwrdm, PWRDM_POWER_ON);
+                       pwrdm_set_next_pwrst(pwrdm, pd_lat_level);
+                       for (i = 0; pwrdm->pwrdm_clkdms[i]; i++) {
+                               omap2_clkdm_sleep(pwrdm->pwrdm_clkdms[i]);
+                               omap2_clkdm_allow_idle(pwrdm->pwrdm_clkdms[i]);
+                       }
+               } else
+                       pwrdm_set_next_pwrst(pwrdm, pd_lat_level);
+               break;
+       case PWRDM_POWER_ON:
+               pwrdm_set_next_pwrst(pwrdm, PWRDM_POWER_ON);
+               break;
+       default:
+               break;
+       }

17. In set_pd_latency(), just reuse 'i' here, rather than creating a 
    separate index variable 'ind':

+       for (ind = 0; ind < PD_LATENCY_MAXLEVEL; ind++)
+               if (pd_lat_db->latency[ind] < latency)
+                       pd_lat_level = ind;

18. Please put spaces around binary operators like '-' and '+' per 
    CodingStyle 3.1; for example "(prcm_config+1)->opp" should be 
    "(prcm_config + 1)->opp"


Misc
----

19. vdd1,2_volts arrays & OPP data should be passed into omap_pm_if_init() 
    from the board-*.c files, for example in arrays of struct omap_opp.
    This should allow each board to specify OPP sets and VDD voltages.

20. omap2_clk_arch_init(): Is the removal of the "mpurate" boot
    parameter intentional?

21. omap2_clk_init(), set_opp(), other functions: there are many
    #ifdefs for CONFIG_MACH_OMAP_3430SDP.  Are these really necessary?
    Seems like that code would apply to all OMAP3.  The SRF code can be
    dropped out for non-OMAP3 builds by simply not adding it to OMAP2 
    builds in the Makefile.

22. Do the voltages and OPP rates apply to other TI OMAP3 boards?  If so,
    please add them to the other OMAP3 board files also.


happy Independence Day,


- Paul
