From: Rob Landley <rob@landley.net>
Subject: Re: new binutils needed for arm in 3.12-rc1
Date: Wed, 25 Sep 2013 19:10:55 -0500
Message-ID: <1380154255.1974.92@driftwood>
References: <yw1x7ge4x5ir.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	DelSp=Yes	Format=Flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:62463 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754032Ab3IZWGd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Sep 2013 18:06:33 -0400
Received: by mail-ob0-f177.google.com with SMTP id wp18so2585777obc.36
        for <linux-omap@vger.kernel.org>; Thu, 26 Sep 2013 15:06:32 -0700 (PDT)
In-Reply-To: <yw1x7ge4x5ir.fsf@unicorn.mansr.com> (from mans@mansr.com on
	Wed Sep 25 10:52:44 2013)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: Nicolas Pitre <nico@fluxnic.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, Andrew Morton <akpm@osdl.org>, Trivial patch monkey <trivial@kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 09/25/2013 10:52:44 AM, M=E5ns Rullg=E5rd wrote:
> Rob Landley <rob@landley.net> writes:
>=20
> > On 09/24/2013 09:07:57 PM, Nicolas Pitre wrote:
> >> I'd strongly suggest you make your binutils compatible with newer
> >> instruction syntax instead of making the kernel more complex.
> >
> > Meaning I play whack-a-mole as this becomes permission to depend on
> > endless new gnuisms just because they're there and nobody else is
> > regression testing against them, not because they actually add =20
> anything.
>=20
> Since when is assembling the instructions correctly, as specified in =
=20
> the
> arch ref, and not in some other random way a gnuism?

If you require current gnome and drop support for older versions (and =20
implicitly all other desktops), people start writing stuff that depends=
 =20
on systemd. It doesn't matter if the feature you abandoned support for =
=20
the past 10 years of everthing else for wasn't itself provided by =20
systemd.

Rob--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
