From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: mux strategy (was RE: [PATCH] [OMAP1] mux: Add MMC mux pins for
	omap7xx)
Date: Wed, 14 Oct 2009 07:28:49 -0700
Message-ID: <636c5030910140728l65b5005cn49ec5c5a834d2c78@mail.gmail.com>
References: <6cb013310910060653u4825da1cwf738a9acef5835b2@mail.gmail.com>
	 <4ACB7EC0.3010401@ti.com>
	 <6cb013310910061244q40b78c0ubad1932578e75bd3@mail.gmail.com>
	 <87hbucp6ng.fsf@deeprootsystems.com>
	 <7A436F7769CA33409C6B44B358BFFF0C012A67976D@dlee02.ent.ti.com>
	 <878wfop4rc.fsf@deeprootsystems.com>
	 <20091007174750.GG7899@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f187.google.com ([209.85.216.187]:53981 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761808AbZJNO3Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 10:29:25 -0400
Received: by pxi17 with SMTP id 17so1382470pxi.21
        for <linux-omap@vger.kernel.org>; Wed, 14 Oct 2009 07:28:49 -0700 (PDT)
In-Reply-To: <20091007174750.GG7899@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Menon, Nishanth" <nm@ti.com>, Cory Maccarrone <darkstar6262@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Oct 7, 2009 at 10:47 AM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Kevin Hilman <khilman@deeprootsystems.com> [091006 15:18]:
>> "Menon, Nishanth" <nm@ti.com> writes:
>>
>> >> -----Original Message-----
>> >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> >> owner@vger.kernel.org] On Behalf Of Kevin Hilman
>> >>
>> >> >>> =A0 =A0 =A0 =A0W17_7XX_USB_VBUSI,
>> >> >>> +
>> >> >>> + =A0 =A0 =A0 /* MMC */
>> >> >>> + =A0 =A0 =A0 MMC_7XX_CMD,
>> >> >>> + =A0 =A0 =A0 MMC_7XX_CLK,
>> >> >>> + =A0 =A0 =A0 MMC_7XX_DAT0,
>> >> >>
>> >> >> probably a dumb question -> but should'nt these go off to boot=
loader
>> >> >> perhaps?
>> >> >>
>> >> >
>> >> > Perhaps, although we use either EOL (for HTC Wizard) or Haret t=
o boot,
>> >> > and they don't set up the right mux configuration for our board=
=2E
>> >> >
>> >> > This way though, we don't have to worry about the boot loader -=
- we
>> >> > can set it up right regardless of who boots us.
>> >>
>> >> I agree with Cory.
>> >>
>> >> I prefer that mux settings go into the kernel, even if they are s=
etup
>> >> in the bootloader already. =A0It's better to have redundancy than=
 wonder
>> >> what to do if changing boot loaders.
>> >>
>> > Probably opening up a can of worms.. Are the rules different for O=
MAP3?
>> > Should'nt we have all mux done at kernel so that kernel is loader
>> > independent?
>>
>> Yes, we should. =A0My preference is to always have muxing in the ker=
nel.
>
> Agreed. We still should support bootloader only muxing too.
>
> BTW, I've been thinking about the following sets of patches for the n=
ext
> merge window:
>
> 1. Do the include directories for mach-omap1 and mach-omap2 as sugges=
ted
> =A0 by Russell earlier
>
> 2. Move all mux code to only live under arch/arm/*omap*/ and make sur=
e
> =A0 drivers don't call omap_cfg_reg() any longer
>
> 3. Remove the enumeration for the mux and require all the boards to
> =A0 register the pins they'll use
>
> After these it should be trivial to improve the mux code further. The
> steps 2 & 3 above will be most likely breaking things for some boards=
,
> so help will be needed with testing.
>

=46YI... I've updated the pinmux section of the OMAP wishlist wiki with
this rough plan from Tony.

   http://elinux.org/OMAP_wishlist

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
