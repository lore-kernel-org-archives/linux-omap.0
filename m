From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC/PATCH 3/7] ARM: OMAP3: clock data: treat all AM35x devices the same
Date: Thu, 05 Jan 2012 16:59:41 -0800
Message-ID: <871urd7iiq.fsf@ti.com>
References: <1325726206-11199-1-git-send-email-khilman@ti.com>
	<1325726206-11199-4-git-send-email-khilman@ti.com>
	<CAORVsuXRG=8BesXvfynO_TdUbvZdVTsTcrfC6LNsPdsi54+gpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:34611 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030245Ab2AFA7q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Jan 2012 19:59:46 -0500
Received: by mail-gx0-f182.google.com with SMTP id p1so605700ggn.41
        for <linux-omap@vger.kernel.org>; Thu, 05 Jan 2012 16:59:44 -0800 (PST)
In-Reply-To: <CAORVsuXRG=8BesXvfynO_TdUbvZdVTsTcrfC6LNsPdsi54+gpw@mail.gmail.com>
	(Jean Pihet's message of "Thu, 5 Jan 2012 10:48:48 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Vaibhav Hiremath <hvaibhav@ti.com>

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Hi Kevin,
>
> On Thu, Jan 5, 2012 at 2:16 AM, Kevin Hilman <khilman@ti.com> wrote:
>> The init for 3505/3517 specific clocks depends on the ordering of
>> cpu_is checks, is error prone and confusing (there are 2 separate
>> checks for cpu_is_omap3505()).
>>
>> Remove the 3505-specific checking since CK_3505 flag is not used, an=
d
>> treat all AM35x clocks the same.
> Since the only remaining check is for omap3517 and from this comment
> it should be better to use a generic check, e.g. cpu_is_omap35xx().

Yes, or probably AM35xx.

>> This means that the SGX clock (the only AM35x clkdev not currently
>> flagged for 3505) will now be registered on 3505, but that is
>> harmless. =C2=A0That can be cleaned up when the clkdev nodes are rem=
oved in
>> favor of them being registered by hwmod.
>>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> ---
>> =C2=A0arch/arm/mach-omap2/clock3xxx_data.c | =C2=A0 14 +------------=
-
>> =C2=A01 files changed, 1 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-om=
ap2/clock3xxx_data.c
>> index e09e506..26fb4d9 100644
>> --- a/arch/arm/mach-omap2/clock3xxx_data.c
>> +++ b/arch/arm/mach-omap2/clock3xxx_data.c
>> @@ -3505,21 +3505,9 @@ int __init omap3xxx_clk_init(void)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct omap_clk *c;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 cpu_clkflg =3D 0;
>>
>> - =C2=A0 =C2=A0 =C2=A0 /*
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0* 3505 must be tested before 3517, sinc=
e 3517 returns true
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0* for both AM3517 chips and AM3517 fami=
ly chips, which
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0* includes 3505. =C2=A0Unfortunately th=
ere's no obvious family
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0* test for 3517/3505 :-(
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> - =C2=A0 =C2=A0 =C2=A0 if (cpu_is_omap3505()) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_mask =3D RATE=
_IN_34XX;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_clkflg =3D CK=
_3505;
>> - =C2=A0 =C2=A0 =C2=A0 } else if (cpu_is_omap3517()) {
>> + =C2=A0 =C2=A0 =C2=A0 if (cpu_is_omap3517()) {
> This is rather confusing if it applies to other omap35xx variants.
> cpu_is_omap35xx() is better.
>
> What do you think?

Agreed, and am working on a patch that changes this to cpu_is_am35xx(),
but didn't have time to get it out yet.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
