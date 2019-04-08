From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] memory: ti-emif-sram: Add ti_emif_run_hw_leveling
 for DDR3 hardware leveling
Date: Mon, 8 Apr 2019 12:34:00 -0700
Message-ID: <20190408193400.GO49658@atomide.com>
References: <20190402165743.28106-1-d-gerlach@ti.com>
 <20190402165743.28106-2-d-gerlach@ti.com>
 <20190402172401.GO49658@atomide.com>
 <60a33620-0f27-37d8-5d29-dc83ab410274@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <60a33620-0f27-37d8-5d29-dc83ab410274@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Keerthy J <j-keerthy@ti.com>, linux-omap@vger.kernel.org, Brad Griffis <bgriffis@ti.com>, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <ssantosh@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Dave Gerlach <d-gerlach@ti.com> [190408 18:31]:
> Tony,
> On 4/2/19 12:24 PM, Tony Lindgren wrote:
> > * Dave Gerlach <d-gerlach@ti.com> [190402 16:57]:
> > > In certain situations, such as when returning from low power modes, the
> > > EMIF must re-run hardware leveling to properly restore DDR3 access.
> > > 
> > > This is accomplished by introducing a new ti-emif-sram-pm call,
> > > ti_emif_run_hw_leveling, to check if DDR3 is in use and if so, trigger
> > > the full write and read leveling processes.
> > 
> > OK nice that you also consider devices with LPDDR2 then in case we
> > start seeing those.
> 
> Yes, LPDDR2 will work fine with these. Any thoughts on if this series should
> come through you or Santosh?

Probably best that I queue these since there's also
arch/arm/mach-omap2 code related changes.

Regards,

Tony
