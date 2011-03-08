From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [RFC 3/3] am35xx: pm: Hook-up with TPS65023
Date: Tue, 8 Mar 2011 18:57:36 +0530
Message-ID: <AANLkTikaY5kjbFJtUcnwTOoZJjn6BL8oqXN+B6x_fxav@mail.gmail.com>
References: <1298483913-20344-1-git-send-email-premi@ti.com>
 <1298483913-20344-4-git-send-email-premi@ti.com> <6356620acee7ee78af7da3906b0ea78a@mail.gmail.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024C0E5D33@dbde02.ent.ti.com>
 <c8691dfff1a8ded9676c2f63d8e896c0@mail.gmail.com> <B85A65D85D7EB246BE421B3FB0FBB593024C0E6349@dbde02.ent.ti.com>
 <4D762512.6060503@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593024C0E6385@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:40698 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754469Ab1CHN2A convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 08:28:00 -0500
Received: by eyg5 with SMTP id 5so1854903eyg.10
        for <linux-omap@vger.kernel.org>; Tue, 08 Mar 2011 05:27:57 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024C0E6385@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Mar 8, 2011 at 18:48, Premi, Sanjeev <premi@ti.com> wrote:
[...]
>> Thinking from a generic soln perspective, lets try and split this in=
to
>> multiple issues:
>> a) OPP and Voltage layer voltages - these need to be PMIC aware as w=
ell.
>> See my comment on http://marc.info/?l=3Dlinux-omap&m=3D1299550036115=
48&w=3D2
>> -> essentially means that pmic_voltage information should be registe=
red
>> earlier to opp init
>>
>> b) split up structure information for voltage layer - this should be
>> done in a manner to make PMIC, Board and OMAP SoC information indepe=
ndent.
>>
>> c) Ability to plug in multiple PMICs in two manners:
>> =A0 =A0 i) use PMIC with VC/VP/SR combinations.
>> =A0 =A0 ii) use PMIC which is plugged on regulator frameworks.
>>
>> If anyone is attempting cleanups, it might be a good idea to base on=
 the
>> accepted cleanups from pm-core branch which is planned for 39-rc1 to
>> prevent any surprises ;)
>
> [sp] Without trying to understand much internal details on the propos=
ed
> =A0 =A0 solution, workaround is necessary to get AM35x platforms to e=
ven boot
> =A0 =A0 on current baselines.
>
> =A0 =A0 Using regulator framework etc. are long poles; that can easil=
y be
> =A0 =A0 avoided; and this RFC was meant for that.
>
> =A0 =A0 Knowing that there is already a clean-up effort; simple worka=
round
> =A0 =A0 makes even better proposition.
Personally speaking, it is better we do the cleanup and integrate to
mainline. since we are in the process of cleaning up, it might be a
good idea for contributions from you and all interested folks to
ensure that the final code will support the configurations we all need
:)

meanwhile, any temp hacks might be better off in private trees is my 2 =
cents..
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
