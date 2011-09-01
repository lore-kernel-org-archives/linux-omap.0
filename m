From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 03/10] OMAP4: DSS: HDMI: Use specific HDMI timings
 structure
Date: Thu, 01 Sep 2011 11:14:21 +0300
Message-ID: <1314864861.2169.4.camel@lappyti>
References: <1314598500-24005-1-git-send-email-mythripk@ti.com>
	 <1314598500-24005-2-git-send-email-mythripk@ti.com>
	 <1314598500-24005-3-git-send-email-mythripk@ti.com>
	 <1314598500-24005-4-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:47652 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755569Ab1IAIO3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 04:14:29 -0400
Received: by bkat2 with SMTP id t2so2614322bka.21
        for <linux-omap@vger.kernel.org>; Thu, 01 Sep 2011 01:14:26 -0700 (PDT)
In-Reply-To: <1314598500-24005-4-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org

On Mon, 2011-08-29 at 11:44 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
> 
> Define new HDMI timings structure to replace the OMAP DSS timing strucutre in
> hdmi.c to have the HDMI include defintion out of DSS.

structure and definition typoed. And the point is not to remove hdmi
stuff from dss, but dss stuff from hdmi. The generic hdmi driver cannot
use omap dss specific stuff.

> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  drivers/video/omap2/dss/hdmi.c |   22 +++++++++++++++++++---
>  drivers/video/omap2/dss/hdmi.h |   15 ++++++++++++++-
>  2 files changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
> index 084a47e..ba1ad06 100644
> --- a/drivers/video/omap2/dss/hdmi.c
> +++ b/drivers/video/omap2/dss/hdmi.c
> @@ -537,6 +537,20 @@ static int read_edid(struct hdmi_ip_data *ip_data, u8 *pedid, u16 max_length)
>  	return 0;
>  }
>  
> +static void copy_hdmi_to_dss_timings(struct hdmi_video_timings hdmi_timings,
> +			struct omap_video_timings *timings)

Pass hdmi_timings as a const pointer.

 Tomi


