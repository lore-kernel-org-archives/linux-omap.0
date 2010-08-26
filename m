From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 08/10] OMAP4: Smartreflex framework extensions
Date: Thu, 26 Aug 2010 10:42:53 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C68544CB@dbde02.ent.ti.com>
References: <1282130191-9062-1-git-send-email-thara@ti.com>
	<1282130191-9062-9-git-send-email-thara@ti.com>
 <8762yy9tib.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44683 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752816Ab0HZFNA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Aug 2010 01:13:00 -0400
In-Reply-To: <8762yy9tib.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Thursday, August 26, 2010 4:42 AM
> To: Gopinath, Thara
> Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Sripathy, Vishwanath;
> Sawant, Anand; Cousson, Benoit
> Subject: Re: [PATCH 08/10] OMAP4: Smartreflex framework extensions
> 
> Thara Gopinath <thara@ti.com> writes:
> 
> > This patch extends the smartreflex framework to support
> > OMAP4. The changes are minor like compiling smartreflex Kconfig
> > option for OMAP4 also, and a couple of OMAP4 checks in
> > the smartreflex framework.
> >
> > The change in sr_device.c where new logic has to be introduced
> > for reading the efuse registers are due to two reasons.
> > 	a. Currently in mainline OMAP4 control base offset is actually
> > 	from the mux/padconf module start. Hence a omap_ctrl_read will
> > 	not read from the correct offset for the efuse registers.
> > 	This is currently being fixed through modfications in the
> > 	control layer but till that is finalised, we will have to do
> > 	a ioremap of the general control module  base and do a
> > 	__raw_read to retrieve the efuse values.
> 
> Is this the series posted by Santosh?
> 
>    [PATCH 0/4] omap4: Control module series
> 
Yep. This series should address the SR control module
issue

Regards,
Santosh
