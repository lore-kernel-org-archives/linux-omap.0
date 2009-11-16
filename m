From: Tony Lindgren <tony@atomide.com>
Subject: Re: Modifying the kernel keymap
Date: Mon, 16 Nov 2009 12:54:16 -0800
Message-ID: <20091116205416.GP3684@atomide.com>
References: <6cb013310911151206s2496a6edxb3101d2d96c8dea0@mail.gmail.com>
 <1258324265.10351.1.camel@gandalf>
 <6cb013310911151442x2ecf9d2dnbfa6fbb7f6ca3b89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54960 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754015AbZKPUyN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Nov 2009 15:54:13 -0500
Content-Disposition: inline
In-Reply-To: <6cb013310911151442x2ecf9d2dnbfa6fbb7f6ca3b89@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: me@felipebalbi.com, linux-omap@vger.kernel.org

* Cory Maccarrone <darkstar6262@gmail.com> [091115 14:49]:
> On Sun, Nov 15, 2009 at 2:31 PM, Felipe Balbi <me@felipebalbi.com> wr=
ote:
> > Hi,
> >
> > On Sun, 2009-11-15 at 12:06 -0800, Cory Maccarrone wrote:
> >> All,
> >>
> >> I'm working with the Wing Linux and Linwizard projects in porting
> >> various omap850-based devices to Linux, and was wondering about
> >> keymaps.
> >>
> >> In particular, I'm working with the HTC Herald, which uses an Alt =
key
> >> to access things like numbers and symbols on a physical keyboard. =
=A0In
> >> Linux, the keymappings are wrong for this -- Alt does something
> >> different and doesn't allow access to those extra characters.
> >>
> >> In Linwizard, we've modified the defkeymap and added makefile rule=
s to
> >> compile our modified defkeymap when a specific board was selected,=
 but
> >> this isn't portable when building a kernel for many boards at once=
,
> >> each having a different mapping.
> >>
> >> So, my question is, what is the best way to go about changing the
> >> defkeymap, or supplying a keymap that allows all the keys to funct=
ion
> >> correctly, but doesn't require non-portable makefile hacks?
> >
> > how about letting xmodmap handle that ? If you use alt key, then ke=
rnel
> > passes alt key. Userland can later remap that key to some other
> > function.
> >
> > --
> > balbi
> >
> >
> >
>=20
> For X-based interfaces that would work, and there's an equivalent for
> Android too.  My question is more geared towards the console (i.e. no
> X or Android, just plain linux console).

Maybe post the patch for reference to linux-input list? Please Cc this
list too, it will be interesting to see what Dmitry suggests.

IMHO, we should find a way to support various keyboards with platform_d=
ata
specified keymaps in order to use the shell with standard distros.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
