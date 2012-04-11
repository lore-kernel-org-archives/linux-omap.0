From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [PATCH RESEND] Input: omap-keypad: dynamically handle register offsets
Date: Wed, 11 Apr 2012 14:34:47 +0530
Message-ID: <CAKdam56OpU=CwnnVtGKd=_1vdj481JXEzzip+y4HBGMoEdYPcw@mail.gmail.com>
References: <1333430546-23454-1-git-send-email-sourav.poddar@ti.com>
	<20120410162353.GA6217@core.coreip.homeip.net>
	<CAKdam57PkBQXTHv3VZ79vQ_v4TZYLxKCP4FY01XFEQJ-PPLkuQ@mail.gmail.com>
	<20120411085638.GC12064@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20120411085638.GC12064@arwen.pp.htv.fi>
Sender: linux-input-owner@vger.kernel.org
To: balbi@ti.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On Wed, Apr 11, 2012 at 2:26 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Wed, Apr 11, 2012 at 02:19:48PM +0530, Poddar, Sourav wrote:
>> >> +static int kbd_readl(struct omap4_keypad *keypad_data, u32 offse=
t)
>> >> +{
>> >> + =A0 =A0 if (keypad_data->revision =3D=3D KBD_REVISION_OMAP4)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return __raw_readl(keypad_data->base + =
offset);
>> >> + =A0 =A0 else if (keypad_data->revision =3D=3D KBD_REVISION_OMAP=
5)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return __raw_readl(keypad_data->base + =
offset + 0x10);
>> >> +
>> >> + =A0 =A0 return -ENODEV;
>> >
>> > Instead do:
>> >
>> > =A0 =A0 =A0 =A0return __raw_readl(keypad_data->base + keypad_data-=
>reg_offset +
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 offset);
>> >> +}
>> I have a couple of doubts on this:
>> 1. Before using kbd_readl/kbd_write anywhere we
>> need to populate the "keypad_data->reg_offset" =A0with the register =
address
>> which we need to read or write.
>
> no no... keypad_data->reg_offset would be 0 or 0x10 depending on the
> scheme you decode from revision.
Ohk. Got it. Will make the necessary changes.
Thanks.

~Sourav
>
> --
> balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
