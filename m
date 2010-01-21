From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] OMAP CPU ID: fix OMAP4 build failure
Date: Wed, 20 Jan 2010 22:06:14 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001202205510.24456@utopia.booyaka.com>
References: <alpine.DEB.2.00.1001191412130.3977@utopia.booyaka.com> <EAF47CD23C76F840A9E7FCE10091EFAB02C07CC987@dbde02.ent.ti.com> <alpine.DEB.2.00.1001202008530.3977@utopia.booyaka.com> <alpine.DEB.2.00.1001202025410.3977@utopia.booyaka.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C07CCEB1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33145 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846Ab0AUFGO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jan 2010 00:06:14 -0500
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C07CCEB1@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Pagare, Abhijit" <abhijitpagare@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, 21 Jan 2010, Shilimkar, Santosh wrote:

> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Paul
> > Walmsley
> > 
> > I guess the rollup should probably be CHIP_IS_OMAP44XX.  Do you happen to
> > know whether software will be able to discriminate between 4430 and 4440
> > chips at run-time, and if so, what mechanism to use?
> ID_CODE would be different which can be used for this.

Okay, great.

- Paul
