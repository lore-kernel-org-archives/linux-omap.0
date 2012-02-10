From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] staging: tidspbridge: enable watchdog by default
Date: Thu, 9 Feb 2012 21:18:49 -0800
Message-ID: <20120210051849.GE1565@kroah.com>
References: <1328058094-28483-1-git-send-email-felipe.contreras@gmail.com>
 <20120201011239.GA797@suse.de>
 <CAMP44s2Hvgsi+JF=ydAebd=dUYUNfJSB-T3FmLvO=RGDwBvU0Q@mail.gmail.com>
 <20120201034445.GA2979@kroah.com>
 <CAMP44s2FNFwvjv=f7WvJG7qXpYVqq0i53FzPcPTAB2g1mUk1Fw@mail.gmail.com>
 <20120209173528.GA31726@kroah.com>
 <CAMP44s3jvYMSmQfvhKEzTz9iYq-dabLJ6qniFsjw9vZLqgP0Ng@mail.gmail.com>
 <20120209185923.GB10284@kroah.com>
 <CAMP44s3r1-rt6HqgmVuB_Kjd1LSo-75m=6GERUt+ATewBaFw-Q@mail.gmail.com>
 <CAB-zwWj0z9N_2RRHBBNcHPLYWRii2T8q+gMgBnA3+ux8Ojg9JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:48212 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750745Ab2BJFWG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Feb 2012 00:22:06 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id E355A20A25
	for <linux-omap@vger.kernel.org>; Fri, 10 Feb 2012 00:22:04 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAB-zwWj0z9N_2RRHBBNcHPLYWRii2T8q+gMgBnA3+ux8Ojg9JA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, Jiri Kosina <jkosina@suse.cz>, Felipe Contreras <felipe.contreras@nokia.com>, "Justin P. Mattock" <justinmattock@gmail.com>, linux-omap@vger.kernel.org

On Thu, Feb 09, 2012 at 04:45:00PM -0800, Ramirez Luna, Omar wrote:
> Hi,
>=20
> On Thu, Feb 9, 2012 at 3:30 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >> Again, I'm totally confused as to _WHY_ this needs to be y. =A0Wha=
t is
> >> causing this oops without it? =A0If an oops is happening, then sho=
uldn't
> >> this be a strict dependancy? =A0Why allow it to be disabled at all=
 if it
> >> can break your box if you don't enable it?
> >
> > It's not an oops, it's a warning, and again, it depends on the
> > firmware being used. We don't have control over that, and we have n=
o
> > way to detect if this feature is there. It's up to the user.
>=20
> I have been thinking more into it, how about looking for a WDT symbol
> inside the baseimage to decide whether to turn ON/OFF WDT3, this woul=
d
> mean that the code is always compiled in, but the decision to turn it
> on/off is made at runtime.

I totally don't understand, why not just silence the warning properly
then?

I fail to understand why this warning happens, why it depends on the
firmware, and why you can't detect it at runtime to not do it.  And how
it all ties into a kconfig option...

confused,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
