From: Mike Rapoport <mike.rapoport@gmail.com>
Subject: Re: [PATCH 3/5] omap: mux: Add new style pin multiplexing data for
	34xx
Date: Tue, 3 Nov 2009 09:10:47 +0200
Message-ID: <f870da180911022310n65b63bffw9a425e4aeaa9187b@mail.gmail.com>
References: <20091029203124.11843.89983.stgit@localhost>
	 <20091029203631.11843.1364.stgit@localhost>
	 <4AED6330.8020007@compulab.co.il> <20091102191018.GD6692@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f180.google.com ([209.85.223.180]:62236 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753467AbZKCHKm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 02:10:42 -0500
Received: by iwn10 with SMTP id 10so3940876iwn.4
        for <linux-omap@vger.kernel.org>; Mon, 02 Nov 2009 23:10:47 -0800 (PST)
In-Reply-To: <20091102191018.GD6692@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mike Rapoport <mike@compulab.co.il>, linux-omap@vger.kernel.org

On Mon, Nov 2, 2009 at 9:10 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Mike Rapoport <mike@compulab.co.il> [091101 02:30]:
>>
>>
>> Tony Lindgren wrote:
>> > Add new style mux data for 34xx. This should also
>> > work with 3630 easily by adding the processor subset
>> > and ball data.
>> >
>> > Note that this data is __initdata, and gets optimized
>> > out if CONFIG_OMAP_MUX is not set. Also, the debug data
>> > gets optimized out if CONFIG_DEBUG_FS is not set.
>> >
>> > Signed-off-by: Tony Lindgren <tony@atomide.com>
>> > ---
>> > =A0arch/arm/mach-omap2/Makefile =A0| =A0 =A04
>> > =A0arch/arm/mach-omap2/mux.h =A0 =A0 | =A0 =A02
>> > =A0arch/arm/mach-omap2/mux34xx.c | 1552 ++++++++++++++++++++++++++=
+++++++++++++++
>> > =A0arch/arm/mach-omap2/mux34xx.h | =A0352 +++++++++
>> > =A04 files changed, 1910 insertions(+), 0 deletions(-)
>> > =A0create mode 100644 arch/arm/mach-omap2/mux34xx.c
>> > =A0create mode 100644 arch/arm/mach-omap2/mux34xx.h
>> >

[ snip ]

>> > +
>> > +#define OMAP3_CONTROL_PADCONF_MUX_SIZE =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> > + =A0 =A0 =A0 =A0 =A0 (OMAP3_CONTROL_PADCONF_JTAG_TDO_OFFSET + 0x2=
)
>>
>> What about adding defines for each possible mode configuration, exce=
pt, perhaps,
>> GPIO?
>
> Yeah it would be nice to make it easy. How about someting like:
>
> int __init omap_mux_init_by_name(char *name, int flags);
> ...
>
> omap_mux_init_by_name("i2c1_scl", OMAP_PIN_INPUT_PULLUP);
>
>> #define OMAP3_PIN_CAM_D0 OMAP3_MUX(CAM_D0, OMAP_PIN_MODE0 | OMAP_PIN=
_INPUT, 0)
>> #define OMAP3_PIN_CAM_D0_CSI2_DX2 OMAP3_MUX(CAM_D0, OMAP_PIN_MODE2 |=
 \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 OMAP_PIN_INPUT, 0)
>>
>> And, I'm for adding OMAP_MUX_GPIO_{OUT,IN,IN_PU,IN_PD}(x) as well.
>
> And we could have also:
>
> int __init omap_mux_init_by_gpio(int gpio, int flags);
> ...
>
> omap_mux_init_by_gpio(99, OMAP_PIN_INPUT);
>
> As the only thing we currently have for flags is the OMAP_MUX_DYNAMIC=
,
> we could mask that too into flags and make it int instead of u16.

It seems we are thinking in really different directions :) You propose
imporved and easy to use replacements of omap_cfg_reg while I'm aming
nice tables descibing board pin configuration like, e.g,
cm_x300_mfp_cfg in arch/arm/mach-pxa/cm-x300.c. Probably it's just too
hard to me to break my PXA habbits, but I think such tables make the
board code easier to write/maintain/understand.
Besides, having both simple aliases for OMAP3_MUX(mode0, mux_value,
mux_flags) for dedicated pins does not contadict having
omap_mux_init_by_{name,gpio} helpers.

> Regards,
>
> Tony
>



--=20
	Sincerely Yours,
		Mike.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
