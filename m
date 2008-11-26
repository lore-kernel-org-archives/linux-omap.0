From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP general SOC driver.
Date: Wed, 26 Nov 2008 12:44:33 -0800
Message-ID: <200811261244.33631.david-b@pacbell.net>
References: <1227696478-8354-1-git-send-email-stanley.miao@windriver.com> <200811261034.42356.david-b@pacbell.net> <20081126200750.GK6234@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp122.sbc.mail.sp1.yahoo.com ([69.147.64.95]:25515 "HELO
	smtp122.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752150AbYKZUol (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Nov 2008 15:44:41 -0500
In-Reply-To: <20081126200750.GK6234@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, "Stanley.Miao" <stanley.miao@windriver.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On Wednesday 26 November 2008, Mark Brown wrote:
> > I'm told that the ASoC stuff "should" go in a separate ASoC
> > area for some reason. =A0That still makes no good sense to me,
> > so if there's a brief explanation as to why it's done that
> > way, please fling me a URL. =A0:)
>=20
> The move is in the direction you want but we're not there yet. =A0The=
 fact
> that things are now decomposed enough for us to be able to think abou=
t
> it is a good sign here.
>=20
> The biggest part of it is that the degree of coupling between the
> various ASoC components is high - this is particularly obvious with v=
1
> where the entire card is probed at once. =A0This includes coupling be=
tween
> the drivers and the core where the degree of churn is very high right
> now due to v2 merging. =A0It doesn't feel right to give architectures=
 an
> API that they can't rely on from one merge window to the next yet,

OK, that seems to be the key point.  And it makes a lot of sense;
I wouldn't call the driver structure here "simple", so it deserves
some iteration on multiple disparate hardware platforms just to make
sure the interfaces is adequate to the problem.

Let me insert a minor plug from the PM perspective that it would be
good to find a way that the codecs can sit in the proper places in
the driver model tree.  Example with twl4030:  it's an I2C device
and thus should be a child of something like

   /sys/devices/platform/i2c_omap.1/i2c-adapter/i2c-1/1-0049

to guarantee that for example nothing touches that codec after its
parent I2C controller gets suspended.

- Dave


> partly from the point of view of isolating the code for review purpos=
es
> and also due to the merge issues which would doubtless crop up.
>=20
> Another part of it is that some machine drivers can get involved enou=
gh
> to sit on or cross the boundary from platform data to being drivers f=
or
> substantial distinct hardware but that's very much not the case for
> everything.
>=20
> I've been spending time this week working on getting the ability to l=
oad
> platform and codec drivers independantly merged. =A0That will at leas=
t
> allow the instantiation of the ASoC drivers for those to be pushed ou=
t
> into the architecture code, which is a start and should substantially
> reduce the size of most machine drivers. =A0At the point where that's=
 been
> done it's probably worth looking again at the simpler machine drivers=
=2E
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
