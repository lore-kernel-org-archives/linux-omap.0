From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 0/3] ARM: OMAP2+: pdata quirk fixes for OMAP IOMMUs
Date: Fri, 9 Aug 2019 14:16:10 -0500
Message-ID: <efabe829-90eb-247c-7d7a-9ab5a3c8e6bf@ti.com>
References: <1565171081-7899-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1565171081-7899-1-git-send-email-t-kristo@ti.com>
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
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Tero,

On 8/7/19 4:44 AM, Tero Kristo wrote:
> Hi,
> 
> A few quick fixes for OMAP IOMMU pdata quirks. These basically apply
> one errata for remoteprocs, and also convert the support of iommus
> to ti-sysc from hwmod for omap4+ devices.

I do not think this series can go in independently by itself, right. I
understand that you have posted the individual bits based on your
integrated branch but the patches do have dependencies against patches
against other subsystems.

You cannot remove the reset stuff without a breakage in functionality
and without the PRM driver being merged. The second patch has
dependencies from the OMAP IOMMU fixes series [1] which Joerg has picked
up today.

Have you tested these series individually? We will want to restore the
current broken functionality with clkctrl when using hwmods first, bring
in the PRM pieces and ti-sysc pieces and then transition over. We can
directly go ti-sysc with DRA7 MMUs.

regards
Suman

[1]
https://lore.kernel.org/linux-iommu/20190809153730.GF12930@8bytes.org/T/#mec99f8e8ed351689f4fcc76f4f000f9144a02b51
