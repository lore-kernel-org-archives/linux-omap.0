From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: mux strategy (was RE: [PATCH] [OMAP1] mux: Add MMC mux pins for omap7xx)
Date: Tue, 06 Oct 2009 14:54:47 -0700
Message-ID: <878wfop4rc.fsf@deeprootsystems.com>
References: <6cb013310910060653u4825da1cwf738a9acef5835b2@mail.gmail.com>
	<4ACB7EC0.3010401@ti.com>
	<6cb013310910061244q40b78c0ubad1932578e75bd3@mail.gmail.com>
	<87hbucp6ng.fsf@deeprootsystems.com>
	<7A436F7769CA33409C6B44B358BFFF0C012A67976D@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f217.google.com ([209.85.219.217]:40184 "EHLO
	mail-ew0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757423AbZJFV4F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Oct 2009 17:56:05 -0400
Received: by ewy17 with SMTP id 17so4420847ewy.39
        for <linux-omap@vger.kernel.org>; Tue, 06 Oct 2009 14:54:52 -0700 (PDT)
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C012A67976D@dlee02.ent.ti.com> (Nishanth Menon's message of "Tue\, 6 Oct 2009 16\:52\:37 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Cory Maccarrone <darkstar6262@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Menon, Nishanth" <nm@ti.com> writes:

>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Kevin Hilman
>>=20
>> >>> =A0 =A0 =A0 =A0W17_7XX_USB_VBUSI,
>> >>> +
>> >>> + =A0 =A0 =A0 /* MMC */
>> >>> + =A0 =A0 =A0 MMC_7XX_CMD,
>> >>> + =A0 =A0 =A0 MMC_7XX_CLK,
>> >>> + =A0 =A0 =A0 MMC_7XX_DAT0,
>> >>
>> >> probably a dumb question -> but should'nt these go off to bootloa=
der
>> >> perhaps?
>> >>
>> >
>> > Perhaps, although we use either EOL (for HTC Wizard) or Haret to b=
oot,
>> > and they don't set up the right mux configuration for our board.
>> >
>> > This way though, we don't have to worry about the boot loader -- w=
e
>> > can set it up right regardless of who boots us.
>>=20
>> I agree with Cory.
>>=20
>> I prefer that mux settings go into the kernel, even if they are setu=
p
>> in the bootloader already.  It's better to have redundancy than wond=
er
>> what to do if changing boot loaders.
>>=20
> Probably opening up a can of worms.. Are the rules different for OMAP=
3?=20
> Should'nt we have all mux done at kernel so that kernel is loader=20
> independent?

Yes, we should.  My preference is to always have muxing in the kernel.

Kevin

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
