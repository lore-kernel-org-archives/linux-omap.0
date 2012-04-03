From: Will Deacon <will.deacon@arm.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Tue, 3 Apr 2012 10:25:24 +0100
Message-ID: <20120403092524.GD17741@mudshark.cambridge.arm.com>
References: <CAAO=S0+L2Q1YZC-pfm2Lz8jPooTeHYOMaZbtRgHYFoL_m7rvhA@mail.gmail.com>
 <4F0B182D.7060507@us.ibm.com>
 <20120109224945.GA23090@mudshark.cambridge.arm.com>
 <CACVXFVMnAt_YpYNC5B6W4Vh4HvtVS3D6jRORUw0AW5a4ub5aOw@mail.gmail.com>
 <CAMsRxfJe_MEA=anzRu6jehGcZyg49uAx44_nDQ3_FRY=WrFLoA@mail.gmail.com>
 <CACVXFVNXJ2vZM-dAxQPQ5LSOuvv5yvOrnytOB9PxURtkaSCP8w@mail.gmail.com>
 <CACVXFVMH9WZDqs-mVjxL=1FY12uHyQAJMTCQuU5ru1wQT+YnZg@mail.gmail.com>
 <CAMQu2gzW706YbOzHa4Am0=X17T0G3zBhOmWUd8eC6GY9F6OBog@mail.gmail.com>
 <CACVXFVPb-McJj1oi284RW37Pe08cAXSw-jteFwfNVPpCJx5EaQ@mail.gmail.com>
 <CAMQu2gwvgPfZv_LnB6GnYs=Wt+wj9GFPEDYiDK6C8TiTag3gTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:55031 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751353Ab2DCJZw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Apr 2012 05:25:52 -0400
Content-Disposition: inline
In-Reply-To: <CAMQu2gwvgPfZv_LnB6GnYs=Wt+wj9GFPEDYiDK6C8TiTag3gTg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Ming Lei <ming.lei@canonical.com>, "eranian@gmail.com" <eranian@gmail.com>, Maynard Johnson <maynardj@us.ibm.com>, Lik Lik <lik88888@gmail.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Santosh,

On Wed, Jan 18, 2012 at 12:33:23PM +0000, Shilimkar, Santosh wrote:
> On Wed, Jan 18, 2012 at 1:24 PM, Ming Lei <ming.lei@canonical.com> wr=
ote:
> >>> diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c
> >>> b/arch/arm/mach-omap2/clockdomains44xx_data.c
> >>> index 9299ac2..41d2260 100644
> >>> --- a/arch/arm/mach-omap2/clockdomains44xx_data.c
> >>> +++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
> >>> @@ -390,7 +390,7 @@ static struct clockdomain emu_sys_44xx_clkdm =
=3D {
> >>> =A0 =A0 =A0 =A0.prcm_partition =A0 =3D OMAP4430_PRM_PARTITION,
> >>> =A0 =A0 =A0 =A0.cm_inst =A0 =A0 =A0 =A0 =A0=3D OMAP4430_PRM_EMU_C=
M_INST,
> >>> =A0 =A0 =A0 =A0.clkdm_offs =A0 =A0 =A0 =3D OMAP4430_PRM_EMU_CM_EM=
U_CDOFFS,
> >>> - =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0 =A0=3D CLKDM_CAN_HWSUP,
> >>> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0 =A0=3D CLKDM_CAN_SWSUP,
> >>> =A0};
> >> NAK.
> >>
> >> You don't need this patch. What you saw on CAMERA was indeed
> >> a known bug but emulation domain has no such issues.
> >>
> >> So the accesses to emulation register should continue to work
> >> with the clock-domain being kept under hardware supervision.
> >
> > But why can this patch make omap4 pmu work? =A0Without the patch,
> > there are no CTI interrupts generated for pmu irq.
> >
> Interesting. For me debugger works which also relies on Emulation dom=
ain.
>=20
> Need to see why CTI is behaving like this.

Did you ever get to the bottom of this? This change really is required =
in
order to generate PMU interrupts with the CTI and I don't know of any
alternative to the above.

Any suggestions?

Will
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
