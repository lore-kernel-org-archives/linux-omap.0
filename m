From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 0/2] ARM: OMAP2+ McASP(3) support for DRA7xx family
Date: Tue, 27 Oct 2015 10:37:37 +0200
Message-ID: <562F37D1.8030105@ti.com>
References: <1444814608-20908-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1444814608-20908-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, paul@pwsan.com
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Paul,

On 10/14/2015 12:23 PM, Peter Ujfalusi wrote:
> Hi Paul,
> =

> This is the followup series for the hwmod changes needed to get audio wor=
king
> on DRA7xx family based boards.
> The DTS patches has been applied by Tony from the original series:
> http://www.spinics.net/lists/linux-omap/msg121473.html
> =

> I have addressed your comments in the hwmod data and did some research al=
so
> regarding to the use of ahclkx as fclk in the original submission.
> It turned out that McASP _needs_ all clocks to be enabled (fclk, iclk and
> ahclkx/r) to be able to access registers. The original patch where we han=
dled
> the ahclkx as fclk worked, because the fclk clock got enabled in the HW w=
/o
> any SW interaction.
> All in all, the McASP found in DRA7 needs all clocks to be enabled.
> To satisfy this I have introduced a new flag to hwmod, which means that t=
he
> listed optional clocks need to be handled alongside with the fclk clock.

Can you, please look at this patch?

Thank you,
P=E9ter

> =

> Regards,
> Peter
> ---
> Peter Ujfalusi (2):
>   ARM: OMAP2+: hwmod: Add hwmod flag for HWMOD_OPT_CLKS_NEEDED
>   ARM: OMAP: DRA7: hwmod: Add data for McASP3
> =

>  arch/arm/mach-omap2/omap_hwmod.c          | 66 +++++++++++++++++--------=
------
>  arch/arm/mach-omap2/omap_hwmod.h          |  3 ++
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 56 ++++++++++++++++++++++++++
>  3 files changed, 95 insertions(+), 30 deletions(-)
> =
