From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/3] ARM: OMAP3: Fix McBSP2/3 hwmod setup
	for sidetone
Date: Mon, 21 Mar 2016 10:38:52 +0200
Message-ID: <56EFB31C.9090103@ti.com>
References: <1458296929-718-1-git-send-email-peter.ujfalusi@ti.com>
 <alpine.DEB.2.02.1603191908070.6629@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <alpine.DEB.2.02.1603191908070.6629@utopia.booyaka.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Paul Walmsley <paul@pwsan.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

Paul,

On 03/19/16 21:31, Paul Walmsley wrote:
> On Fri, 18 Mar 2016, Peter Ujfalusi wrote:
> =

>> The series addresses a long standing issue with McBSP2/3 regarding to hw=
mod
>> setup. When booting with DT a warning is printed that mcbsp2/3 is using =
two
>> hwmod.
>> The root of the issue is the way how the hwmod data was constructed in t=
he first
>> place for OMAP3 McBSP2/3.
>> After re-reading the TRM it is clear that the sidetone should not have i=
t's
>> own hwmod data as it is not a separate IP, it is part of the McBSP modul=
e.
> =

> Odd.  I come to exactly the opposite conclusion from reading the TRM.

I was looking at the Figure 21-2 in chapter 21.1.2 SIDETONE core:
McBSP2/3 module consist of McBSP core + SIDETONE core.

In fact the SIDETONE blocks clearly should be hwmods, according to the
> documentation.
> =

> Consider:
> =

> 1. The SIDETONE blocks have their own L4 ports - as documented in the =

> OMAP36xx public TRM rev Z,  Table 2-5 "L4-Peripheral Memory Space".

The SIDETONE feature is an addition on top of 'standard' McBSP

> 2. The SIDETONE blocks have different register access width restrictions =

> from the McBSP.  Ibid., Table 2-7 "Register Access Restrictions".

Yes, this is odd. McBSP is 32bits and the McBSP sidetone is 8/16/32bits

> 3. The SIDETONE blocks have distinct L4-Per firewall region IDs from thei=
r =

> corresponding McBSP IP blocks.  Ibid., Table 9-114 "Region Allocation for =

> L4-Per Interconnect".

This is also interesting:
McBSP2 sidetone is in region 39 and 40 (module and L4 interconnect) which is
unique in case of OMAP34xx and OMAP35xx, but it is overlapping with GPIO6 on
OMAP36xx. Not sure what are the implications.

> 4. The SIDETONE blocks have their own L4 target interconnect agents.  =

> Table 9-128 "L4-Per Instance Summary"

As they are different in the memory map.

> 5. The SIDETONE blocks have their own MPU IRQ lines, distinct from the =

> McBSP block IRQ lines.  Table 12-4 "Interrupt Mapping to the MPU =

> Subsystem"

Well, all McBSP have 3 distinct MPU IRQ lines: combined, RX, TX (McBSP2:
combined: 17, TX: 62, RX: 63 for example). This does not make the McBSP RX =
and
TX different IP block.

> 6. The SIDETONE IP block register target space is distinct from the =

> corresponding McBSP address ranges.  Table 21-36 "McBSP Instance Summary"

Yes, they are as it is an additional feature integrated into only McBSP2/3 =
module.

> 7. The SIDETONE IP blocks have their own "TI OCP" integration registers.  =

> Table 21-134 "ST_REV_REG", Table 21-136 "ST_SYSCONFIG_REG".

Which does not work in a way it is supposed to work.
As per the TRM (SWPU177T - OMAP36xx) 21.3.2.2.6:
McBSPi.ST_SYSCONFIG_REG[0] AUTOIDLE bit:
- When this bit is asserted (set to 1), the McBSPi_ICLK clock auto-gating is
enabled and this clock is disabled internally to the SIDETONE feature, thus
reducing power consumption, but not to the McBSP module that contains this
feature.
After reset, the automatic clock gating is enabled; thus, this bit must be
disabled by software for activated SIDETONE feature.
- When this bit is set to 0, the McBSPi_ICLK clock auto-gating is disabled =
and
this clock is enabled. The SIDETONE feature can be used normally.

The important part being: "When this bit is asserted (set to 1), the
McBSPi_ICLK clock auto-gating is enabled and this clock is disabled interna=
lly
to the SIDETONE feature"

In my reading the McBSPi.ST_SYSCONFIG_REG[0] AUTOIDLE is internal to McBSP
module and it will not affect the PRCM level of gating the McBSP2/3_ICLK. M=
ost
likely the actual plan was that by setting this bit the McBSP core should
prevent the ICLK auto gating, but it is - as you know - not working that wa=
y.

> A better solution to the warnings you mention at the top of the message i=
s =

> to provide a separate low-level McBSP SIDETONE IP block device driver, =

> distinct from the existing McBSP low-level IP block driver.

If we treat the McBSP sidetone as a distinct module (which is not) of OMAP3:
we will have two hwmods and two drivers poking with the same PRCM registers=
 as
we need this for the sidetone: if it is enabled we need to disable the
autoidle for the McBSP_ICLK for the given McBSP module the sidetone is part=
 of.
The sidetone can be enabled/disabled any time when McBSP is active so if we
have McBSP running and we enable the sidetone the McBSP_ICLK should not idl=
e,
when the sidetone is disabled and McBSP is still in use we can not disable =
the
McBSP in PRCM level, but we can enable the ICLK autoidle.

>> It can not affect PRCM either since it's SYSCONFIG register's AUTOIDLE =

>> bit is only sets the autoidle from the internal McBSP_iclk clock to the =

>> sidetone block of the same McBSP.
> =

> Can't parse this - could you try again?  Are you referring to the erratum =

> where someone forgot to hook up the SIDETONE idle signals to the PRCM, an=
d =

> the MCBSP_ICLK has to be manually kept active when the SIDETONE block is =

> active?

Probably there is an errata for this, but 21.3.2.2.6 tells that the
McBSPi.ST_SYSCONFIG[0] AUTOIDLE is working internally to the SIDETONE featu=
re.
The intention must have been that in case the SIDETONE is in use, the McBSP
module itself should prevent the autoidle, but it is not. We all know that
this is not going to be fixed by new revision.

-- =

P=E9ter
