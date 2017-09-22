From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 0/8] Add hwmod data for IPU & DSP processors/MMUs
Date: Fri, 22 Sep 2017 12:18:16 -0500
Message-ID: <d4715d1e-8113-050b-9a0f-77f4a4486081@ti.com>
References: <20170821234818.4755-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170821234818.4755-1-s-anna@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Tony,

On 08/21/2017 06:48 PM, Suman Anna wrote:
> Hi Tony,
> 
> The following series adds the hwmod data and the corresponding
> pdata quirks for the various MMUs associated with the IPU and DSP
> processors on DRA7xx/AM57xx SoCs. This is part 1 of the patches
> for enabling the MMUs on DRA7 SoCs (OMAP4 and OMAP5 are already
> supported on mainline) and providing a baseline for adding the
> OMAP remoteproc driver. The hwmod data for the consumers of these
> MMUs - IPU and DSP processors is also added on OMAP5 and DRA7 SoCs,
> with an update to the OMAP4 ones.
> 
> Patches are baselined on your current for-next branch with commit
> a70cb93b6c2f ("Merge branch 'omap-for-v4.14/dt-v3' into for-next").
> 
> I have tested the patches on current TI DRA7xx/AM57xx boards (DRA7,
> DRA72, DRA71, DRA76 EVMs, AM571x & AM572x IDKs and AM57xx BeagleBoard-X15)
> as well as the OMAP4 Panda and OMAP5 uEVM.

Ping on this series. Tero's clkctrl series changes are orthogonal to
these changes.

regards
Suman

> 
> regards
> Suman
> 
> Suman Anna (8):
>   ARM: DRA7: hwmod data: Add MMU data for IPUs
>   ARM: DRA7: hwmod data: Add MMU data for DSPs
>   ARM: OMAP2+: Extend iommu pdata-quirks to DRA7 IPUs
>   ARM: OMAP2+: Extend iommu pdata-quirks to DRA7 DSPs
>   ARM: OMAP4: hwmod_data: Remove modulemode from IPU/DSP hwmods
>   ARM: OMAP5: hwmod_data: Add data for IPU & DSP processors
>   ARM: DRA7: hwmod_data: Add data for IPUs
>   ARM: DRA7: hwmod_data: Add data for DSPs
> 
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   2 -
>  arch/arm/mach-omap2/omap_hwmod_54xx_data.c |  79 +++++++
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c  | 322 +++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/pdata-quirks.c         |  11 +-
>  4 files changed, 411 insertions(+), 3 deletions(-)
> 
