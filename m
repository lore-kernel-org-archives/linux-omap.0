From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: ZOOM2 doesn't boot on upstream kernel
Date: Fri, 25 Jun 2010 10:40:22 -0500
Message-ID: <A24693684029E5489D1D202277BE894456224D59@dlee02.ent.ti.com>
References: <AANLkTilypMkwLYcpFCI5ZwSKOGHIAwDI7Bp9IdN9UAv_@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030DED31F3@dbde02.ent.ti.com>
 <AANLkTikkCeusIKA2KyRcVWbxVXKmLA8-_RfC2A4u3ySM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50719 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750975Ab0FYPk0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jun 2010 11:40:26 -0400
In-Reply-To: <AANLkTikkCeusIKA2KyRcVWbxVXKmLA8-_RfC2A4u3ySM@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Neshama Parhoti <pneshama@gmail.com>, "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Pnesh,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Neshama Parhoti
> Sent: Friday, June 25, 2010 9:06 AM
> To: Ghorai, Sukumar
> Cc: linux-omap@vger.kernel.org
> Subject: Re: ZOOM2 doesn't boot on upstream kernel
> 
> On Wed, Jun 23, 2010 at 4:03 PM, Ghorai, Sukumar <s-ghorai@ti.com> wrote:
> > [Ghorai] It's working for me.
> 
> it's good to hear !
> 
> This is what I see:
> 
> ## Booting image at 81c00000 ...
>    Image Name:   Linux-2.6.35-rc3-00001-g945a7eb
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    2409672 Bytes =  2.3 MB
>    Load Address: 80008000
>    Entry Point:  80008000
>    Verifying Checksum ... OK
> OK
> 
> Starting kernel ...
> 
> Uncompressing Linux... done, booting the kernel.
> 
> (and then nothing happens, you don't even see the penguin on the screen)
> 
> > 1. console=ttyS0
> 
> are you sure ?  all TI's docs state ttyS2 (and this works for me with
> TI's BSP kernels)
> 
> but since I don't see the penguin on the screen, I don't think this is
> the problem

The penguin on the screen won't come up, since I don't think that the nec panel drivers for DSS2 has been merged in mainline.

The latest patch to get this driver is found here:

https://patchwork.kernel.org/patch/101435/

Regards,
Sergio

<snip>
