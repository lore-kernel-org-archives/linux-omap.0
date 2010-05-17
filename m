From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: RE: [PATCH 02/14] dspbridge: deh: trivial cleanups
Date: Sun, 16 May 2010 21:31:16 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602CB6CB099@dlee06.ent.ti.com>
References: <1274024765-21076-1-git-send-email-felipe.contreras@gmail.com>
	 <1274024765-21076-3-git-send-email-felipe.contreras@gmail.com>
	 <496565EC904933469F292DDA3F1663E602CB6CB077@dlee06.ent.ti.com>
 <AANLkTin-f7RzW3vXL-fYAirGEzN_O1RD0LjmcVJdp1v7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52247 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752289Ab0EQCbT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 May 2010 22:31:19 -0400
In-Reply-To: <AANLkTin-f7RzW3vXL-fYAirGEzN_O1RD0LjmcVJdp1v7@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>


Hi,

> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
> Sent: Sunday, May 16, 2010 5:13 PM
> To: Guzman Lugo, Fernando
> Cc: linux-omap; Ramirez Luna, Omar
> Subject: Re: [PATCH 02/14] dspbridge: deh: trivial cleanups
>=20
> On Mon, May 17, 2010 at 1:02 AM, Guzman Lugo, Fernando
> <fernando.lugo@ti.com> wrote:
>=20
> >> + =A0 =A0 for (c =3D 0; c < GPTIMER_IRQ_WAIT_MAX_CNT; c++)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if ((omap_dm_timer_read_status(timer) &
> GPTIMER_IRQ_OVERFLOW))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> >> +
> >> + =A0 =A0 pr_err("%s: GPTimer interrupt failed\n", __func__);
> >
> > In case of not timeout the timer is not disabled, that could preven=
t
> power transition to off. It should be disable as soon as it is not ne=
eded
> which is after calling dump_dsp_stack.
>=20
> Right, I originally had timer_disable() outside of wait_for_timeout()=
,
> and only later decided to put it in. However, do we still need to let
> the timer on? Can't we disable the timer always before dumping the
> stack? The rest of the code seems to run fine with the timer disabled=
=2E

If there is no f/i clock the DSP cannot ack the interruption, maybe rea=
ding the register without the clocks not cause a fatal in the DSP. But =
you will have issues if the ack is not done.

Regards,
=46ernando.

>=20
> >> =A0 =A0 =A0 omap_dm_timer_disable(timer);
> >> =A0}
>=20
> Cheers.
>=20
> --
> Felipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
