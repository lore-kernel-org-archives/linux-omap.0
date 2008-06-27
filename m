From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 2/7] 34XX: PM: Workaround to enable autoidle for clocks and plls
Date: Fri, 27 Jun 2008 12:08:51 +0300
Message-ID: <877icbckik.fsf@trdhcp146196.ntc.nokia.com>
References: <87ej6lj2ui.fsf@trdhcp146196.ntc.nokia.com>
	<1214385223-25597-1-git-send-email-jouni.hogander@nokia.com>
	<006f01c8d834$25b3d2a0$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:52807 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbYF0JJS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jun 2008 05:09:18 -0400
In-Reply-To: <006f01c8d834$25b3d2a0$68bf18ac@ent.ti.com> (ext Rajendra Nayak's
	message of "Fri, 27 Jun 2008 14:29:44 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

"ext Rajendra Nayak" <rnayak@ti.com> writes:
>>  	/* setup wakup source */
>>  	prm_write_mod_reg(OMAP3430_EN_IO | OMAP3430_EN_GPIO1 |=20
>> OMAP3430_EN_GPT1,
>>  			  WKUP_MOD, PM_WKEN);
>
> The previous patchset also has this function enable the D2D clock dom=
ain H/w supervised.
> Is this now done some other place? Not doing this gates CORE
> RET/OFF.

d2d clkdm wasn't earlier handled by clkdm code in case of silicon rev >
ES1, bacause it is not documented to exist in them. Now it is handled
by clkdm/pwrdm code and idle is allowed same way as for other clkdms.


>
>         if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0)) {
>                 /* This hack is taken from ti code. There is no usb c=
lkdm in
>                  * core, but this still needs to be written: allow id=
le of usb
>                  * clkdm? */
>                 v =3D cm_read_mod_reg(CORE_MOD, CM_CLKSTCTRL);
>                 v |=3D 0x30;
>                 cm_write_mod_reg(v, CORE_MOD, CM_CLKSTCTRL);
>         }
>
>> --=20
>> 1.5.5
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe=20
>> linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>=20
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
