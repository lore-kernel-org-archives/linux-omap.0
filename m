From: Nishanth Menon <nm@ti.com>
Subject: Re: OMAP DSS2 coming out of OFF mode without restoring context
Date: Fri, 30 Jul 2010 08:01:26 -0500
Message-ID: <4C52CD26.8010908@ti.com>
References: <1280488167.6035.5.camel@Nokia-N900> <1280488679.2427.121.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39079 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756427Ab0G3NBc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Jul 2010 09:01:32 -0400
In-Reply-To: <1280488679.2427.121.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: ext Laine Walker-Avina <lwalkera@pasco.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Tomi Valkeinen had written, on 07/30/2010 06:17 AM, the following:
> On Fri, 2010-07-30 at 13:09 +0200, ext Menon, Nishanth wrote:
>> ----- Original message -----
>>> Hi,
>>>
>>> On Thu, 2010-07-29 at 23:29 +0200, ext Laine Walker-Avina wrote:
>>>> Hi,
>>>>
>>>> I'm having a problem where the DSS driver isn't restoring the
>>>> framebuffer parameters after going in and out of blanking with OFF
>>>> mode enabled. The problem appears to be in dss_get_ctx_id() in that
>>>> pdata->get_last_off_on_transaction_id is 0. Commenting out the call to
>>>> dss_need_ctx_restore() in dss_clk_enable() appears to do the right
>>>> thing. I'm using the current master branch of linux-omap.
>>> You need to fill the func pointer in the board file:
>>>
>>> static struct omap_dss_board_info xxx_dss_data = {
>>>                 .get_last_off_on_transaction_id =
>>> omap_pm_get_dev_context_loss_count,
>>>
>> none of l-o board files seem to do this. I guess
>> with off capable master, we need this to be 
>> defaulted under CONFIG_PM within dss/core itself?
>> I mean the defaults prevent display function
>> at off, so why ask all boards to fill it up?
> 
> If the PM stuff in linux tree starts to be in working order, then yes,
> we need some better solution.
> 
> I'm not quite sure what the options are, but I was told that the correct
> way to get context loss count is as above, fill the platform_data in the
> board file with a pointer to omap_pm_get_dev_context_loss_count().
> 
> So if that is still the proper way, then we need a "DSS platform
> initialization" function that the board files can call, which then fills
> the platform_data with correct data.
> 
> But this will still require modifying every board file that uses DSS.
> Then again, every board file needs anyway DSS code, so perhaps that's
> not such a big issue.
> 
> For this particular case there's not much benefit having a separate
> initialization function. On the contrary, it'll just have more code
> lines. But I think there will be some more platform DSS stuff (like
> pinmuxing) which can then use the same mechanism.
> 
>  Tomi
> 
> 

I was thinking more of the lines of this:
a) omap_pm_get_dev_context_loss_count is exported
OR
b) there is a file arch/arm/mach-omap2/dss.c which would take this..


diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index b3a498f..0b9041a 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -35,6 +35,7 @@

  #include <plat/display.h>
  #include <plat/clock.h>
+#include <plat/omap-pm.h>

  #include "dss.h"

@@ -502,6 +503,10 @@ static int omap_dss_probe(struct platform_device *pdev)

         core.pdev = pdev;

+       if (!core.pdev->get_last_off_on_transaction_id)
+               core.pdev->get_last_off_on_transaction_id =
+                       omap_pm_get_dev_context_loss_count;
+
         dss_init_overlay_managers(pdev);
         dss_init_overlays(pdev);



-- 
Regards,
Nishanth Menon
