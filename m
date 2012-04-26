From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [PATCH-V4 3/3] ARM: OMAP: Make OMAP clocksource source selection
 using kernel param
Date: Thu, 26 Apr 2012 13:43:10 -0700
Message-ID: <CA+Bv8XYG2heeWKMt-gdWkPD3_1kkcZspP_XgvCAdwynXzTA3AQ@mail.gmail.com>
References: <1335260749-25877-1-git-send-email-hvaibhav@ti.com>
	<1335260749-25877-4-git-send-email-hvaibhav@ti.com>
	<87aa1ybaxf.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:63037 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756335Ab2DZUnM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Apr 2012 16:43:12 -0400
Received: by lbbgf7 with SMTP id gf7so26441lbb.19
        for <linux-omap@vger.kernel.org>; Thu, 26 Apr 2012 13:43:10 -0700 (PDT)
In-Reply-To: <87aa1ybaxf.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, santosh.shilimkar@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Ming Lei <tom.leiming@gmail.com>

On Thu, Apr 26, 2012 at 11:33 AM, Kevin Hilman <khilman@ti.com> wrote:
> Vaibhav Hiremath <hvaibhav@ti.com> writes:
>
>> Current OMAP code supports couple of clocksource options based
>> on compilation flag (CONFIG_OMAP_32K_TIMER). The 32KHz sync-timer
>> and a gptimer which can run on 32KHz or system clock (e.g 38.4 MHz).
>
> [...]
>
>> +
>> + =C2=A0 =C2=A0 sync32k_ick =3D clk_get(NULL, "omap_32ksync_ick");
>> + =C2=A0 =C2=A0 if (!IS_ERR(sync32k_ick))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clk_enable(sync32k_ick);
>> +
>> + =C2=A0 =C2=A0 sync32k_cnt_reg =3D base + OMAP2_32KSYNCNT_CR_OFF;
>> +
>> + =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0* 120000 rough estimate from the calculations =
in
>> + =C2=A0 =C2=A0 =C2=A0* __clocksource_updatefreq_scale.
>> + =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 clocks_calc_mult_shift(&persistent_mult, &persistent=
_shift,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 32768, NSEC_PER_SEC, 120000);
>> +
>> + =C2=A0 =C2=A0 ret =3D clocksource_mmio_init(base, "32k_counter", 3=
2768, 250, 32,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clocksource_mmio_readl_up);
>
> After discussing this a bit with Vaibhav offline, we found that 'base=
'
> here should be sync32k_cnt_reg.
>
> Can you guys that were seeing the hang confirm that that fixes the
> issue?
>
> If so, please reply with your Tested-by.

Tested-by: Russ Dill <Russ.Dill@ti.com>

All three patches in series boot tested on:
Beagleboard xM
Beagleboard B4
Mistral AM37X-EVM
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
