From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC] dt: export of_have_populated_dt
Date: Tue, 10 Apr 2012 14:33:57 -0600
Message-ID: <20120410203357.D86323E0D65@localhost>
References: <1334070672-11252-1-git-send-email-balajitk@ti.com> <4F845D99.7020705@ti.com> <87y5q3v9pd.fsf@laptop.org> <4F845FF9.5080005@ti.com> <4F846BDB.8020805@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:39105 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757221Ab2DJUeB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Apr 2012 16:34:01 -0400
Received: by dake40 with SMTP id e40so218644dak.11
        for <linux-omap@vger.kernel.org>; Tue, 10 Apr 2012 13:34:00 -0700 (PDT)
In-Reply-To: <4F846BDB.8020805@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>, "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>, devicetree-discuss@lists.ozlabs.org, Chris Ball <cjb@laptop.org>, bigeasy@linutronix.de

On Tue, 10 Apr 2012 12:20:27 -0500, Rob Herring <robherring2@gmail.com> wrote:
> On 04/10/2012 11:29 AM, Cousson, Benoit wrote:
> > Hi Chris,
> > 
> > On 4/10/2012 6:21 PM, Chris Ball wrote:
> >> Hi,
> >>
> >> On Tue, Apr 10 2012, Cousson, Benoit wrote:
> >>> Hi Balaji,
> >>>
> >>> On 4/10/2012 5:11 PM, Balaji T K wrote:
> >>>> If of_have_populated_dt is called from module, build fails with
> >>>> "allnodes"
> >>>> undefined error, so remove inline and export of_have_populated_dt.
> >>>
> >>> Is this function really called from the MMC driver?
> >>
> >> ~/git/linux % git grep of_have_populated_dt drivers/
> >> drivers/gpio/gpio-samsung.c:    if (!of_have_populated_dt())
> >> drivers/mmc/host/omap_hsmmc.c:  if (of_have_populated_dt()&&  !vdd)
> >> drivers/mmc/host/omap_hsmmc.c:                  
> >> (!of_have_populated_dt())) {
> > 
> > Gosh, twice... I should be in a wrong branch :-(
> > 
> > Then the next question to Rob...
> > 
> > Rob,
> > Does it make sense to use that in the driver? So far I was using that
> > only in the arch code to make the difference between the DT boot and the
> > non-DT boot.
> > 
> > I guess that a driver should rely on of_match_device or non-NULL
> > device_node to figure out that?
> > 
> 
> Agreed. of_match_device or device_node ptr check is the right approach.

Good; I can safely ignore this patch.  :-)

g.

