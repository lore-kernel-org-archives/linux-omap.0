From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC 3/3] am35xx: pm: Hook-up with TPS65023
Date: Tue, 08 Mar 2011 08:08:57 -0800
Message-ID: <87tyfdvbl2.fsf@ti.com>
References: <1298483913-20344-1-git-send-email-premi@ti.com>
	<1298483913-20344-4-git-send-email-premi@ti.com>
	<6356620acee7ee78af7da3906b0ea78a@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024C0E5D33@dbde02.ent.ti.com>
	<c8691dfff1a8ded9676c2f63d8e896c0@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024C0E6349@dbde02.ent.ti.com>
	<4D762512.6060503@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024C0E6385@dbde02.ent.ti.com>
	<AANLkTikaY5kjbFJtUcnwTOoZJjn6BL8oqXN+B6x_fxav@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:47804 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754588Ab1CHQJA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 11:09:00 -0500
Received: by mail-pv0-f169.google.com with SMTP id 4so1367353pvg.14
        for <linux-omap@vger.kernel.org>; Tue, 08 Mar 2011 08:08:59 -0800 (PST)
In-Reply-To: <AANLkTikaY5kjbFJtUcnwTOoZJjn6BL8oqXN+B6x_fxav@mail.gmail.com>
	(Nishanth Menon's message of "Tue, 8 Mar 2011 18:57:36 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Menon, Nishanth" <nm@ti.com> writes:

> On Tue, Mar 8, 2011 at 18:48, Premi, Sanjeev <premi@ti.com> wrote:
> [...]
>>> Thinking from a generic soln perspective, lets try and split this i=
nto
>>> multiple issues:
>>> a) OPP and Voltage layer voltages - these need to be PMIC aware as =
well.
>>> See my comment on http://marc.info/?l=3Dlinux-omap&m=3D129955003611=
548&w=3D2
>>> -> essentially means that pmic_voltage information should be regist=
ered
>>> earlier to opp init
>>>
>>> b) split up structure information for voltage layer - this should b=
e
>>> done in a manner to make PMIC, Board and OMAP SoC information indep=
endent.
>>>
>>> c) Ability to plug in multiple PMICs in two manners:
>>> =C2=A0 =C2=A0 i) use PMIC with VC/VP/SR combinations.
>>> =C2=A0 =C2=A0 ii) use PMIC which is plugged on regulator frameworks=
=2E
>>>
>>> If anyone is attempting cleanups, it might be a good idea to base o=
n the
>>> accepted cleanups from pm-core branch which is planned for 39-rc1 t=
o
>>> prevent any surprises ;)
>>
>> [sp] Without trying to understand much internal details on the propo=
sed
>> =C2=A0 =C2=A0 solution, workaround is necessary to get AM35x platfor=
ms to even boot
>> =C2=A0 =C2=A0 on current baselines.
>>
>> =C2=A0 =C2=A0 Using regulator framework etc. are long poles; that ca=
n easily be
>> =C2=A0 =C2=A0 avoided; and this RFC was meant for that.
>>
>> =C2=A0 =C2=A0 Knowing that there is already a clean-up effort; simpl=
e workaround
>> =C2=A0 =C2=A0 makes even better proposition.
> Personally speaking, it is better we do the cleanup and integrate to
> mainline. since we are in the process of cleaning up, it might be a
> good idea for contributions from you and all interested folks to
> ensure that the final code will support the configurations we all nee=
d

We have kwown for a long time that we have hard-coded PMIC assumptions
in the current code.  We have slowly added some minimal ways to make
PMIC-variable things pluggable, but indeed it has only ever been tested
with TWL* PMICs.

The best way to fix this going forward is for those who are adding
support for other PMICs to propose solutions that will make this scale
to other PMICs.

If that involves short-term hacks/workarounds to get things
building/booting on non-TWL4030 platforms, that is OK with me.  But I
would also like to be sure that efforts are underway to do it the right
way in parallel.

Kevin



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
