From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Remove module references from IOMMU machine
 layer
Date: Thu, 16 Jul 2015 00:16:40 -0700
Message-ID: <20150716071640.GI17550@atomide.com>
References: <1436560985-5947-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1436560985-5947-1-git-send-email-s-anna@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Suman Anna <s-anna@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Suman Anna <s-anna@ti.com> [150710 13:45]:
> The OMAP IOMMU driver has been adapted to the IOMMU framework
> for a while now, and it no longer supports being built as a
> module. Cleanup all the module related references both from
> the code and in the build.
> 
> While at it, also relocate a comment around the initcall to
> avoid a checkpatch strict warning about using a blank line
> after function/struct/union/enum declarations.

OK applying into omap-for-v4.3/soc.

You may want to check few things after this:

- Does it still need to be omap_subsys_initcall or can it
  happen later? Anything we can initialize later on is worth
  doing as then we have proper debug console available.

- For multi_v7_defconfig it would be nice to be able to
  make the driver/iommu components into standard Linux
  loadable modules.

- Actually you can probably get rid of mach-omap2/omap-iommu.c
  completely by implementing PM runtime and and possibly
  reset controller.

Regrds,

Tony
