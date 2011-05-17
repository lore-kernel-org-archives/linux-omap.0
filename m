From: Steve Calfee <stevecalfee@gmail.com>
Subject: Re: [PATCH 1/2] OMAP4: HDMI: Add OMAP device for HDMI audio CPU DAI
Date: Tue, 17 May 2011 12:35:09 -0700
Message-ID: <4DD2CDED.6090605@gmail.com>
References: <1305602079-3852-1-git-send-email-ricardo.neri@ti.com> <1305602079-3852-2-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:50578 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932111Ab1EQTfN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 May 2011 15:35:13 -0400
Received: by pvg12 with SMTP id 12so378456pvg.19
        for <linux-omap@vger.kernel.org>; Tue, 17 May 2011 12:35:13 -0700 (PDT)
In-Reply-To: <1305602079-3852-2-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, b-cousson@ti.com, paul@pwsan.com

On 05/16/11 20:14, Ricardo Neri wrote:

> +++ b/arch/arm/mach-omap2/devices.c
> @@ -313,6 +313,22 @@ OMAP_MCBSP_PLATFORM_DEVICE(5);
>  
>  static void omap_init_audio(void)
>  {
> +	struct omap_hwmod *oh_hdmi;
> +	struct omap_device *od_hdmi;
> +	char *oh_hdmi_name = "dss_hdmi";
> +	char *dev_hdmi_name = "hdmi-audio-dai";
> +
> +	if (cpu_is_omap44xx()) {
> +		oh_hdmi = omap_hwmod_lookup(oh_hdmi_name);
> +		WARN(!oh_hdmi, "%s: could not find omap_hwmod for %s\n",
> +			__func__, oh_hdmi_name);
> +
> +		od_hdmi = omap_device_build(dev_hdmi_name, -1, oh_hdmi, NULL, 0,
> +			NULL, 0, false);
> +		WARN(IS_ERR(od_hdmi), "%s: could not build omap_device for %s\n",
> +			__func__, dev_hdmi_name);
> +	}
> +
>  	platform_device_register(&omap_mcbsp1);
>  	platform_device_register(&omap_mcbsp2);
>  	if (cpu_is_omap243x() || cpu_is_omap34xx() || cpu_is_omap44xx()) {

I know you did not start this, but this cpu_is stuff is cheating. There
is a rule (maybe a guideline, or desire) in the kernel where they try to
minimize #ifdef in c code. So here we have a runtime ifdef. The code
will never be executed on other omap versions, but it takes up space and
obscures the code flow.

I think the generally accepted method of doing stuff like this is to
have the ifdeffery in a header file where a inline code segment is
defined if it applies to the processor being built. If the code does not
apply to the model being built, a null #define is used, which does not
take any space.

Using a conditional inline enables the only source code change for this
file (device.c) being a line where the inline code is called.

Regards, Steve
