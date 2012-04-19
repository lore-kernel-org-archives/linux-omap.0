From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH v2 4/8] ARM: OMAP2+: hwmod: revise hardreset behavior
Date: Thu, 19 Apr 2012 16:15:12 -0500
Message-ID: <CAB-zwWg4cFV-0zUmc4izrv=o4de9rc-8UNiB4x8-Nd8E9VuVfg@mail.gmail.com>
References: <20120228053524.16278.59430.stgit@dusk>
 <20120228053654.16278.73632.stgit@dusk>
 <alpine.DEB.2.00.1204182253550.29048@utopia.booyaka.com>
 <4F90001E.8060201@ti.com>
 <alpine.DEB.2.00.1204191050110.29048@utopia.booyaka.com>
 <4F90641D.3090208@ti.com>
 <alpine.DEB.2.00.1204191338370.29048@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.00.1204191338370.29048@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-omap@vger.kernel.org, "Cousson,
 Benoit" <b-cousson@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Paul,

On Thu, Apr 19, 2012 at 2:46 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi Beno=EEt,
>
> On Thu, 19 Apr 2012, Cousson, Benoit wrote:
>
>> On 4/19/2012 7:17 PM, Paul Walmsley wrote:
>> > On Thu, 19 Apr 2012, Cousson, Benoit wrote:
>> >
>> > > The concern of the people doing SW in these embedded processors was =
mainly
>> > > because we were releasing the reset of processor without loading any=
 SW
>> > > first
>> > > and thus the processor was executing some random instructions.
>> > >
>> > > So if we consider a better hwmods definition, we can potentially fix=
 the
>> > > MMU
>> > > case:
>> > >
>> > > =A0 =A0 =A0'mmu_ipu':
>> > > =A0 =A0 =A0 =A0 =A0'rst_ipu_mmu_cache'
>> > >
>> > > =A0 =A0 =A0'mmu_dsp':
>> > > =A0 =A0 =A0 =A0 =A0'rst_dsp_mmu_cache'
>> > >
>> > > =A0 =A0 =A0'iva_config':
>> > > =A0 =A0 =A0 =A0 =A0'rst_logic'
>> >
>> > Wouldn't these still be "pseudo-hwmods?" =A0Or do each of these actual=
ly
>> > have address space, interconnect ports, etc.?
>>
>> Yes, these ones are the only real IPs for MPU stand point, with intercon=
nect
>> port and configuration registers.
>
> These are the MMUs documented in Chapter 20 of the OMAP4430 TRM
> vX, right?
>
> I don't really understand the interaction of the hardreset lines with
> these IPs. =A0Chapter 20 doesn't seem to mention the PRCM-controllable
> hardreset lines at all. =A0It only mentions the OCP_SYSCONFIG registers
> associated with them.
>
> Meanwhile Table 3-375 "RM_DSP_RSTCTRL" mentions a DSP MMU, cache, and
> slave interface reset line. =A0Is that referring to the same MMU that is
> mentioned in Chapter 20? =A0The end of Section 20.2 "MMU Integration"
> mentions two different DSP MMUs, a "shared cache MMU" and an "L2 MMU" -
> maybe the hardreset line only pertains to the first MMU?

I don't thinks so, because trying to read the L2 MMU registers with
DSP RST2 asserted causes an L3 error.

DSP's "shared cache MMU" refers to section 5.3.2.5 Attribute MMU which
is inside the dsp megamodule, OTOH "L2 MMU" refers to section 5.3.4
MMU, the latter is the one being referenced in section 20.

>> > > But then we do have the processor resets that have to be exposed
>> > > somewhere.
>> > >
>> > > =A0 =A0 =A0'ipu':
>> > > =A0 =A0 =A0 =A0 =A0'rst_cpu0'
>> > > =A0 =A0 =A0 =A0 =A0'rst_cpu1'
>> > >
>> > > =A0 =A0 =A0'dsp':
>> > > =A0 =A0 =A0 =A0 =A0'rst_dsp'
>> > >
>> > > =A0 =A0 =A0'iva':
>> > > =A0 =A0 =A0 =A0 =A0'rst_seq1'
>> > > =A0 =A0 =A0 =A0 =A0'rst_seq2'
>> > >
>> > > None of these one should be controlled automatically.
>> >
>> > Don't we still want to put these IP blocks into reset until a driver f=
or
>> > these IP blocks is loaded?
>>
>> Yes, indeed, my point is where are we going to declare these reset lines=
 if we
>> do not have any fake hwmods to store them.
>
> Wouldn't we associate them with the processor hwmods? =A0e.g.,
> omap44xx_iva_hwmod, omap44xx_dsp_hwmod ?
>
>> Well, for the MMU we can, these are regular IPs (almost). The real issue=
s was
>> for the processors.
>
> Omar, do you know =A0how these hardreset lines interact with the MMUs
> described in the TRM Chapter 20?

For M3, RM_MPU_M3_RSTCTRL[2].RST3 releases both the cache and mmu
interfaces, this one is needed if you want to program the mmu by
touching any of the MMU registers, typical initialization is to
deassert this line and then enable the M3 clock (since it is shared
with its MMU) which should allow the reset to complete *only* after
the clock has been enabled.

For DSP, RM_DSP_RSTCTRL[1].RST2 it also releases dsp, cache and mmu
(however the dsp doesn't boot until RST1 is deasserted), it is the
same rationale as above; you deassert RST2, enable dsp clock (so reset
can complete) and then program mmu.

Touching any mmu registers without deasserting its reset line (even if
the associated clock is ON) generates a L3 error.

This can be found in 3.5.6 Reset sequences for DSP and M3.

Regards,

Omar
