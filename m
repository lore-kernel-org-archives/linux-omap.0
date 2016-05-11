From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 0/7] ARM/ASoC: OMAP3: Fix McBSP2/3
	sidetone support
Date: Wed, 11 May 2016 11:44:33 +0300
Message-ID: <69ff65ee-e5d1-09fb-fd91-8d7b4d8fdda4@ti.com>
References: <1461927202-17677-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1461927202-17677-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tony@atomide.com, jarkko.nikula@bitmer.com, paul@pwsan.com, lgirdwood@gmail.com, broonie@kernel.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Tony, Paul,

On 04/29/16 13:53, Peter Ujfalusi wrote:
> Hi,
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

How should we proceed from here? I don't want to start designing the ST
separation infrastructure which would be based on this series, but if there
are outstanding issues found on this, I would need to go back to the drawing
board.
The separation will be mostly new code and code shuffle in ASoC, but for
legacy I will need to build up something in arch as well, so I would need at
least one release cycle to start with things.

-- =

P=E9ter

> Regards,
> Peter
> ---
> Peter Ujfalusi (7):
>   ARM: OMAP3: hwmod data: Fix McBSP2/3 sidetone data
>   ARM: dts: omap3: Add clocks to McBSP nodes
>   ARM: OMAP3: McBSP: New callback for McBSP2/3 ICLK idle configuration
>   ARM: OMAP3: pdata-quirks: Add support for McBSP2/3 sidetone handling
>   ASoc: omap-mcbsp: Rename omap_mcbsp_sysfs_remove() to
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
