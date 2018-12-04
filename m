From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] ARM: dts: am437x: Move l4 child devices to probe
 them with ti-sysc
Date: Tue, 4 Dec 2018 10:11:21 -0800
Message-ID: <20181204181121.GC6707@atomide.com>
References: <20180925000545.22931-1-tony@atomide.com>
 <20180925000545.22931-3-tony@atomide.com>
 <f890f989-bfd0-47eb-66e0-5a8573e398b7@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <f890f989-bfd0-47eb-66e0-5a8573e398b7@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [181204 12:22]:
> Hi Tony,
> 
> On 25/09/2018 3.05, Tony Lindgren wrote:
> > With l4 interconnect hierarchy and ti-sysc interconnect target module
> > data in place, we can simply move all the related child devices to
> > their proper location and enable probing using ti-sysc.
> > 
> > In general the first child device address range starts at range 0
> > from the ti-sysc interconnect target so the move involves adjusting
> > the child device reg properties for that.
> > 
> > In case of any regressions, problem devices can be reverted to probe
> > with legacy platform data as needed by moving them back and removing
> > the related interconnect target module node.
> > 
> > Note that we are not yet moving dss or wkup_m3, those will be moved
> > later after some related driver changes.
> 
> Exactly the same issue as with am335x after:
> ARM: dts: am335x: Move l4 child devices to probe them with ti-sysc
> 
> reverting this patch makes audio working:
> 
> Without revert the McASP FIFO would constantly underflow.
> 
> Memcpy test via dmatest works with EDMA

OK I should be able to debug it here with am437x-sk-evm then.

If it's not immediately obvious what's going on, let's just
do a revert here too and debug it more separately.

Regards,

Tony
