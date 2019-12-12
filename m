From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] bus: ti-sysc: Drop MMU quirks
Date: Thu, 12 Dec 2019 08:59:20 -0800
Message-ID: <20191212165920.GU35479@atomide.com>
References: <20191212124751.3400-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20191212124751.3400-1-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: s-anna@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [191212 04:48]:
> From: Suman Anna <s-anna@ti.com>
> 
> The OMAP IOMMU driver no longer uses the pm_runtime_irq_safe() API
> after commit 1432ebbd6003 ("iommu/omap: remove pm_runtime_irq_safe
> flag for OMAP IOMMUs"), so the SYSC_QUIRK_LEGACY_IDLE quirk is no
> longer needed for MMU devices. Drop the same.

Thanks applying into omap-for-v5.6/ti-sysc.

Tony
