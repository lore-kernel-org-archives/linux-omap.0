From: Sricharan R <r.sricharan@ti.com>
Subject: RE: [PATCH-V2 3/4] ARM: OMAP2+: CLEANUP: Remove unnecessary ifdef
 around __omap2_set_globals
Date: Fri, 11 May 2012 12:07:59 +0530
Message-ID: <7c4ff0c2577bb15874d6adad285cf21c@mail.gmail.com>
References: <1336506724-5494-1-git-send-email-hvaibhav@ti.com>
	<1336506724-5494-4-git-send-email-hvaibhav@ti.com>	<87397ajo32.fsf@ti.com>
	<79CD15C6BA57404B839C016229A409A83EA1BF14@DBDE01.ent.ti.com>
 <8762c3ww9w.fsf@ti.com> <79CD15C6BA57404B839C016229A409A83EA220A3@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:44923 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760221Ab2EKGiE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 May 2012 02:38:04 -0400
Received: by lahd3 with SMTP id d3so1670425lah.19
        for <linux-omap@vger.kernel.org>; Thu, 10 May 2012 23:38:01 -0700 (PDT)
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA220A3@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>, Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

Vaibhav,

> > >> > This patch adds new config flag SOC_HAS_OMAP2_SDRC to handle
> sdrc,
> > >> > so that we can reuse same function across omap2/3/4...
> > >>
> > >> But what happens when a single kernel is built that has support
> for an
> > >> SoC with an SDRC (OMAP4) and one that doesn't (AM33xx)?
> > >>
> > >
> > > As such Nothing...I looking into this direction while implementing.
> > >
> > > In that case, sdrc.c file will be compiled in and execution will
> jump to
> > > omap2_set_globals_sdrc(). But inside this function, we are already
> checking
> > > whether the omap2_globals->sdrc and omap2_globals->sms for NULL and
> then use
> > > it.
> > >
> > > And function omap2_sdrc_init() is also depends on machine, so in
> case of
> > > Am33xx, it won't get into sdrc execution at all. And in case of
> omap4, it
> > > will.
> >
> > Then why bother with the #ifdef at all?
> >
> > If it already safe to call on all SoCs, just get rid of the #ifdef
> all
> > together.
> >
>
> Kevin,
>
> sdrc.o target gets built only as "omap-2-3-common", this will not get
> built
> for omap4, am33xx, ti81xx, etc...
> So in order to avoid build break, you have to have some mechanism, and
> that's where we need to create config option dependent on platform.
>
> Another better way of handling this is adding __weak function.
>
> What's your opinion on this?
>
  Then how about just allowing to compile for all omap2/3/4 ?

Thanks,
 Sricharan
