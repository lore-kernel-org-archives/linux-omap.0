From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/2] OMAP: PM: implement devices constraints APIs
Date: Thu, 10 Mar 2011 11:51:58 -0800
Message-ID: <87y64mbvoh.fsf@ti.com>
References: <1299250375-26134-1-git-send-email-j-pihet@ti.com>
	<1299698346-2768-1-git-send-email-j-pihet@ti.com>
	<AANLkTikQOfsteZUAzSWjO-BbAW=ZEX22mhRUFHBMeFTR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:38885 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751664Ab1CJTwD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 14:52:03 -0500
Received: by mail-px0-f169.google.com with SMTP id 9so487014pxi.0
        for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 11:52:01 -0800 (PST)
In-Reply-To: <AANLkTikQOfsteZUAzSWjO-BbAW=ZEX22mhRUFHBMeFTR@mail.gmail.com>
	(Jean Pihet's message of "Wed, 9 Mar 2011 20:37:51 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, Jean Pihet <j-pihet@ti.com>, Vibhore Vardhan <vvardhan@ti.com>

Jean Pihet <jean.pihet@newoldbits.com> writes:

[...]

>> + =C2=A0 =C2=A0 =C2=A0 if (pwrdm_read_pwrst(pwrdm) !=3D new_state) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D omap_set_=
pwrdm_state(pwrdm, new_state);
>
> The function pwrdms_setup (called from omap3_pm_init for every pwrdm)
> runs late in the boot process and so it overwrites the registers
> values programmed by omap_set_pwrdm_state with the default values.
> Could the default values get written earlier in the boot process (e.g=
=2E
> at hwmod init) before the devices can put constraints on the power
> domains?

Yes, default vaules for each power domain's next state should probably
be written earlier in the boot.  Probably when the powerdomain is
initialized, or at least when this constraints framework is initialized=
=2E

Then, the initial states set in omap3_pm_init() can just be removed.

Kevin


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
