From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: new binutils needed for arm in 3.12-rc1
Date: Thu, 26 Sep 2013 23:24:07 +0100
Message-ID: <yw1xy56jusqg.fsf@unicorn.mansr.com>
References: <1380154255.1974.92@driftwood>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:40936 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754164Ab3IZWYL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Sep 2013 18:24:11 -0400
In-Reply-To: <1380154255.1974.92@driftwood> (Rob Landley's message of "Wed, 25
	Sep 2013 19:10:55 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Landley <rob@landley.net>
Cc: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, Nicolas Pitre <nico@fluxnic.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>, Trivial patch monkey <trivial@kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Rob Landley <rob@landley.net> writes:

> On 09/25/2013 10:52:44 AM, M=E5ns Rullg=E5rd wrote:
>> Rob Landley <rob@landley.net> writes:
>>=20
>> > On 09/24/2013 09:07:57 PM, Nicolas Pitre wrote:
>> >> I'd strongly suggest you make your binutils compatible with newer
>> >> instruction syntax instead of making the kernel more complex.
>> >
>> > Meaning I play whack-a-mole as this becomes permission to depend o=
n
>> > endless new gnuisms just because they're there and nobody else is
>> > regression testing against them, not because they actually add =20
>> > anything.
>>=20
>> Since when is assembling the instructions correctly, as specified in
>> the arch ref, and not in some other random way a gnuism?
>
> If you require current gnome and drop support for older versions (and=
 =20
> implicitly all other desktops), people start writing stuff that depen=
ds =20
> on systemd. It doesn't matter if the feature you abandoned support fo=
r =20
> the past 10 years of everthing else for wasn't itself provided by =20
> systemd.

Are you saying current binutils depends on gnome and/or systemd?

--=20
M=E5ns Rullg=E5rd
mans@mansr.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
