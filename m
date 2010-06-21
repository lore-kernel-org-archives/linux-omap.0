From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH 04/13 v3] OMAP: GPIO: Introduce support for OMAP15xx
 chip GPIO init
Date: Mon, 21 Jun 2010 16:22:45 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5C92856@dbde02.ent.ti.com>
References: <1276614348-5201-1-git-send-email-charu@ti.com>
	<1276614348-5201-2-git-send-email-charu@ti.com>
	<1276614348-5201-3-git-send-email-charu@ti.com>
	<1276614348-5201-4-git-send-email-charu@ti.com>
	<1276614348-5201-5-git-send-email-charu@ti.com>
 <87hbl1mmqw.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45208 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757749Ab0FUKxI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jun 2010 06:53:08 -0400
In-Reply-To: <87hbl1mmqw.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "david-b@pacbell.net" <david-b@pacbell.net>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>

 

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Friday, June 18, 2010 1:54 AM
> To: Varadarajan, Charulatha
> Cc: david-b@pacbell.net; broonie@opensource.wolfsonmicro.com; 
> akpm@linux-foundation.org; linux-omap@vger.kernel.org; 
> paul@pwsan.com; Nayak, Rajendra; Cousson, Benoit; tony@atomide.com
> Subject: Re: [PATCH 04/13 v3] OMAP: GPIO: Introduce support 
> for OMAP15xx chip GPIO init
> 
> "Varadarajan, Charulatha" <charu@ti.com> writes:
> 
> > From: Charulatha V <charu@ti.com>
> >
> > This patch adds support for handling OMAP15xx specific gpio_init
> > by providing platform device data and doing device registration.
> >
> > Signed-off-by: Charulatha V <charu@ti.com>
> > ---
> >  arch/arm/mach-omap1/gpio15xx.c |  102 
> ++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 102 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/mach-omap1/gpio15xx.c
> >
> > diff --git a/arch/arm/mach-omap1/gpio15xx.c 
> b/arch/arm/mach-omap1/gpio15xx.c
> > new file mode 100644
> > index 0000000..e4f1738
> > --- /dev/null
> > +++ b/arch/arm/mach-omap1/gpio15xx.c
> > @@ -0,0 +1,102 @@
> > +/*
> > + * gpio15xx.c - OMAP15XX-specific gpio code
> 
> Minor detail, but you don't need the filename here.

Okay. 

> 
> Kevin
> 