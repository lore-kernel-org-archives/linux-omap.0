From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/4] ASoC: DMIC: Adding the OMAP DMIC driver
Date: Fri, 7 Jan 2011 17:13:03 +0000
Message-ID: <20110107171303.GB5602@opensource.wolfsonmicro.com>
References: <1294322439-16305-1-git-send-email-dlambert@ti.com>
 <1294322439-16305-2-git-send-email-dlambert@ti.com>
 <20110106222052.GC8408@opensource.wolfsonmicro.com>
 <AANLkTinraf3OO+exD=ScMf6opsRRW7Kopt1k7ZpEiiB2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:43632 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754532Ab1AGRMr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 12:12:47 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTinraf3OO+exD=ScMf6opsRRW7Kopt1k7ZpEiiB2@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Lambert, David" <dlambert@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

On Fri, Jan 07, 2011 at 10:34:53AM -0600, Lambert, David wrote:
> On Thu, Jan 6, 2011 at 4:20 PM, Mark Brown

> > I suggested switch statements previously; you didn't comment on my
> > reply.

> Sorry... my personal standard on when to go with a switch statement i=
s
> >2 choices,
> I'll change it over to a switch...

Think about the impression you're creating here: if someone had a revie=
w
comment on one version of a patch and you neither reply nor address it
in the patch they're very likely to have the same comment again.

> >> + =A0 =A0 switch (rate) {
> >> + =A0 =A0 case 192000:
> >> + =A0 =A0 =A0 =A0 =A0 =A0 div =3D 5;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> + =A0 =A0 default:
> >> + =A0 =A0 =A0 =A0 =A0 =A0 div =3D 8;

> > Shouldn't the default case be a case 96000?

> The default case IS 96000 (only options for rate here are 96000 and
> 192000), isn't it?

Think about this from a robustness, legibility and maintainability poin=
t
of view - the above code doesn't clearly do the right thing, and if any
other sample rates are added it'll be buggy.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
