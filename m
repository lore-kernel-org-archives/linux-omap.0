From: Peter Barada <peterb@logicpd.com>
Subject: linux-2.6.28-rc8 wedges in twl_mmc_set_voltage()...
Date: Thu, 03 Dec 2009 12:57:47 -0500
Message-ID: <1259863067.2066.38.camel@thunk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:4848 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753061AbZLCR5n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 12:57:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

I've run across a semi-consistent (~15%) hang on Logic's omap3530 LV SOM
running a 2.6.28-rc8 omap kernel where it dies in twl_mmc_set_voltage().
Adding in printk's perturbs the frequency of failure, but it
consistently dies on the same call. I've added the following
printk's(and others) in twl_mmc_set_voltage() to straddle the failure:

 	printk("%s: dev_grp_val 0x%x vmmc_dev_grp 0x%x\n", __FUNCTION__, dev_grp_val, c->twl_vmmc_dev_grp);

	ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
					dev_grp_val, c->twl_vmmc_dev_grp);
	printk("%s:%d ret %d\n", __FUNCTION__, __LINE__, ret);
	if (ret)
		return ret;

When it dies, I consistently see the first printk, but not the 2nd after
returning from twl4030_i2c_write_u8().  The log (when it dies) looks
like:

cpuidle: using governor ladder                                                  
cpuidle: using governor menu                                                    
mmci-omap-hs mmci-omap-hs.0: mmc_fclk: enabled                                  
mmci-omap-hs mmci-omap-hs.0: Failed to get debounce clock                       
omap_mmc_probe:1180                                                             
twl_mmc1_set_power: slot 0 power_on 0 vdd 0                                     
twl_mmc1_set_power:294                                                          
twl_mmc_set_voltage: vdd 0                                                      
twl_mmc_set_voltage: dev_grp_val 0x0 vmmc_dev_grp 0x27                          


What's really weird is that Sysrq won't tell me anything after its died.
As a result I'm really stumped on trying to figure out what's gone
wrong.

Has anyone stumbled across this before or have any ideas on how I can
debug this further?  I'm currently using the CodeSourcery 2009q1-203
compiler.

Thanks in advance!

-- 
Peter Barada <peterb@logicpd.com>
Logic Product Development, Inc.
