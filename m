From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/2] OMAP4: Regulator: Specify system has fully specified constraints
Date: Mon, 27 Jun 2011 16:11:59 -0700
Message-ID: <87sjqu6f9c.fsf@ti.com>
References: <1308702288-12787-1-git-send-email-girishsg@ti.com>
	<BANLkTim6sY=2qQ7isxhKSWgjCWCrc5UX4g@mail.gmail.com>
	<BANLkTikrfgHpMTDckUKYSBB1u5YrrT=AQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:43746 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755408Ab1F0XMD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Jun 2011 19:12:03 -0400
Received: by pzk26 with SMTP id 26so3403116pzk.10
        for <linux-omap@vger.kernel.org>; Mon, 27 Jun 2011 16:12:01 -0700 (PDT)
In-Reply-To: <BANLkTikrfgHpMTDckUKYSBB1u5YrrT=AQw@mail.gmail.com> (Girish
	Ghongdemath's message of "Wed, 22 Jun 2011 17:32:54 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ghongdemath, Girish" <girishsg@ti.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, linux-omap <linux-omap@vger.kernel.org>

"Ghongdemath, Girish" <girishsg@ti.com> writes:

> On Wed, Jun 22, 2011 at 5:12 PM, Pandita, Vikram <vikram.pandita@ti.c=
om> wrote:
>> On Tue, Jun 21, 2011 at 5:24 PM, Girish S G <girishsg@ti.com> wrote:
>> <snip>
>>> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-om=
ap2/board-4430sdp.c
>>> index 04b7770..46f6800 100644
>>> --- a/arch/arm/mach-omap2/board-4430sdp.c
>>> +++ b/arch/arm/mach-omap2/board-4430sdp.c
>>> @@ -560,6 +560,9 @@ static struct i2c_board_info __initdata sdp4430=
_i2c_4_boardinfo[] =3D {
>>> =C2=A0};
>>> =C2=A0static int __init omap4_i2c_init(void)
>>> =C2=A0{
>>> + =C2=A0 =C2=A0 =C2=A0 /* This will allow unused regulator to be sh=
utdown */
>>> + =C2=A0 =C2=A0 =C2=A0 regulator_has_full_constraints();
>>> +
>>
>> Any particular reason to keep this call in i2c_init() function?
>> Does not look very intuitive to have generic regulator disable call =
in
>> an i2c init function !
>
> In the regulator late init call the core will decide on regulator
> status, so this has to be specified
> before the pmic/twl data is registered.

Vikram's point still stands.   This is not related to I2C init, so it
should not be in the i2c init function.

Just make it the last call the machine-specific .init_machine function.

Kevin

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
