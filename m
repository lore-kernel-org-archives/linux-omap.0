From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: ARM: OMAP2+: Powerdomain: Remove the need to always have a
 voltdm associated to a pwrdm
Date: Wed, 6 Nov 2013 23:36:12 +0300
Message-ID: <20131106203612.GC22627@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:46644 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756017Ab3KFUgW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Nov 2013 15:36:22 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rnayak@ti.com
Cc: linux-omap@vger.kernel.org

Hello Rajendra Nayak,

This is a semi-automatic email about new static checker warnings.

The patch cd8abed1da91: "ARM: OMAP2+: Powerdomain: Remove the need to 
always have a voltdm associated to a pwrdm" from Jun 17, 2013, leads 
to the following Smatch complaint:

arch/arm/mach-omap2/powerdomain.c:131 _pwrdm_register()
	 error: we previously assumed 'arch_pwrdm' could be null (see line 105)

arch/arm/mach-omap2/powerdomain.c
   104	
   105		if (arch_pwrdm && arch_pwrdm->pwrdm_has_voltdm)
                    ^^^^^^^^^^
Patch introduces new check.

   106			if (!arch_pwrdm->pwrdm_has_voltdm())
   107				goto skip_voltdm;
   108	
   109		voltdm = voltdm_lookup(pwrdm->voltdm.name);
   110		if (!voltdm) {
   111			pr_err("powerdomain: %s: voltagedomain %s does not exist\n",
   112			       pwrdm->name, pwrdm->voltdm.name);
   113			return -EINVAL;
   114		}
   115		pwrdm->voltdm.ptr = voltdm;
   116		INIT_LIST_HEAD(&pwrdm->voltdm_node);
   117		voltdm_add_pwrdm(voltdm, pwrdm);
   118	skip_voltdm:
   119		spin_lock_init(&pwrdm->_lock);
   120	
   121		list_add(&pwrdm->node, &pwrdm_list);
   122	
   123		/* Initialize the powerdomain's state counter */
   124		for (i = 0; i < PWRDM_MAX_PWRSTS; i++)
   125			pwrdm->state_counter[i] = 0;
   126	
   127		pwrdm->ret_logic_off_counter = 0;
   128		for (i = 0; i < pwrdm->banks; i++)
   129			pwrdm->ret_mem_off_counter[i] = 0;
   130	
   131		arch_pwrdm->pwrdm_wait_transition(pwrdm);
                ^^^^^^^^^^^^
Existing unchecked dereference.

   132		pwrdm->state = pwrdm_read_pwrst(pwrdm);
   133		pwrdm->state_counter[pwrdm->state] = 1;

regards,
dan carpenter
