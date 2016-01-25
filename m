From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Subject: Re: [PATCH 1/2] regulator: ltc3589: make IRQ optional
Date: Mon, 25 Jan 2016 13:37:31 +0100
Message-ID: <20160125133731.72669115@ipc1.ka-ro>
References: <1453292992-1788-1-git-send-email-LW@KARO-electronics.de>
	<1453292992-1788-2-git-send-email-LW@KARO-electronics.de>
	<20160120164258.GF6588@sirena.org.uk>
	<20160121080524.27af489f@ipc1.ka-ro>
	<20160121102015.GI6588@sirena.org.uk>
	<20160121112611.34e17cb2@ipc1.ka-ro>
	<20160121111115.GJ6588@sirena.org.uk>
	<20160121123311.5346e40d@ipc1.ka-ro>
	<20160121162646.GK6588@sirena.org.uk>
	<20160122064145.36b7f2b4@ipc1.ka-ro>
	<20160122162610.GZ6588@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160122162610.GZ6588-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: =?UTF-8?B?QmVub8OudA==?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, 22 Jan 2016 16:26:10 +0000 Mark Brown wrote:
> On Fri, Jan 22, 2016 at 06:41:45AM +0100, Lothar Wa=C3=9Fmann wrote:
> > > On Thu, Jan 21, 2016 at 12:33:11PM +0100, Lothar Wa=C3=9Fmann wro=
te:
>=20
> > > Your commit message (quoted above) claims that without this patch=
 if no
> > > interrupt is supplied then the unsupplied interrupt will somehow =
be left
> > > screaming and make the system unusable.  This doesn't make sense,=
 if
> > > there is no interrupt there is nothing to scream.
>=20
> > "Otherwise" meant the case where the IRQ is specified in DT as is
> > currently required to get the driver loaded at all.
>=20
> > > So, contrary to what you've been saying, the interrupt is actuall=
y
> > > connected (and worse, connected to a NMI) but apparently not desc=
ribed
> > > in DT.  Why is it sensible to make the driver poll (which will af=
fect
> > > all systems using this device, even those that don't care) and no=
t just
> > > describe the interrupt in DT so it can be handled promptly in the=
 normal
> > > fashion?  Presumably this will run into serious problems if the
> > > interrupt actually fires at runtime since the NMI will scream, it=
's not
> > > clear to me how the poll will manage to run successfully in that =
case.
>=20
> > Currently the driver won't even load without an IRQ specified in DT=
=2E
> > My patch makes it possible to use the driver without requiring an I=
RQ!
>=20
> You're not just making the interrupt optional, you are also implement=
ing
> polling support.  That's really unusual and there's no clear reason f=
or
> it, your changelog seems to claim that it is needed to make the syste=
m
> work but that seems at best very surprising and would need a more
> detailed changelog.
>=20
> You at least need to provide an understandable changelog, though it
> seems it is more likely that there is a more sensible way of dealing
> with this.
>
Any suggestions how to handle this case in a more sensible way?


Lothar Wa=C3=9Fmann
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
