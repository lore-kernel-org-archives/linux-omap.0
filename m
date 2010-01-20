From: "Pagare, Abhijit" <abhijitpagare@ti.com>
Subject: RE: [PATCH] OMAP CPU ID: fix OMAP4 build failure
Date: Wed, 20 Jan 2010 14:14:04 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C07CCA5A@dbde02.ent.ti.com>
References: <alpine.DEB.2.00.1001191412130.3977@utopia.booyaka.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C07CC987@dbde02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C07CC9A7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42400 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751122Ab0ATIoS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jan 2010 03:44:18 -0500
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C07CC9A7@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Santosh,

> -----Original Message-----
> From: Shilimkar, Santosh
> Sent: Wednesday, January 20, 2010 12:52 PM
> To: Pagare, Abhijit; Paul Walmsley; Pagare, Abhijit
> Cc: tony@atomide.com; linux-omap@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: RE: [PATCH] OMAP CPU ID: fix OMAP4 build failure
> 
> Abhijit,
> 
> <snip>
> 
> > I had used this flag earlier as there was nothing fixed as to name it as
> ES1 that time. So now it can
> > be migrated from CHIP_IS_OMAP4430 to CHIP_IS_OMAP4430ES1. I think
> CHIP_IS_OMAP4430 would be redundant
> > in that case and should be removed. A patch would be essential to take
> care of that in the places
> > where it is used. If you feel the same I can send a patch for fixing
> this.
> >
> 
> Tony has already created the patch. Please use that and test it on OMAP4.

I will test it on OMAP4 but my point was as follows,

The patch that is sent has both the definitions of CHIP_IS_OMAP4430 and CHIP_IS_OMAP4430ES1 where the later is initialized with the former's value. I was actually wondering why the former is required anyways. It is a redundant thing and can be replaced totally.

> 
> Regards,
> Santosh
