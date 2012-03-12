From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: [PATCH] omap_hwmod: Allow io_ring wakeup configuration for all modules.
Date: Mon, 12 Mar 2012 17:19:07 +0530
Message-ID: <CAMrsUdLe1gq-tWeg_GgEp_HHUVXCGMgegCtfEzEp9zzMpbDfHA@mail.gmail.com>
References: <1331122775-761-1-git-send-email-govindraj.raja@ti.com> <CAMrsUdJq8J8dTnKcZmXgMucDX=dNXgR+9xFhYOdHvNDuw_=4Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:51626 "HELO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752422Ab2CLLt2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Mar 2012 07:49:28 -0400
Received: by mail-gy0-f176.google.com with SMTP id z10so3025579ghb.35
        for <linux-omap@vger.kernel.org>; Mon, 12 Mar 2012 04:49:27 -0700 (PDT)
In-Reply-To: <CAMrsUdJq8J8dTnKcZmXgMucDX=dNXgR+9xFhYOdHvNDuw_=4Mw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.infradead.org, "Govindraj.R" <govindraj.raja@ti.com>, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>

On Wed, Mar 7, 2012 at 7:40 PM, Raja, Govindraj <govindraj.raja@ti.com>=
 wrote:
> On Wed, Mar 7, 2012 at 5:49 PM, Govindraj.R <govindraj.raja@ti.com> w=
rote:
>>

[...]

>
> From b3aa1dac5909cad1b959f5b97bbf408b2f974060 Mon Sep 17 00:00:00 200=
1
> From: "Govindraj.R" <govindraj.raja@ti.com>
> Date: Wed, 7 Mar 2012 17:14:02 +0530
> Subject: [PATCH] omap_hwmod: Allow io_ring wakeup configuration for a=
ll
> =A0modules.
>
> Some modules doesn't have SYSC_HAS_ENAWAKEUP bit available
> (ex: usb host uhh module) in absence of this flag
> omap_hwmod_enable/disable_wakeup avoids configuring
> pad mux wakeup capability.
>
> Configure sysc if SYSC_HAS_ENAWAKEUP is available and for other cases
> try enabling/disabling wakeup from mux_pad pins.
>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---

Gentle Ping.

--
Thanks,
Govindraj.R



> =A0arch/arm/mach-omap2/omap_hwmod.c | =A0 30 ++++++++++++++++--------=
------
> =A01 files changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/o=
map_hwmod.c
> index eba6cd3..9605fad 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -2475,14 +2475,15 @@ int omap_hwmod_enable_wakeup(struct omap_hwmo=
d *oh)
> =A0 =A0 =A0 =A0unsigned long flags;
> =A0 =A0 =A0 =A0u32 v;
>
> - =A0 =A0 =A0 if (!oh->class->sysc ||
> - =A0 =A0 =A0 =A0 =A0 !(oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAK=
EUP))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> -
> =A0 =A0 =A0 =A0spin_lock_irqsave(&oh->_lock, flags);
> - =A0 =A0 =A0 v =3D oh->_sysc_cache;
> - =A0 =A0 =A0 _enable_wakeup(oh, &v);
> - =A0 =A0 =A0 _write_sysconfig(v, oh);
> +
> + =A0 =A0 =A0 if (oh->class->sysc &&
> + =A0 =A0 =A0 =A0 =A0 (oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKE=
UP)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 v =3D oh->_sysc_cache;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _enable_wakeup(oh, &v);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _write_sysconfig(v, oh);
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0_set_idle_ioring_wakeup(oh, true);
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&oh->_lock, flags);
>
> @@ -2506,14 +2507,15 @@ int omap_hwmod_disable_wakeup(struct omap_hwm=
od *oh)
> =A0 =A0 =A0 =A0unsigned long flags;
> =A0 =A0 =A0 =A0u32 v;
>
> - =A0 =A0 =A0 if (!oh->class->sysc ||
> - =A0 =A0 =A0 =A0 =A0 !(oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAK=
EUP))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> -
> =A0 =A0 =A0 =A0spin_lock_irqsave(&oh->_lock, flags);
> - =A0 =A0 =A0 v =3D oh->_sysc_cache;
> - =A0 =A0 =A0 _disable_wakeup(oh, &v);
> - =A0 =A0 =A0 _write_sysconfig(v, oh);
> +
> + =A0 =A0 =A0 if (oh->class->sysc &&
> + =A0 =A0 =A0 =A0 =A0 (oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKE=
UP)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 v =3D oh->_sysc_cache;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _disable_wakeup(oh, &v);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _write_sysconfig(v, oh);
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0_set_idle_ioring_wakeup(oh, false);
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&oh->_lock, flags);
>
> --
> 1.7.5.4
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
