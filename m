From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: Does DSS support 24 bits_per_pixel?
Date: Tue, 29 Jul 2008 16:37:24 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C00208A69C1C@dbde02.ent.ti.com>
References: <c656a4d20807282143kb3e36e4p36662d7eda4b1861@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:58682 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755868AbYG2LJr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jul 2008 07:09:47 -0400
In-Reply-To: <c656a4d20807282143kb3e36e4p36662d7eda4b1861@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arun c <arunedarath@mistralsolutions.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> Hi all,
>
> Does omap (2&3) DSS support 24 bit output?
>
> I was trying to enable DVI support for omap2evm(data lines=24, bits
> per pixel =24), I couldn't find
> 24 bit support in omapfb driver(git) and omap24xxfb(linux-2.6.14-omap2-v5).
>
> In TRM its given that it supports 24 BPP. Then why its absent in both
> the drivers?. Does the hardware
> really support 24 bit format?
>
Hardware does support RGB 24 packed and unpacked modes.

In TI code it is implemented in V4L based Video driver and also in FB driver,             omap2_disp_config_gfxlayer selects the bpp and configures DISPC_GFX_ATTRIBUTES register accordingly.

Regards,
Khasim
http://khasim.blogspot.com


