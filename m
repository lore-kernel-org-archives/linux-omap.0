From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: PM related performance degradation on OMAP3
Date: Wed, 11 Apr 2012 03:29:58 +0300
Message-ID: <CANOLnOPbHBshCdbmSOjYdubWqUivrVpR-+eaayu=v4Yy6yKdsQ@mail.gmail.com>
References: <CANOLnOP5gq4Vtt00SgRNW-3GZDWk0sukBgJx4V6rkMLL+b6G-w@mail.gmail.com>
	<877gxobudk.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40980 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759830Ab2DKA37 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Apr 2012 20:29:59 -0400
Received: by iagz16 with SMTP id z16so493932iag.19
        for <linux-omap@vger.kernel.org>; Tue, 10 Apr 2012 17:29:59 -0700 (PDT)
In-Reply-To: <877gxobudk.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

On Mon, Apr 9, 2012 at 10:03 PM, Kevin Hilman <khilman@ti.com> wrote:
> Grazvydas Ignotas <notasas@gmail.com> writes:
>> While SD card performance loss is not that bad (~7%), NAND one is
>> worrying (~39%). I've tried disabling/enabling CONFIG_CPU_IDLE, also
>> cpuidle states over sysfs, it did not have any significant effect. I=
s
>> there something else to try?
>
> Looks like we might need a PM QoS constraint when there is DMA activi=
ty
> in progress.
>
> You can try doing a pm_qos_add_request() for PM_QOS_CPU_DMA_LATENCY w=
hen
> DMA transfers are active and I suspect that will help.

I've tried it and it didn't help much. It looks like the only thing it
does is limiting cpuidle c-states, I tried to set qos dma latency to 0
and it made it stay in C1 while transfer was ongoing (I watched
/sys/devices/system/cpu/cpu0/cpuidle/state*/usage), but performance
was still poor.

What I think is going on here is that omap_sram_idle() is taking too
much time because it's overhead is too large. I've added a counter
there and it seems to be called ~530 times per megabyte (DMA operates
in ~2K chunks so it makes sense), that's over 2000 calls per second.
Some quick measurement code shows ~243us spent for setting up in
omap_sram_idle() (before and after omap34xx_do_sram_idle()).

Could we perhaps have a lighter idle function for C1 that doesn't try
to switch all powerdomain states and maybe not enable RAM
self-refresh? As a quick test I've tried this in omap3_enter_idle():

        /* Execute ARM wfi */
        if (index =3D=3D 0) {
                clkdm_deny_idle(mpu_pd->pwrdm_clkdms[0]);
                cpu_do_idle();
        } else
                omap_sram_idle();

=2E.and it brought performance close to !CONFIG_PM case (cpu_do_idle()
is used as pm_idle on !CONFIG_PM). I don't know what side effects
something like this might have though.

>> Then there is omap3_do_wfi, it seems to be unconditionally putting
>> SDRC on self-refresh, would it make sense to just do wfi in higher
>> power states, like OMAP4 seems to be doing?
>
> Not sure what you're referring to in OMAP4. =C2=A0There we do WFI in =
every
> idle state.

What I meant is that OMAP3 idle code always tries to enable RAM
self-refresh (regardless of c-state) before doing wfi while OMAP4 can
do wfi without suspending RAM (although I might be misunderstanding
all that asm code).

--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
