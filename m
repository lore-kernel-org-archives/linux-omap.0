From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 6/8] OMAP3 PM: Enable DPLL4 autoidle after system off.
Date: Thu, 21 Jan 2010 00:12:31 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001210008190.24456@utopia.booyaka.com>
References: <1264001442-20078-1-git-send-email-thara@ti.com> <1264001442-20078-2-git-send-email-thara@ti.com> <1264001442-20078-3-git-send-email-thara@ti.com> <1264001442-20078-4-git-send-email-thara@ti.com> <1264001442-20078-5-git-send-email-thara@ti.com>
 <1264001442-20078-6-git-send-email-thara@ti.com> <1264001442-20078-7-git-send-email-thara@ti.com> <alpine.DEB.2.00.1001201033120.3977@utopia.booyaka.com> <5A47E75E594F054BAF48C5E4FC4B92AB031E3F0B49@dbde02.ent.ti.com> <alpine.DEB.2.00.1001202236150.24456@utopia.booyaka.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB031E3F0BD5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57298 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533Ab0AUHMc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jan 2010 02:12:32 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB031E3F0BD5@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Thu, 21 Jan 2010, Gopinath, Thara wrote:

> >>> But if this approach is not ok, I can modify the save restore APIs to
> >>> take power state as a parameter and do only dpll4 autoidle save and
> >>> restore in case of OSWR. Is this ok?
> >>
> >>Well, let me know what you think of the above...
> 
> I am ok with this. Only thing is it will involve a clk_get("dpll4_clk") 
> and then rest of the API calls as you have suggested. Considering this 
> is in cpuidle path, will the latencies be high?

How about doing the clk_get() in advance in omap3_pm_init(), and store the 
struct clk pointer in a static variable that can be referenced from the 
cpuidle path?

> If we have a latency issue, we can still keep the logic same as you have 
> suggested and instead of dpll api's directly use CM API's to implement 
> the same. So use cm_read_mod_reg and cm_rmw_mod_reg_bits.

We could but let's try the DPLL API first.  I doubt the difference between 
using the DPLL API and using the cm_* functions will be measurable.  If 
you look at the code for those functions, there's not much to them.


- Paul
