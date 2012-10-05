From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/9] ARM: dts/OMAP: Pinmux audio configuration for
 OMAP4+
Date: Fri, 5 Oct 2012 16:03:55 -0700
Message-ID: <20121005230354.GS3874@atomide.com>
References: <1349351848-12972-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:16155 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752242Ab2JEXD6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Oct 2012 19:03:58 -0400
Content-Disposition: inline
In-Reply-To: <1349351848-12972-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [121004 04:57]:
> Hello,
> 
> u-boot recently stopped configuring 'non essential' pin mux. This change leaves
> the audio essential pins in non configured state which prevents the use of audio.
> The following series makes sure that the needed pins are configured correctly by
> the kernel on OMAP4 and OMAP5.
> 
> Tony: can this series queued for 3.7?

Let's see if that's possible to avoid mysterious bug reports
of things not working.

If we can't merge it, then it might be worth adding a warning
that bails out early after some pin is checked or similar.

Regards,

Tony
 
> Regards,
> Peter
> ---
> Peter Ujfalusi (9):
>   ARM: OMAP: board-4430-sdp: Pin mux configuration for audio needs
>   ARM: OMAP: board-omap4panda: Pin mux configuration for audio needs
>   ARM/dts: omap4-panda: Disable unused audio IPs
>   ARM/dts: omap4-sdp: Disable unused McBSP3
>   ARM/dts: omap5-evm: Disable unused McBSP3
>   ARM/dts: omap4-sdp: pinmux configuration for audio
>   ARM/dts: omap4-panda: pinmux configuration for audio
>   ARM/dts: Add pinctrl driver entries for omap5
>   ARM/dts: omap5-evm: pinmux configuration for audio
> 
>  arch/arm/boot/dts/omap4-panda.dts      | 47 +++++++++++++++++++++++++++
>  arch/arm/boot/dts/omap4-sdp.dts        | 57 +++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/omap5-evm.dts        | 58 ++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/omap5.dtsi           | 17 ++++++++++
>  arch/arm/mach-omap2/board-4430sdp.c    | 26 +++++++++++++++
>  arch/arm/mach-omap2/board-omap4panda.c | 15 +++++++++
>  6 files changed, 220 insertions(+)
> 
> -- 
> 1.7.12
> 
