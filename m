From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] staging: tidspbridge: enable watchdog by default
Date: Fri, 10 Feb 2012 09:48:47 -0800
Message-ID: <20120210174847.GC5128@kroah.com>
References: <CAMP44s2Hvgsi+JF=ydAebd=dUYUNfJSB-T3FmLvO=RGDwBvU0Q@mail.gmail.com>
 <20120201034445.GA2979@kroah.com>
 <CAMP44s2FNFwvjv=f7WvJG7qXpYVqq0i53FzPcPTAB2g1mUk1Fw@mail.gmail.com>
 <20120209173528.GA31726@kroah.com>
 <CAMP44s3jvYMSmQfvhKEzTz9iYq-dabLJ6qniFsjw9vZLqgP0Ng@mail.gmail.com>
 <20120209185923.GB10284@kroah.com>
 <CAMP44s3r1-rt6HqgmVuB_Kjd1LSo-75m=6GERUt+ATewBaFw-Q@mail.gmail.com>
 <CAB-zwWj0z9N_2RRHBBNcHPLYWRii2T8q+gMgBnA3+ux8Ojg9JA@mail.gmail.com>
 <20120210051849.GE1565@kroah.com>
 <CAMP44s3M1vo7j9o8NBhQm5QpLz91w3UdZz6vFmXt2f_r5n1hSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51052 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759604Ab2BJRtC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Feb 2012 12:49:02 -0500
Received: by pbcun15 with SMTP id un15so2608776pbc.19
        for <linux-omap@vger.kernel.org>; Fri, 10 Feb 2012 09:49:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAMP44s3M1vo7j9o8NBhQm5QpLz91w3UdZz6vFmXt2f_r5n1hSw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, Jiri Kosina <jkosina@suse.cz>, Felipe Contreras <felipe.contreras@nokia.com>, "Justin P. Mattock" <justinmattock@gmail.com>, linux-omap@vger.kernel.org

On Fri, Feb 10, 2012 at 06:16:19PM +0200, Felipe Contreras wrote:
> On Fri, Feb 10, 2012 at 7:18 AM, Greg KH <gregkh@linuxfoundation.org>=
 wrote:
> > On Thu, Feb 09, 2012 at 04:45:00PM -0800, Ramirez Luna, Omar wrote:
> >> Hi,
> >>
> >> On Thu, Feb 9, 2012 at 3:30 PM, Felipe Contreras
> >> <felipe.contreras@gmail.com> wrote:
> >> >> Again, I'm totally confused as to _WHY_ this needs to be y. =A0=
What is
> >> >> causing this oops without it? =A0If an oops is happening, then =
shouldn't
> >> >> this be a strict dependancy? =A0Why allow it to be disabled at =
all if it
> >> >> can break your box if you don't enable it?
> >> >
> >> > It's not an oops, it's a warning, and again, it depends on the
> >> > firmware being used. We don't have control over that, and we hav=
e no
> >> > way to detect if this feature is there. It's up to the user.
> >>
> >> I have been thinking more into it, how about looking for a WDT sym=
bol
> >> inside the baseimage to decide whether to turn ON/OFF WDT3, this w=
ould
> >> mean that the code is always compiled in, but the decision to turn=
 it
> >> on/off is made at runtime.
> >
> > I totally don't understand, why not just silence the warning proper=
ly
> > then?
>=20
> The warning doesn't come from the driver, and AFAIK it's a valid
> warning. Now, I haven't explored the code, so I don't know what's
> going on, I just know Omar said this fixes the warning, and that
> there's no easy way around it.
>=20
> > I fail to understand why this warning happens,
>=20
> I don't know either, I just know enabling TIDSPBRIDGE_WDT3 fixes it.

Ok, I suggest someone get to the root cause of this before we change
anything, although some better Kconfig text would be nice to have to
document the existing issues.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
