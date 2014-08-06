From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: TSC2004 driver
Date: Wed, 6 Aug 2014 12:37:27 -0700
Message-ID: <20140806193727.GB24718@core.coreip.homeip.net>
References: <20140805170640.GA8830@sysresccd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:57894 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754006AbaHFThb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Aug 2014 15:37:31 -0400
Content-Disposition: inline
In-Reply-To: <20140805170640.GA8830@sysresccd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Welling <mwelling@emacinc.com>
Cc: linux-omap@vger.kernel.org, linux-input@vger.kernel.org, hvaibhav@ti.com

Hi Michael,

On Tue, Aug 05, 2014 at 12:06:40PM -0500, Michael Welling wrote:
> The TSC2004 driver has yet to appear in the mainline kernel. We have
> been using the driver referenced here as provided by TI:
> 
> https://www.mail-archive.com/linux-omap@vger.kernel.org/msg22018.html
> 
> Are there any plans of supporting this device in the mainline kernel?

I still believe that support for TSC2004 should be added 5to tsc2007, they are
too much alike to be separate drivers.

> 
> Mysteriously a device tree entry was found in the following file:
> arch/arm/boot/dts/omap4-var-som-om44.dtsi
> 
> This is obviously pointing to an out of tree driver that is not easily
> obtained.
> 
> Suggestions?

Thanks.

-- 
Dmitry
