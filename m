From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v4 0/7] ARM/ASoC: OMAP3: Fix McBSP2/3 sidetone support
Date: Wed, 25 May 2016 17:37:36 +0300
Message-ID: <a709475e-03b5-69ef-01d4-ef3919d2b4e3@ti.com>
References: <1464185756-28401-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1464185756-28401-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, jarkko.nikula@bitmer.com, paul@pwsan.com, lgirdwood@gmail.com, broonie@kernel.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

my git send-email got interrupted by my ISP :o
The complete series should be up by now.

Sorry about it.

-- =

P=E9ter

On 05/25/2016 05:15 PM, Peter Ujfalusi wrote:
> Hi,
> =

> Changes since v3:
> - Rebased on next-20160525 [1] to apply cleanly
> - Fixed subject line for patch5
> - Added Mark's acked-by to the ASoC patches
> =

> [1] "ASoC: omap-mcbsp: Enable/disable sidetone block auto clock
> gating for omap3" is gone missing from linux-next - it was in next-201605=
17 and
> I'm not sure when it got dropped.
> =

> Tony: since Paul did not replied to the series, I'm sending the v4 now, I=
 hope
> he will have time to look at this.
> =

> Commit message from v3:
> =

> Based on the ongoing discussion on v2 (ARM: OMAP3: Fix McBSP2/3 hwmod set=
up for
> sidetone) I have dropped the removal of the sidetone hwmod and only corre=
cted
> it. The series now includes all related changes needed to have correct si=
detone
> support whenever we boot in legacy or in DT mode.
> =

> This time the ASoC part have dependency on earlier patches so they can no=
t be
> applied separately.
> =

> Regards,
> Peter
> ---
> Peter Ujfalusi (7):
>   ARM: OMAP3: hwmod data: Fix McBSP2/3 sidetone data
>   ARM: dts: omap3: Add clocks to McBSP nodes
>   ARM: OMAP3: McBSP: New callback for McBSP2/3 ICLK idle configuration
>   ARM: OMAP3: pdata-quirks: Add support for McBSP2/3 sidetone handling
>   ASoC: omap-mcbsp: Rename omap_mcbsp_sysfs_remove() to
>     omap_mcbsp_cleanup()
>   ASoC: omap-mcbsp: sidetone: Use the new callback for iclk handling
>   ARM: OMAP2+: McBSP: Remove the old iclk allow/deny idle code
> =

>  arch/arm/boot/dts/omap3.dtsi                | 10 ++++++++++
>  arch/arm/mach-omap2/mcbsp.c                 | 31 ++++++++++++++++-------=
------
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c  | 24 ++++------------------
>  arch/arm/mach-omap2/pdata-quirks.c          | 18 +++++++++++++++++
>  include/linux/platform_data/asoc-ti-mcbsp.h |  4 +++-
>  sound/soc/omap/mcbsp.c                      | 21 +++++++++++++------
>  sound/soc/omap/mcbsp.h                      |  3 ++-
>  sound/soc/omap/omap-mcbsp.c                 |  5 ++++-
>  8 files changed, 73 insertions(+), 43 deletions(-)
> =
