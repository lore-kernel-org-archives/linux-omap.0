From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 02/14] dspbridge: deh: trivial cleanups
Date: Mon, 17 May 2010 01:13:05 +0300
Message-ID: <AANLkTin-f7RzW3vXL-fYAirGEzN_O1RD0LjmcVJdp1v7@mail.gmail.com>
References: <1274024765-21076-1-git-send-email-felipe.contreras@gmail.com>
	 <1274024765-21076-3-git-send-email-felipe.contreras@gmail.com>
	 <496565EC904933469F292DDA3F1663E602CB6CB077@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38982 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962Ab0EPWNI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 May 2010 18:13:08 -0400
Received: by fxm6 with SMTP id 6so3201837fxm.19
        for <linux-omap@vger.kernel.org>; Sun, 16 May 2010 15:13:05 -0700 (PDT)
In-Reply-To: <496565EC904933469F292DDA3F1663E602CB6CB077@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>

On Mon, May 17, 2010 at 1:02 AM, Guzman Lugo, Fernando
<fernando.lugo@ti.com> wrote:

>> + =C2=A0 =C2=A0 for (c =3D 0; c < GPTIMER_IRQ_WAIT_MAX_CNT; c++)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((omap_dm_timer_read_=
status(timer) & GPTIMER_IRQ_OVERFLOW))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return;
>> +
>> + =C2=A0 =C2=A0 pr_err("%s: GPTimer interrupt failed\n", __func__);
>
> In case of not timeout the timer is not disabled, that could prevent =
power transition to off. It should be disable as soon as it is not need=
ed which is after calling dump_dsp_stack.

Right, I originally had timer_disable() outside of wait_for_timeout(),
and only later decided to put it in. However, do we still need to let
the timer on? Can't we disable the timer always before dumping the
stack? The rest of the code seems to run fine with the timer disabled.

>> =C2=A0 =C2=A0 =C2=A0 omap_dm_timer_disable(timer);
>> =C2=A0}

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
