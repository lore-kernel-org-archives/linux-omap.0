From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 02/10 V4] omap3: pm: introduce opp accessor functions
Date: Thu, 17 Dec 2009 17:39:20 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912171738240.12561@utopia.booyaka.com>
References: <1260339435-20294-1-git-send-email-nm@ti.com> <1260339435-20294-2-git-send-email-nm@ti.com> <1260339435-20294-3-git-send-email-nm@ti.com> <87iqceo1hb.fsf@deeprootsystems.com> <4B21954A.7010305@ti.com> <87tyvxms0j.fsf@deeprootsystems.com>
 <7A436F7769CA33409C6B44B358BFFF0C012B9F4C3F@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40330 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362AbZLRAjV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 19:39:21 -0500
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C012B9F4C3F@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "Dasgupta, Romit" <romit@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Aguirre, Sergio" <saaguirre@ti.com>, Tero Kristo <Tero.Kristo@nokia.com>, "Gopinath, Thara" <thara@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Premi, Sanjeev" <premi@ti.com>


Hello Nishanth,

Following are some comments on your OPP code (revision five).

While preparing them, I put together some experimental patches to
verify that the comments resulted in cleaner code.  They will be sent
as separate messages.  You might find them useful.  If so, you're
welcome to integrate them to your code.


- Paul


General comments:

- The OPP code has hardcoded dependencies on the TWL/TPS
  Triton2/Gaia/Reno series of chips.  Please move the uv_to_vsel() and 
  vsel_to_uv() functions off to a
  separate file, and rename them to mark them as being
  TWL/TPS-specific, for example, "twl_uv_to_vsel()" etc.  These
  functions will probably not be deprecatable because they will be
  needed by the TWL/TPS code to program the PMIC correctly.  So it
  also makes sense to remove the 'deprecated' markings.

- Please remove the vsel data out of the OPP layer.  The OPP code
  should be independent of the PMIC.

- Let's avoid the "initial terminators" hack and convert all of the
  code that tries to access the *_opps[] arrays directly to use
  accessor functions.  Judging by a grep through the codebase, it
  seems that SRF and SmartReflex are the only offenders here.

- Your patches don't build with !CONFIG_PM.  Please fix.

- The vsel rounding currently handled in omap_opp_populate() should be
  handled in uv_to_vsel(), lest other code that uses uv_to_vsel()
  get different answers.

- In pm34xx.c:omap34xx_l3_rate_table(), why is OPP1 defined at 0 Hz -
  shouldn't this be 41.5MHz?

- Since the clock framework no longer has anything to do with
  generating the cpufreq_frequency_table for OMAP3, please move
  clock34xx.c:omap2_clk_init_cpufreq_table() to a more logical place
  such as opp.c, and rename the function appropriately -- perhaps
  something like opp_init_cpufreq_table() ?  Probably
  plat-omap/cpu-omap.c:omap_cpu_init() will need a little extra "if
  (cpu_is_*)" code in the short term until the OMAP2 OPPs are
  converted to use the OPP layer also.

- Rather than using opp_find_freq_approx() in
  omap2_clk_init_cpufreq_table(), it seems better to just create a
  function that returns an array of data structures appropriately
  constructed for cpu-omap.c.  This can be rolled into
  opp_init_cpufreq_table(), since CPUFreq will be the only user.


Simplicity/readability comments:

- In opp.c:opp_add(), constants like '3' or '2' in lines like these:

	oppr = kmalloc(sizeof(struct omap_opp) * (n + 3), GFP_KERNEL);

  need to be documented.  In the above case, I assume this is the
  "initial terminator" plus the new entry, plus the ending terminator.
  This should be documented, at least with a comment, and ideally in
  one or more macros with comments.

- Please split opp_find_freq_approx() into two functions.  This seems
  simpler and more readable.  Consider using terms like "floor" and
  "ceil" in the function names, since they'll be instantly
  recognizable to most programmers with POSIX experience (libm).


A few minor comments (but important nonetheless):

- In opp.c, you have two different kinds of "invalid parameter" error
  messages:

	pr_err("%s: Invalid parameters being passed\n", __func__);

  and

	pr_err("%s: Invalid params being passed\n", __func__);

  This consumes memory unnecessarily, since both strings will have to
  be stored - this can be avoided if you use the same string text.
  Also, please use WARN(), rather than pr_err(), in these cases.
  WARN() will provide a stack backtrace which will help users
  determine which function caused the error.

- There are lots of uses of unlikely() in non-fast path code.  These seem
  unnecessary.  

- Good kerneldoc - this really helps.  Please move the kerneldoc
  comments from the plat/opp.h file to the plat-omap/opp.c file.  The
  usual rationale for putting function comments in the .h file is if
  the .h file represents an interface that can be implemented by a
  variety of possible .c files.  That isn't the case here - there
  should be only one OPP code layer for OMAP.

- Please consider avoiding words like "coz" in the patch descriptions.
  The full expansion is not too hard to type and it will make the
  commit messages easier to understand for people who are less
  familiar with English.

- You've added several BUG_ON()s that don't appear to be necessary.
  The usual kernel practice is to only use BUG_ON()s for critical
  errors.  For example, BUG_ON()s in these functions should be
  converted to either return an error code or to WARN():
  opp_to_freq(); freq_to_opp().  Others should probably be removed
  also, but given the current state of the SRF, I'm not sure I'd
  recommend removing them.

- Consider simplifying the name of opp_get_opp_count() to just
  opp_count_opps().

- While you're touching the SRF code, could you also rename the SRF
  freq_to_opp() and opp_to_freq() to "freq_to_opp_id()" and
  "opp_id_to_freq()", to help clarify what these functions do?

- Consider the use of kzalloc() rather than kmalloc() in the
  opp.c code.  The advantage of kzalloc() is that, if the structure is
  are changed, whoever changes them does not have to worry about
  initializing the structure fields to zero, which can save someone
  else some debugging time.

- I'll just note here that we'll need to extend this code further in a
  few respects that we've discussed before: OMAP1/2 support and
  VDD1<->VDD2 OPP dependencies are ones that come to mind.  Not that we
  have to grapple with them now, but as you revise your code, perhaps you
  can keep these in mind.


- Paul
