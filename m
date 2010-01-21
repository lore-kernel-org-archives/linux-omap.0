From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH 6/8] OMAP3 PM: Enable DPLL4 autoidle after system off.
Date: Thu, 21 Jan 2010 12:31:19 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB031E3F0BD5@dbde02.ent.ti.com>
References: <1264001442-20078-1-git-send-email-thara@ti.com>
 <1264001442-20078-2-git-send-email-thara@ti.com>
 <1264001442-20078-3-git-send-email-thara@ti.com>
 <1264001442-20078-4-git-send-email-thara@ti.com>
 <1264001442-20078-5-git-send-email-thara@ti.com>
 <1264001442-20078-6-git-send-email-thara@ti.com>
 <1264001442-20078-7-git-send-email-thara@ti.com>
 <alpine.DEB.2.00.1001201033120.3977@utopia.booyaka.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB031E3F0B49@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1001202236150.24456@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57293 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670Ab0AUHB0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jan 2010 02:01:26 -0500
In-Reply-To: <alpine.DEB.2.00.1001202236150.24456@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



Hi Paul,
>>
>>That may change depending on device wakeup latency constraints.  If a
>>device has a low wakeup latency, we may choose to keep a DPLL running.
>>Sometimes this is also changed to work around silicon bugs.  So we should
>>avoid adding code that makes assumptions about any of those autoidle bits.
>>
>>> Why I had to make this unconditional is because later before core
>>> entering OSWR I explicitly disable this bit in the register. This is so
>>> as to match this register content with those of scratchpad during OSWR.
>>> Failing to do this rom code while exiting OSWR will take the path it
>>> takes while coming out of core off . This causes a crash in the system
>>> today.
>>
>>Fine, but can't you save the previous state of the DPLL autoidle with
>>omap3_dpll_autoidle_read() before you disable it prior to OSWR, and just
>>restore it afterwards?
>>
>>> Also another reason is omap3_prcm_save_context needs to be called
>>> only during core off today.
>>
>>Is this because the CM registers are part of the logic section of the CORE
>>powerdomain?

This is because CM module is built with Retention flip flops(RFF) and during OSWR the voltage is still supplied to the logic built with RFF. Thus no content loss.

>>
>>> If I move saving of this bit and restoring it back into
>>> omap3_prcm_save_context and omap3_prcm_restore_context I will have to
>>> call it during core OSWR also.
>>
>>If you're not calling those now for OSWR, you shouldn't have to call them
>>just to save and restore the DPLL4 autoidle state, right?  Wouldn't it
>>work to simply read the current autoidle state with
>>omap3_dpll_autoidle_read() before entering OSWR, then restore it
>>afterwards with omap3_dpll_{allow,deny}_idle() ?
>>
>>> Wanted to avoid the extra complications.
>>
>>And the extra delay.  Reads and writes from L4_WAKEUP-connected devices
>>are sllloooooowwwww.

Agreed.
>>
>>> But if this approach is not ok, I can modify the save restore APIs to
>>> take power state as a parameter and do only dpll4 autoidle save and
>>> restore in case of OSWR. Is this ok?
>>
>>Well, let me know what you think of the above...

I am ok with this. Only thing is it will involve a clk_get("dpll4_clk") and then rest of the API calls as you have suggested. Considering this is in cpuidle path, will the latencies be high?
If we have a latency issue, we can still keep the logic same as you have suggested and instead of dpll api's directly use CM API's to implement the same. So use cm_read_mod_reg and cm_rmw_mod_reg_bits.

Regards
Thara
