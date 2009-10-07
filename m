From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: mux strategy (was RE: [PATCH] [OMAP1] mux: Add MMC mux pins for
	omap7xx)
Date: Wed, 7 Oct 2009 11:48:06 -0700
Message-ID: <6cb013310910071148j57e5f463secc9a563f167f426@mail.gmail.com>
References: <6cb013310910060653u4825da1cwf738a9acef5835b2@mail.gmail.com>
	<4ACB7EC0.3010401@ti.com> <6cb013310910061244q40b78c0ubad1932578e75bd3@mail.gmail.com>
	<87hbucp6ng.fsf@deeprootsystems.com> <7A436F7769CA33409C6B44B358BFFF0C012A67976D@dlee02.ent.ti.com>
	<878wfop4rc.fsf@deeprootsystems.com> <20091007174750.GG7899@atomide.com>
	<87fx9vjbow.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.211.196]:64773 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753322AbZJGS4p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Oct 2009 14:56:45 -0400
Received: by ywh34 with SMTP id 34so5215559ywh.1
        for <linux-omap@vger.kernel.org>; Wed, 07 Oct 2009 11:56:09 -0700 (PDT)
In-Reply-To: <87fx9vjbow.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>, "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Oct 7, 2009 at 11:33 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Tony Lindgren <tony@atomide.com> writes:
>
>> * Kevin Hilman <khilman@deeprootsystems.com> [091006 15:18]:
>>> "Menon, Nishanth" <nm@ti.com> writes:
>>>
>>> >> -----Original Message-----
>>> >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>>> >> owner@vger.kernel.org] On Behalf Of Kevin Hilman
>>> >>
>>> >> >>> =C2=A0 =C2=A0 =C2=A0 =C2=A0W17_7XX_USB_VBUSI,
>>> >> >>> +
>>> >> >>> + =C2=A0 =C2=A0 =C2=A0 /* MMC */
>>> >> >>> + =C2=A0 =C2=A0 =C2=A0 MMC_7XX_CMD,
>>> >> >>> + =C2=A0 =C2=A0 =C2=A0 MMC_7XX_CLK,
>>> >> >>> + =C2=A0 =C2=A0 =C2=A0 MMC_7XX_DAT0,
>>> >> >>
>>> >> >> probably a dumb question -> but should'nt these go off to boo=
tloader
>>> >> >> perhaps?
>>> >> >>
>>> >> >
>>> >> > Perhaps, although we use either EOL (for HTC Wizard) or Haret =
to boot,
>>> >> > and they don't set up the right mux configuration for our boar=
d.
>>> >> >
>>> >> > This way though, we don't have to worry about the boot loader =
-- we
>>> >> > can set it up right regardless of who boots us.
>>> >>
>>> >> I agree with Cory.
>>> >>
>>> >> I prefer that mux settings go into the kernel, even if they are =
setup
>>> >> in the bootloader already. =C2=A0It's better to have redundancy =
than wonder
>>> >> what to do if changing boot loaders.
>>> >>
>>> > Probably opening up a can of worms.. Are the rules different for =
OMAP3?
>>> > Should'nt we have all mux done at kernel so that kernel is loader
>>> > independent?
>>>
>>> Yes, we should. =C2=A0My preference is to always have muxing in the=
 kernel.
>>
>> Agreed. We still should support bootloader only muxing too.
>>
>> BTW, I've been thinking about the following sets of patches for the =
next
>> merge window:
>>
>> 1. Do the include directories for mach-omap1 and mach-omap2 as sugge=
sted
>> =C2=A0 =C2=A0by Russell earlier
>>
>> 2. Move all mux code to only live under arch/arm/*omap*/ and make su=
re
>> =C2=A0 =C2=A0drivers don't call omap_cfg_reg() any longer
>>
>> 3. Remove the enumeration for the mux and require all the boards to
>> =C2=A0 =C2=A0register the pins they'll use
>>
>> After these it should be trivial to improve the mux code further. Th=
e
>> steps 2 & 3 above will be most likely breaking things for some board=
s,
>> so help will be needed with testing.
>
> Sounds like a good start on a mux rework to me. :)
>
> Kevin
>

I agree, this sounds like a good approach.  Should make a lot of
drivers much cleaner and easier to maintain, and we can do away with
the 7xx versus all of the rest of omap1 mux nonsense we have right
now.

Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
