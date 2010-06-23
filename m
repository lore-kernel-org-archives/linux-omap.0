From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: ZOOM2 doesn't boot on upstream kernel
Date: Wed, 23 Jun 2010 18:33:04 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030DED31F3@dbde02.ent.ti.com>
References: <AANLkTilypMkwLYcpFCI5ZwSKOGHIAwDI7Bp9IdN9UAv_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42991 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611Ab0FWNDN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jun 2010 09:03:13 -0400
In-Reply-To: <AANLkTilypMkwLYcpFCI5ZwSKOGHIAwDI7Bp9IdN9UAv_@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Neshama Parhoti <pneshama@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Neshama Parhoti
> Sent: Wednesday, June 23, 2010 12:12 AM
> To: linux-omap@vger.kernel.org
> Subject: ZOOM2 doesn't boot on upstream kernel
> 
> Hi all,
> 
> I can't get to boot the latest mainline kernel on ZOOM2 (using
> omap_zoom2_defconfig).
[Ghorai] It's working for me. 
1. console=ttyS0
2. And can you try omap3_defconfig

> 
> It just hangs after u-boot is saying "loading kernel...".
> 
> I know that my setup is ok, because if I use TI kernel sources from my
> BSP it boots fine..
> 
> Any idea what is the problem ?
> 
> Maybe I need to use also recent upstream u-boot ?
> 
> thank you
> ~pnesh
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
