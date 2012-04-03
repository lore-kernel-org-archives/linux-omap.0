From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Tue, 3 Apr 2012 15:12:30 +0530
Message-ID: <CAMQu2gxE2STYxUGinzstX6W8jyofH829A__NQBjwLqZd9cqy=w@mail.gmail.com>
References: <CAAO=S0+L2Q1YZC-pfm2Lz8jPooTeHYOMaZbtRgHYFoL_m7rvhA@mail.gmail.com>
 <4F0B182D.7060507@us.ibm.com> <20120109224945.GA23090@mudshark.cambridge.arm.com>
 <CACVXFVMnAt_YpYNC5B6W4Vh4HvtVS3D6jRORUw0AW5a4ub5aOw@mail.gmail.com>
 <CAMsRxfJe_MEA=anzRu6jehGcZyg49uAx44_nDQ3_FRY=WrFLoA@mail.gmail.com>
 <CACVXFVNXJ2vZM-dAxQPQ5LSOuvv5yvOrnytOB9PxURtkaSCP8w@mail.gmail.com>
 <CACVXFVMH9WZDqs-mVjxL=1FY12uHyQAJMTCQuU5ru1wQT+YnZg@mail.gmail.com>
 <CAMQu2gzW706YbOzHa4Am0=X17T0G3zBhOmWUd8eC6GY9F6OBog@mail.gmail.com>
 <CACVXFVPb-McJj1oi284RW37Pe08cAXSw-jteFwfNVPpCJx5EaQ@mail.gmail.com>
 <CAMQu2gwvgPfZv_LnB6GnYs=Wt+wj9GFPEDYiDK6C8TiTag3gTg@mail.gmail.com> <20120403092524.GD17741@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:45884 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751429Ab2DCJnD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Apr 2012 05:43:03 -0400
Received: by qcsp15 with SMTP id p15so2633818qcs.30
        for <linux-omap@vger.kernel.org>; Tue, 03 Apr 2012 02:43:01 -0700 (PDT)
In-Reply-To: <20120403092524.GD17741@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Ming Lei <ming.lei@canonical.com>, "eranian@gmail.com" <eranian@gmail.com>, Maynard Johnson <maynardj@us.ibm.com>, Lik Lik <lik88888@gmail.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

On Tue, Apr 3, 2012 at 2:55 PM, Will Deacon <will.deacon@arm.com> wrote=
:
> Santosh,
>
> On Wed, Jan 18, 2012 at 12:33:23PM +0000, Shilimkar, Santosh wrote:
>> On Wed, Jan 18, 2012 at 1:24 PM, Ming Lei <ming.lei@canonical.com> w=
rote:
>> >>> diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c
>> >>> b/arch/arm/mach-omap2/clockdomains44xx_data.c
>> >>> index 9299ac2..41d2260 100644
>> >>> --- a/arch/arm/mach-omap2/clockdomains44xx_data.c
>> >>> +++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
>> >>> @@ -390,7 +390,7 @@ static struct clockdomain emu_sys_44xx_clkdm=
 =3D {
>> >>> =A0 =A0 =A0 =A0.prcm_partition =A0 =3D OMAP4430_PRM_PARTITION,
>> >>> =A0 =A0 =A0 =A0.cm_inst =A0 =A0 =A0 =A0 =A0=3D OMAP4430_PRM_EMU_=
CM_INST,
>> >>> =A0 =A0 =A0 =A0.clkdm_offs =A0 =A0 =A0 =3D OMAP4430_PRM_EMU_CM_E=
MU_CDOFFS,
>> >>> - =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0 =A0=3D CLKDM_CAN_HWSUP,
>> >>> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0 =A0=3D CLKDM_CAN_SWSUP,
>> >>> =A0};
>> >> NAK.
>> >>
>> >> You don't need this patch. What you saw on CAMERA was indeed
>> >> a known bug but emulation domain has no such issues.
>> >>
>> >> So the accesses to emulation register should continue to work
>> >> with the clock-domain being kept under hardware supervision.
>> >
>> > But why can this patch make omap4 pmu work? =A0Without the patch,
>> > there are no CTI interrupts generated for pmu irq.
>> >
>> Interesting. For me debugger works which also relies on Emulation do=
main.
>>
>> Need to see why CTI is behaving like this.
>
> Did you ever get to the bottom of this? This change really is require=
d in
> order to generate PMU interrupts with the CTI and I don't know of any
> alternative to the above.
>
> Any suggestions?
>
Sorry I lost track of this one. There is one relevant patch in Kevin's =
queue
for 3.4/fixes. [1] which I generated for perf time stamp issue.

Can you try that patch and see if it helps the CTI issue as well ? Ther=
e
is an outside chance that it might help. If it doesn't, we should commi=
t
Ming Lei  patch.

Regards
Santosh

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-March/08=
9679.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
