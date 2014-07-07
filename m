From: Andre Heider <a.heider@gmail.com>
Subject: Re: [PATCH 00/13] uio_pruss: add support for devicetree and am33xx
Date: Mon, 7 Jul 2014 10:48:24 +0200
Message-ID: <20140707084824.GA83417@localhost>
References: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:58444 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbaGGIsc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jul 2014 04:48:32 -0400
Content-Disposition: inline
In-Reply-To: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>
Cc: Matt Porter <mporter@linaro.org>, "Hans J . Koch" <hjk@hansjkoch.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Sun, Jun 29, 2014 at 06:21:34PM +0200, Andre Heider wrote:
> Hi,
> 
> this series adds PRUv2 support to uio_pruss through devicetree, makes the
> device usable on am33xx and enables it on beaglebone black.
> Inspired by old patches from Matt Porter found in a downstream tree.
> 
> To archieve that this series:
> * adds a flag to omap_hwmod.c to get PRUSS out of hardreset (patch 5 and 6)
> * adds devicetree support to uio_pruss (patch 7 and 9)
> * adds the device to the am33xx dtsi and boneblack dts (patch 12 and 13)
> 
> Bits and pieces:
> * some cleanup (patch 1-4)
> * take care of a fact that SRAM on am33xx is not exposed through UIO (patch 8)
> * add runtime pm support to enable clocks (patch 10)
> * allow the driver to be compiled on SOC_AM33XX (patch 11)
> 
> This is only tested on beaglebone black (as that's the only hardware of the
> PRUSS enabled families I have) with some basic GPIO and IRQ tests.
> 
> Notes:
> * I just got this hardware and I don't know if this UIO PRUSS business is
>   desired. Looking at the userspace driver I'd guess not so much ;), but this
>   interface is there for older generations anyway, and this small series lets
>   me use the device.
> * is the hardreset thing I did there the right thing to do? I think the
>   proper way would be a reset controller (which apparently doesn't yet exist
>   for this SoC?) and let the driver deassert/assert on probe/remove?
> * the platform device path has a clk_enable() / clk_put() calls. Are those
>   now redundant with the introduced pm_runtime_enable() pm_runtime_disable()
>   calls?

@OMAP guys: any comments? The series depends on patch 5 and 6; both touch
common hwmod code.

I noticed that AM437x now comes with 4 PRUSS cores, maybe you had something
different in mind on how to expose these?

Thanks in advance,
Andre
