From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] memory: ti-emif-sram: Add ti_emif_run_hw_leveling
 for DDR3 hardware leveling
Date: Tue, 9 Apr 2019 08:33:10 -0700
Message-ID: <20190409153310.GK2839@atomide.com>
References: <20190402165743.28106-1-d-gerlach@ti.com>
 <20190402165743.28106-2-d-gerlach@ti.com>
 <20190402172401.GO49658@atomide.com>
 <60a33620-0f27-37d8-5d29-dc83ab410274@ti.com>
 <20190408193400.GO49658@atomide.com>
 <20190409151905.GJ2839@atomide.com>
 <92aa0912-d449-c59e-fcf6-3a4b9e15ce3b@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <92aa0912-d449-c59e-fcf6-3a4b9e15ce3b@oracle.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Cc: Brad Griffis <bgriffis@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Keerthy J <j-keerthy@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* santosh.shilimkar@oracle.com <santosh.shilimkar@oracle.com> [190409 15:26]:
> On 4/9/19 8:19 AM, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [190408 19:34]:
> > > * Dave Gerlach <d-gerlach@ti.com> [190408 18:31]:
> > > > Tony,
> > > > On 4/2/19 12:24 PM, Tony Lindgren wrote:
> > > > > * Dave Gerlach <d-gerlach@ti.com> [190402 16:57]:
> > > > > > In certain situations, such as when returning from low power modes, the
> > > > > > EMIF must re-run hardware leveling to properly restore DDR3 access.
> > > > > > 
> > > > > > This is accomplished by introducing a new ti-emif-sram-pm call,
> > > > > > ti_emif_run_hw_leveling, to check if DDR3 is in use and if so, trigger
> > > > > > the full write and read leveling processes.
> > > > > 
> > > > > OK nice that you also consider devices with LPDDR2 then in case we
> > > > > start seeing those.
> > > > 
> > > > Yes, LPDDR2 will work fine with these. Any thoughts on if this series should
> > > > come through you or Santosh?
> > > 
> > > Probably best that I queue these since there's also
> > > arch/arm/mach-omap2 code related changes.
> > 
> > Santosh, is this OK with you? Care to ack the patch?
> > 
> Sure Tony !!
> 
> Acked-by: Santosh Shilimkar <ssantosh@kernel.org>

Thanks, applying these two patches into omap-for-v5.2/am4-ddr3
branch.

Reagrds,

Tony
