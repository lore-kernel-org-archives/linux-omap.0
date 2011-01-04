From: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Subject: Re: [PATCH v1 09/10] OMAP: McBSP: use omap_device APIs to modify SYSCONFIG
Date: Tue, 4 Jan 2011 15:04:44 +0530
Message-ID: <AANLkTin=SDVu0ujtfofB=rnxQ6w1FE7Q_Dm8bnXhdOgP@mail.gmail.com>
References: <1292917231-13800-1-git-send-email-kishon@ti.com>
	<1292917231-13800-9-git-send-email-kishon@ti.com>
	<4D22CDB0.6000503@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:43257 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751014Ab1ADJep convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Jan 2011 04:34:45 -0500
Received: by mail-qw0-f49.google.com with SMTP id 9so15274651qwj.22
        for <linux-omap@vger.kernel.org>; Tue, 04 Jan 2011 01:34:44 -0800 (PST)
In-Reply-To: <4D22CDB0.6000503@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@deeprootsystems.com, p-basak2@ti.com, b-cousson@ti.com

On Tue, Jan 4, 2011 at 1:05 PM, Peter Ujfalusi <peter.ujfalusi@nokia.co=
m> wrote:
>
> Hi,
>
> On 12/21/10 09:40, ext Kishon Vijay Abraham I wrote:
> > McBSP2/3 in OMAP3 has sidetone feature which requires autoidle
> > to be disabled before starting the sidetone. Also SYSCONFIG
> > register has to be set with smart idle or no idle depending on the
> > dma op mode (threshold or element sync). For doing these operations
> > dynamically at runtime, omap_device APIs are used to modify SYSCONF=
IG register.
> >
> > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>
>
> > =A0static inline void omap34xx_mcbsp_request(struct omap_mcbsp *mcb=
sp)
> > =A0{
> > + =A0 =A0 struct omap_device *od;
> > +
> > + =A0 =A0 od =3D find_omap_device_by_dev(mcbsp->dev);
> > =A0 =A0 =A0 /*
> > =A0 =A0 =A0 =A0* Enable wakup behavior, smart idle and all wakeups
> > =A0 =A0 =A0 =A0* REVISIT: some wakeups may be unnecessary
> > =A0 =A0 =A0 =A0*/
> > =A0 =A0 =A0 if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 u16 syscon;
> > -
> > - =A0 =A0 =A0 =A0 =A0 =A0 syscon =3D MCBSP_READ(mcbsp, SYSCON);
> > - =A0 =A0 =A0 =A0 =A0 =A0 syscon &=3D ~(ENAWAKEUP | SIDLEMODE(0x03)=
 | CLOCKACTIVITY(0x03));
> > -
> > - =A0 =A0 =A0 =A0 =A0 =A0 if (mcbsp->dma_op_mode =3D=3D MCBSP_DMA_M=
ODE_THRESHOLD) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 syscon |=3D (ENAWAKEUP | =
SIDLEMODE(0x02) |
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 CLOCKACTIVITY(0x02));
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MCBSP_WRITE(mcbsp, WAKEUP=
EN, XRDYEN | RRDYEN);
> > - =A0 =A0 =A0 =A0 =A0 =A0 } else {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 syscon |=3D SIDLEMODE(0x0=
1);
> > - =A0 =A0 =A0 =A0 =A0 =A0 }
> > -
> > - =A0 =A0 =A0 =A0 =A0 =A0 MCBSP_WRITE(mcbsp, SYSCON, syscon);
> > + =A0 =A0 =A0 =A0 =A0 =A0 if (mcbsp->dma_op_mode !=3D MCBSP_DMA_MOD=
E_THRESHOLD)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_device_noidle(od);
>
> Should you configure McBSP to SMART_IDLE, when the THRESHOLD mode is
> selected?
> While we are here:
> 1. How we select the WAKE events from McBSP?
> =A0 We need XRDYEN, and RRDYEN bits for wake (in WAKEUPEN register),

     Ahh.. Ok. This setting still need to be present. Will add it in
my next patch version.
     Thanks.

and
> =A0 also we need to enable the WAKEUP in SYSCON register.

     Setting of WAKEUPEN will be taken care by pm_runtime_get_sync()

> 2. How we are configuring the CLOCKACTIVITY field in SYSCON register?

       It's been set in the hwmod database. In [1], there is a field
=2Eclockact in
       omap_hwmod_class_sysconfig where we set the clock activity to 2.=
 Whenever
       we do a get_sync, CLOCKACTIVITY field in SYSCON register will be=
 set
       to the value present in .clockact field.

      [1] https://patchwork.kernel.org/patch/423731/

>
> --
> P=E9ter
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
