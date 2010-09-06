From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: [PATCH] OMAP CPUIDLE: CPU Idle latency measurement
Date: Mon, 6 Sep 2010 16:45:30 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087031162CEB7@dbde02.ent.ti.com>
References: <1282946913-26659-1-git-send-email-vishwanath.sripathy@linaro.org>
	<87bp8nn9yx.fsf@deeprootsystems.com>	<20100902075605.GB2962@matterhorn.lan>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CCED1488@dbde02.ent.ti.com>
 <AANLkTinmWTAwckEJJs8d4BW3PVRHSBwy4i-w=MNe5eDX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57422 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754221Ab0IFLPk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Sep 2010 07:15:40 -0400
In-Reply-To: <AANLkTinmWTAwckEJJs8d4BW3PVRHSBwy4i-w=MNe5eDX@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Amit Kucheria <amit.kucheria@linaro.org>, Kevin Hilman <khilman@deeprootsystems.com>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Jean,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Jean Pihet
> Sent: Thursday, September 02, 2010 2:39 PM
> To: Shilimkar, Santosh
> Cc: Amit Kucheria; Kevin Hilman; linaro-dev@lists.linaro.org; linux-
> omap@vger.kernel.org
> Subject: Re: [PATCH] OMAP CPUIDLE: CPU Idle latency measurement
>=20
> Hi Amit, Santosh,
>=20
> On Thu, Sep 2, 2010 at 10:11 AM, Shilimkar, Santosh
> <santosh.shilimkar@ti.com> wrote:
> ...
> >> > The point is to keep the minimum possible in the kernel: just th=
e
> >> > tracepoints we're interested in. =A0 The rest (calculations, ave=
rages,
> >> > analysis, etc.) does not need to be in the kernel and can be don=
e easier
> >> > and with more powerful tools outside the kernel.
> >>
> >> Kevin,
> >>
> >> I agree. We discussed this a little in our weekly meeting. Vishwa'=
s main
> >> concern was the lack of ability to instrument the last bit of SRAM=
 code.
> >>
> >> I have a feeling that even with caches on when we enter this code,=
 we
> >> won't
> >> see too much variance in the latency to execute this bit of code. =
Vishwa
> >> is
> >> going to confirm that now. If that hypothesis is true, we can inde=
ed move
> >> to
> >> using tracepoints in the idle path and use external tools to track=
 latency.
> I agree. Can you confirm this asap?

I did some profiling of assembly code on OMAP3630 board (ZOOM3). In wor=
st case it takes around 3.28ms and best case around 2.93ms for mpu off =
mode. For MPU INACTIVE/RET, it is less than 30us.=20
However as Kevin mentioned in other email, it would be better to find o=
ut a way to trace inside assembly code as well.

Regards
Vishwa
> I am looking at the instrumentation tracepoints now. I think it would
> be ideal to provide multiple tracepoints in both sleep and wake-up
> paths.
>=20
> > There will be difference with and without caches but the delta late=
ncy will be
> constant with caches and without caches. Another important point is
> > he lowest level code should be just profiled once and for worst CPU=
/BUS clock
> speed.
> Ok.
>=20
> >> Even if it isn't true, the rest of the idle path could still conta=
in
> >> tracepoints.
> I am looking at the best way to introduce tracepoints in the low leve=
l
> code, in case it is needed.
>=20
> > I also think this would be better approach considering a generic so=
lution.
> Good!
>=20
> >
> > Regards,
> > Santosh
> >
>=20
> Jean
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
