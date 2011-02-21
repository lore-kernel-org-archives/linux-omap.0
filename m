From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 5/6] omap4: Initialise the l3 device with the hwmod data.
Date: Tue, 22 Feb 2011 00:33:28 +0530
Message-ID: <295be59bd43a2e9f0961c10263ce19c0@mail.gmail.com>
References: <1298295990-1070-1-git-send-email-santosh.shilimkar@ti.com>
 <1298295990-1070-6-git-send-email-santosh.shilimkar@ti.com> <4D62AAAA.40104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:37018 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753196Ab1BUTDb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Feb 2011 14:03:31 -0500
Received: by mail-qy0-f173.google.com with SMTP id 36so1495490qyk.11
        for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 11:03:30 -0800 (PST)
In-Reply-To: <4D62AAAA.40104@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Sricharan R <r.sricharan@ti.com>

> -----Original Message-----
> From: Cousson, Benoit [mailto:b-cousson@ti.com]
> Sent: Monday, February 21, 2011 11:41 PM
> To: Shilimkar, Santosh
> Cc: linux-omap@vger.kernel.org; Balbi, Felipe; R, Sricharan
> Subject: Re: [PATCH 5/6] omap4: Initialise the l3 device with the
> hwmod data.
>
> On 2/21/2011 2:46 PM, Shilimkar, Santosh wrote:
> > From: sricharan<r.sricharan@ti.com>
> >
> > The l3 interconnect device is build with all the data required
> > to handle the error logging. The data is extracted from the
> > hwmod data base.
> >
> > Signed-off-by: sricharan<r.sricharan@ti.com>
> > Signed-off-by: sricharan<r.sricharan@ti.com>
> > Tested-by: sricharan<r.sricharan@ti.com>
>
> Mmm, I'm not sure the tested-by is meaningfull in your case, since
> you wrote the code and so everybody will assume you tested it.
> One s-o-b should be probably enough.
>

Well he tested whole series including the patch from Felipe.
So a tested-by on whole series doesn't hurt, right ?

Just for record, I have seen tested by applied on whole series
Where as some of the patches in this series are just comment
updates.

> > Cc: Benoit Cousson<b-cousson@ti.com>
> > ---
> >   arch/arm/mach-omap2/devices.c |   23 +++++++++++++++++++++++
> >   1 files changed, 23 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-
> omap2/devices.c
> > index 2d46f55..25fa2ad 100644
> > --- a/arch/arm/mach-omap2/devices.c
> > +++ b/arch/arm/mach-omap2/devices.c
> > @@ -57,6 +57,29 @@ static int __init omap3_l3_init(void)
> >   }
> >   postcore_initcall(omap3_l3_init);
> >
> > +static int __init omap4_l3_init(void)
> > +{
> > +	int l;
> > +	struct omap_hwmod *oh;
> > +	struct omap_device *od;
> > +	char oh_name[12];
> > +
> > +	l = snprintf(oh_name, 12, "l3_main_1");
> > +
> > +	oh = omap_hwmod_lookup(oh_name);
> > +
> > +	if (!oh)
> > +		pr_err("could not look up %s\n", oh_name);
> > +
> > +	od = omap_device_build("omap4-l3-interconnect", 0, oh, NULL,
>
> In order to stick to the OMAP device naming convention and to have
> something not dependent of the chip version, I think we'd better
> name
> the device like that: "omap_l3_noc". Since it is a Arteris "Network
> On
> Chip" on OMAP4. We will not have to change it for OMAP5 then.
> On OMAP3 the name can then be "omap_l3_smx" for the Sonics MX
> interconnect.
>
Device name changes are fine but file name changes as per this.
dosn't look right if they are like
omap_l3_noc.c
omap_l3_smx.c

May be we can rename them like below
omap_l3_3xxx.c
omap_l3_4xxx.c


> Please note that the L4 is in both case a Sonics 3220. But I don't
> think
> the L4 is managed by this series.
> Maybe the driver file name should be renamed accordingly.
>
L4 is not included.
