From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] ARM: OMAP3: clock: fix DPLL4 CLKSEL masks
Date: Thu, 5 Apr 2012 13:33:42 +0300
Message-ID: <CANOLnOMO1VLVKiv0FhnCwehMGpvnSRxNByU4Vdb26wwqZPdazg@mail.gmail.com>
References: <1332709687-22846-1-git-send-email-notasas@gmail.com>
	<alpine.DEB.2.00.1204040837510.8000@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:60180 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287Ab2DEKdm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Apr 2012 06:33:42 -0400
Received: by obbtb18 with SMTP id tb18so1602639obb.19
        for <linux-omap@vger.kernel.org>; Thu, 05 Apr 2012 03:33:42 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1204040837510.8000@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

On Wed, Apr 4, 2012 at 5:40 PM, Paul Walmsley <paul@pwsan.com> wrote:
> On Mon, 26 Mar 2012, Grazvydas Ignotas wrote:
>
>> Commit 2a9f5a4d455 "OMAP3 clock: remove unnecessary duplicate of dpl=
l4_m2_ck,
>> added for 36xx" consolidated dpll4 clock structures between 34xx and=
 36xx,
>> but left 34xx CLKSEL masks for most dpll4 related clocks, which caus=
es
>> clock code to not behave correctly when booting on DM3730 with highe=
r
>> (36xx only) divisors set:
>> [ =C2=A0 =C2=A00.000000] WARNING: at arch/arm/mach-omap2/clkt_clksel=
=2Ec:375 omap2_init_clksel_parent+0x104/0x114()
>> [ =C2=A0 =C2=A00.000000] clock: dpll4_m3_ck: init parent: could not =
find regval 0
>> [ =C2=A0 =C2=A00.000000] WARNING: at arch/arm/mach-omap2/clkt_clksel=
=2Ec:194 omap2_clksel_recalc+0xd4/0xe4()
>> [ =C2=A0 =C2=A00.000000] clock: Could not find fieldval 0 for clock =
dpll4_m3_ck parent dpll4_ck
>>
>> Fix this by switching to 36xx masks, as valid divisors will be limit=
ed
>> by clksel_rate lists.
>>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
>
> Thanks, queued for 3.4-rc.
>
> (Looks like the lakml cc was accidentally dropped, so I went ahead an=
d did
> that, but maybe you could do that for me next time :-) )

I think I simply forgot it, thanks!

--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
