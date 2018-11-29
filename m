From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] ARM: dts: am335x: Move l4 child devices to probe
 them with ti-sysc
Date: Thu, 29 Nov 2018 11:07:58 -0800
Message-ID: <20181129190758.GW53235@atomide.com>
References: <20180925000545.22931-1-tony@atomide.com>
 <20180925000545.22931-5-tony@atomide.com>
 <612b09a4-5007-39bf-becb-66fdca9d6d41@ti.com>
 <20181127161625.GR53235@atomide.com>
 <e1f4e272-32aa-1a28-6919-fd8a92f80ce8@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <e1f4e272-32aa-1a28-6919-fd8a92f80ce8@ti.com>
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

* Peter Ujfalusi <peter.ujfalusi@ti.com> [181128 12:50]:
> 
> 
> On 27/11/2018 18.16, Tony Lindgren wrote:
> > * Peter Ujfalusi <peter.ujfalusi@ti.com> [181127 13:01]:
> >> Reverting this patch in linux-next makes audio working again on am335x
> >> (bb white + audio cape) :o
> >>
> >> Without revert the McASP FIFO would constantly underflow.
> > 
> > Thanks for testing. Hmm the dts change looks right. And
> > am3_l3s_clkctrl_regs[] has CLKF_SW_SUP for the mcasp fcks.
> > And there are no opt clocks to enable according to the TRM.
> > 
> >> Memcpy test via dmatest works with EDMA
> > 
> > OK. Can you please test if the following partial revert
> > also works or is there maybe a dependency to some other
> > device?
> 
> It works, thanks:
> Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

OK aplying into omap-for-v4.21/dt-ti-sysc.

Regards,

Tony
