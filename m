From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 1/1] DSPBRIDGE: expose DSP_TRACEBUF as kernel config
 option
Date: Fri, 24 Jul 2009 19:43:41 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E3A941DDF@dlee03.ent.ti.com>
References: <1248431051-26340-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<8F7AF80515AF0D4D93307E594F3CB40E3A8CAD56@dlee03.ent.ti.com>
 <20090724.210005.226780464.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46798 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754397AbZGYAnw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jul 2009 20:43:52 -0400
In-Reply-To: <20090724.210005.226780464.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>

Hiroshi,

> The problem here is that now all TRACEBUF code is always compiled in
> in spite of setting "DEBUG". It doesn't print anything, but just
> wastes some memory

That's not true. DSP_TRACEBUF is used to print the traces from DSP. This is used by Socket node developers to print their traces from DSP to console.
If you enable DT=1 GT trace, then you get all the prints from DSP, which is extremely useful for DSP Developers.

Thank you,
Best regards,
Hari


> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
> Sent: Friday, July 24, 2009 1:00 PM
> To: Kanigeri, Hari
> Cc: linux-omap@vger.kernel.org; ameya.palande@nokia.com; Guzman Lugo,
> Fernando; Ramirez Luna, Omar
> Subject: Re: [PATCH 1/1] DSPBRIDGE: expose DSP_TRACEBUF as kernel config
> option
> 
> Hi Hari,
> 
> From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
> Subject: RE: [PATCH 1/1] DSPBRIDGE: expose DSP_TRACEBUF as kernel config
> option
> Date: Fri, 24 Jul 2009 19:28:47 +0200
> 
> > Hi Doyu-san,
> >
> > >
> > > "CONFIG_DSP_TRACEBUF" is introduced as a kernel config option to save
> > > some amount of unused memory and "#ifndef DSP_TRACEBUF_DISABLED" was
> > > not easy to understand.
> > >
> >
> > I think we just use the Bridge DEBUG flag that is used in Bridge instead
> of introducing a new flag.
> 
> It might be better if "CONFIG_DSP_TRACEBUF" had the dependecy on
> "DEBUG/CONFIG_BRIDGE_DEBUG", but it's not unfortunately.
> 
> The problem here is that now all TRACEBUF code is always compiled in
> in spite of setting "DEBUG". It doesn't print anything, but just
> wastes some memory.
> 
> I'll remove a new Kconfig entry and just add the dependency of
> "CONFIG_DSP_TRACEBUF" on "CONFIG_BRIDGE_DEBUG".

