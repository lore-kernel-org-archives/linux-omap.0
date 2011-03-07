From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 5/6] omap4: Initialise the l3 device with the hwmod data.
Date: Mon, 7 Mar 2011 16:49:06 +0530
Message-ID: <435c01d5b0d5a1448f64bc1129fe348f@mail.gmail.com>
References: <1298295990-1070-1-git-send-email-santosh.shilimkar@ti.com>
 <1298295990-1070-6-git-send-email-santosh.shilimkar@ti.com>
 <4D62AAAA.40104@ti.com> <295be59bd43a2e9f0961c10263ce19c0@mail.gmail.com> <4D74B1D6.8020708@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:38683 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755492Ab1CGLTJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 06:19:09 -0500
Received: by mail-qw0-f49.google.com with SMTP id 9so3204734qwj.36
        for <linux-omap@vger.kernel.org>; Mon, 07 Mar 2011 03:19:08 -0800 (PST)
In-Reply-To: <4D74B1D6.8020708@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Sricharan R <r.sricharan@ti.com>

> -----Original Message-----
> From: Cousson, Benoit [mailto:b-cousson@ti.com]
> Sent: Monday, March 07, 2011 3:52 PM
> To: Shilimkar, Santosh
> Cc: linux-omap@vger.kernel.org; Balbi, Felipe; R, Sricharan
> Subject: Re: [PATCH 5/6] omap4: Initialise the l3 device with the
> hwmod data.
>
> On 2/21/2011 8:03 PM, Shilimkar, Santosh wrote:
[....]

> >> In order to stick to the OMAP device naming convention and to
> have
> >> something not dependent of the chip version, I think we'd better
> >> name
> >> the device like that: "omap_l3_noc". Since it is a Arteris
> "Network
> >> On
> >> Chip" on OMAP4. We will not have to change it for OMAP5 then.
> >> On OMAP3 the name can then be "omap_l3_smx" for the Sonics MX
> >> interconnect.
> >>
> > Device name changes are fine but file name changes as per this.
> > dosn't look right if they are like
> > omap_l3_noc.c
> > omap_l3_smx.c
>
> Why do you think that does not look right?
>
No strong preference but noc, smx didn't look ok to
me.
> > May be we can rename them like below
> > omap_l3_3xxx.c
> > omap_l3_4xxx.c
>
> The point is that it will really depend of the amount of SoC
> specifics
> data are in this file. If most of the code is reusable on OMAP5 for
> example, then it makes sense to use the name of the IP.
> If that's not the case, then you'd better use the SoC name.
>
Ok. So let's go with the IP names then.
New file names will be as above.

omap_l3_3xxx.c
omap_l3_4xxx.c

Regards,
Santosh
