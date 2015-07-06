From: Rob Herring <robherring2@gmail.com>
Subject: Re: [RESEND] [PATCH v2 1/2] arm: devtree: Set system_rev from DT revision
Date: Mon, 6 Jul 2015 12:30:15 -0500
Message-ID: <CAL_Jsq+A8v4EPZaGvAFohrg4TAw9a5fJy7ZJOOJ8T-OAyPuBUg@mail.gmail.com>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
 <201507061512.27124@pali> <CAL_Jsq+ysDqxTgfW1JvG5czHa4UkZQDv1BN63iK4jvV9kDXM8w@mail.gmail.com>
 <201507061820.35789@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201507061820.35789@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, Pavel Machek <pavel@ucw.cz>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, linux-omap <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 6, 2015 at 11:20 AM, Pali Roh=C3=A1r <pali.rohar@gmail.com>=
 wrote:
> On Monday 06 July 2015 17:22:58 Rob Herring wrote:
>> On Mon, Jul 6, 2015 at 8:12 AM, Pali Roh=C3=A1r <pali.rohar@gmail.co=
m> wrote:
>> > On Monday 06 July 2015 14:31:27 Tony Lindgren wrote:
>> >> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [150706 05:25]:
>> >> > into which file should I put documentation about new DT
>> >> > properties?
>> >>
>> >> If it's Linux generic like linux,revision, then how about
>> >> Documentation/devicetree/bindings/revision.txt?
>> >>
>> >> For the ATAGs, Documentation/devicetree/bindings/arm/atag.txt?
>> >>
>> >> Regards,
>> >>
>> >> Tony
>> >
>> > Hm... now I'm thinking into which DT field should I put atags and
>> > revision. In previous emails you wrote to use "linux,atags", now
>> > "arm,atags"? And put them into root node? Or other?
>> >
>> > In arch/arm/boot/compressed/atags_to_fdt.c code I see that most
>> > atag properties are converted into "/chosen" node in DT...
>> >
>> > So what do you prefer for "revision" and what for "atags"?
>> >
>> > Some mentioned examples:
>> >
>> > "/revision"
>>
>> This one. This is a top level h/w property.
>>
>> > "/chosen/revision"
>> > "/linux,revision"
>> > "/chosen/linux,revision"
>> > ...
>> >
>> > "/atags"
>> > "/chosen/atags"
>> > "/linux,atags"
>> > "/chosen/linux,atags"
>>
>> This one. ATAGs are a Linux data struct.
>>
>> Rob
>>
>
> Ok, and how read that property "/chosen/linux,atags" in function
> setup_machine_fdt() from file arch/arm/kernel/devtree.c ?
>
> of_get_flat_dt_prop() cannot be used unless somebody get me offset to
> node "/chosen"...

Why can't you get the offset yourself?

However, why does this need to be early? It is only used to populate
/proc, right?

Rob
