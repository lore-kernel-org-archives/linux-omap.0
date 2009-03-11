From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: Hello Tomi Valkeinen, I have some questions about dss2 driver.
Date: Wed, 11 Mar 2009 09:47:21 +0200
Message-ID: <1236757641.12797.16.camel@tubuntu>
References: <90b950fc0903102157q21dec037m65edee4afe104d6a@mail.gmail.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:61855 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbZCKHrf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 03:47:35 -0400
In-Reply-To: <90b950fc0903102157q21dec037m65edee4afe104d6a@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext InKi Dae <daeinki@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Wed, 2009-03-11 at 05:57 +0100, ext InKi Dae wrote:
> I am using your dss2 driver downloaded from your git server and tried
> to rotate an image(RGB24U and YUV2 format) using OMAPFB_ROT_DMA
> command.
> but I can't see rotated image on screen. I added variables for
> rotating like below. as the result, LCD Panel is stoped.
> 
> omapfb.rotate=2
> omapfb.vrfb=n
> 
> 
> and then I tried again using OMAPFB_ROT_VRFB command like below.
> 
> omapfb.rotate=2
> omapfb.vrfb=y
> 
> In this case, I can see rotated image(only RGB24U format) on screen.
> You asid "Rotation and mirroring currently only supports RGB565 and
> RGB8888 modes. VRFB does not support mirroring" through
> /Documentation/arm/OMAP/DSS file.
> 
> Doesn't your dss2 driver support DMA rotation?

It does. However, you should use DMA rotation only with OMAP2 when the
framebuffer is in SRAM. It seems to work somewhat on OMAP3 and SDRAM,
but I've noticed it doesn't always work. I don't know if lowering pixel
clock, increasing dss fck or fiddling with fifo sizes could affect it.

> I am trying to add rotation feature for YUV2 image using VRFB to your
> dss2 driver.
> 
> for this, I think that it have to change rot and mirror become 0 if
> rotation_type is OMAPFB_ROT_VRFB to be rot=ofbi->rotation and mirror =
> ofbi->mirror (in omapfb-main.c file) and
> add codes for calculating offset0, offset1, pixel increment and row
> increment value for YUV2 format also pixel size becomes 4 in YUV2 case
> (in dispc.c fild).
> omap_vrfb_setup function must be modifed also (in vrfb.c file)?
> 
> Do you have any idea?

No, I haven't really looked at YUV rotations.

 Tomi

> I need your help and advice.
> 
> Thank you.
> - InKi-

