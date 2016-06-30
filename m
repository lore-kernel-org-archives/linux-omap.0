From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RESEND PATCH v2 1/5] ir-rx51: Fix build after multiarch changes
 broke it
Date: Wed, 29 Jun 2016 21:49:59 -0700
Message-ID: <20160630044959.GL28140@atomide.com>
References: <1466623341-30130-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1466623341-30130-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <201606231948.51640@pali>
 <57716E27.2040702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <57716E27.2040702-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [160627 11:22]:
> On 23.06.2016 20:48, Pali Roh=C3=A1r wrote:
> > On Wednesday 22 June 2016 21:22:17 Ivaylo Dimitrov wrote:
> > > The ir-rx51 driver for n900 has been disabled since the multiarch
> > > changes as plat include directory no longer is SoC specific.
> > >=20
> > > Let's fix it with minimal changes to pass the dmtimer calls in
> > > pdata. Then the following changes can be done while things can
> > > be tested to be working for each change:
> > >=20
> > > 1. Change the non-pwm dmtimer to use just hrtimer if possible
> > >=20
> > > 2. Change the pwm dmtimer to use Linux PWM API with the new
> > >     drivers/pwm/pwm-omap-dmtimer.c and remove the direct calls
> > >     to dmtimer functions
> > >=20
> > > 3. Parse configuration from device tree and drop the pdata
> > >=20
> > > Note compilation of this depends on the previous patch
> > > "ARM: OMAP2+: Add more functions to pwm pdata for ir-rx51".
> >=20
> > I think that this extensive description is not needed for commit
> > message. Just for email discussion.
> >=20
>=20
> I guess Tony can strip the description a bit before applying.

OK I'll leave out the last paragraph as that already got merged
earlier.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
