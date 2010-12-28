From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 5/5] MAP4: DMIC: Add DMIC codec platform devices
Date: Tue, 28 Dec 2010 13:23:25 +0200
Message-ID: <20101228112325.GC2239@legolas.emea.dhcp.ti.com>
References: <1293509826-23253-1-git-send-email-dlambert@ti.com>
 <1293509826-23253-6-git-send-email-dlambert@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:36208 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750966Ab0L1LXe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Dec 2010 06:23:34 -0500
Received: by ewy8 with SMTP id 8so4574410ewy.3
        for <linux-omap@vger.kernel.org>; Tue, 28 Dec 2010 03:23:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1293509826-23253-6-git-send-email-dlambert@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Lambert <dlambert@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

Hi,

$SUBJECT should read OMAP4 instead of MAP4

On Mon, Dec 27, 2010 at 10:17:06PM -0600, David Lambert wrote:
>This creates the DMIC codec platform devices.
>
>The platform devices create an instance of the driver during boot up.
>
>Signed-off-by: David Lambert <dlambert@ti.com>

is this a "virtual" device ? If not, where's HWMOD for it ?

>diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
>index df5a425..bf271e5 100644
>--- a/arch/arm/mach-omap2/board-4430sdp.c
>+++ b/arch/arm/mach-omap2/board-4430sdp.c
>@@ -505,6 +505,16 @@ static void __init omap_sfh7741prox_init(void)
> 	}
> }
>
>+static struct platform_device codec_dmic0 = {
>+	.name   = "dmic-codec",
>+	.id     = 0,

if this is the only device, should id be -1 instead ?

>+};
>+
>+static inline void omap_dmic_init(void)
>+{
>+	platform_device_register(&codec_dmic0);

Another option would be to use
platform_device_register_simple("dmi-codec", -1);

-- 
balbi
