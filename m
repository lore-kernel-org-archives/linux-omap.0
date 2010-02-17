From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH  0/24] omap4 for 2.6.34
Date: Wed, 17 Feb 2010 10:46:44 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF82A2@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF80C3@dbde02.ent.ti.com>
 <20100216190257.GP21755@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54144 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750809Ab0BQFRF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 00:17:05 -0500
In-Reply-To: <20100216190257.GP21755@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ben Dooks <ben@fluff.org.uk>, Samuel Ortiz <sameo@linux.intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony,

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Wednesday, February 17, 2010 12:33 AM
> To: Shilimkar, Santosh
> Cc: Ben Dooks; Samuel Ortiz; Kevin Hilman; Paul Walmsley; lrg@slimlogic.co.uk; linux-
> omap@vger.kernel.org
> Subject: Re: [PATCH 0/24] omap4 for 2.6.34
> 
> Hi,
> 
> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [100216 07:33]:
> > Tony,
> > Here are some patches towards upcoming 34 merge window. They are generated against
> > linux-omap master as you suggested.
> >
> > I am also copying Ben, Samuel, Liam, Paul and Kevin since some of the changes
> > are in mfd, regulator, i2c and clocks.
> 
> Thanks. Can you please split this into several smaller sets?
> 
> 1. Core omap changes done against linux-omap master branch
>    Send to linux-omap list with linux-arm-kernel Cc'd.
ok 
> 2. Clock framework dummy_ck changes done against linux-omap master branch.
>    This should leave out most of the driver changes in your series.
>    Send to linux-omap list with linux-arm-kernel Cc'd.
Will do. Some clock node names are changed and since we do clk_get based on clock node
names, such drivers need to change. 
> 3. I2C changes against done against 2.6.33-rc8 + "Add support for 16-bit registers"
>    Send to Ben and i2c list with linux-omap list Cc'd.
ok
> 4. MFD changes done against 2.6.33-rc8
>    Send to Samuel with linux-omap list Cc'd.
Sounds good.
I sent this series just to ensure that we all are aligned on
dependancies and also just to highlight that all of these 
should get merged together.

Thanks for feedback.

Regards,
Santosh
