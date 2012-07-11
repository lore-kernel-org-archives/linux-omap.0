From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 2/3] usb: musb: dsps: add phy control logic to glue
Date: Wed, 11 Jul 2012 07:03:30 +0000
Message-ID: <47CEF8C4B26E8C44B22B028A650E0EA93EACFBE1@DBDE01.ent.ti.com>
References: <47CEF8C4B26E8C44B22B028A650E0EA93EACDFFF@DBDE01.ent.ti.com>
 <BF1B1853A762164888C918AB089265E4282B4C@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49722 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754251Ab2GKHFU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jul 2012 03:05:20 -0400
In-Reply-To: <BF1B1853A762164888C918AB089265E4282B4C@DBDE01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Santhapuri, Damodar" <x0132156@ti.com>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,
> > > >> On Mon, Jul 9, 2012 at 7:18 PM, Damodar Santhapuri
> <x0132156@ti.com>
[...]
> > > >> Avoid getting resource by name.. With dt, you wont be able to do
> > > >> those..
> > > >
> > > > When we are completely on DT then this would anyways go and we
> can
> > > > get these resource data for each usb port from DT APIs.
> > >
> > > Even with dt, you will still get the resources using
> > > platform_get_resource() API's.. So why not have it that way from
> the
> > > beginning itself..
> >
> > Ok got it. We will post an updated patch.
> 
> Plalform_get_resource api works fine if we hardcode 3rd argument to
> 3+id for usb_cntrl register Since dsps_create_musb_pdev calls for each
> wrp->instances.
> 
> static int __devinit dsps_create_musb_pdev(struct dsps_glue *glue, u8
> id)
> {
> 	....
> 	....
>         /* get memory resource for usb control register */
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 3+id);
>         dev_err(dev,"Damodar :usb ctrl%d res=%x\n",id,res->start);
>         if (!res) {
>                 dev_err(dev, "%s get mem resource failed\n", res_name);
>                 ret = -ENODEV;
>                 goto err0;
>         }
> ....
> }

You can place the memory resources as 
{{usbss, .}, {musb0, .}, {usb0_ctrl, .}, {musb1, .}, {usb1_ctrl, .}}

and then use index as "2 * id + 2" to get the usbX_ctrl base address.

Ajay
> 
> Damodar.
> >
> > Ajay
> > >
> > > Thanks
> > > Kishon
