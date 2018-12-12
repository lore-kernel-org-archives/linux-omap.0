From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: Add missing ranges for dra7 mcasp l3 ports
Date: Wed, 12 Dec 2018 07:28:29 -0800
Message-ID: <20181212152829.GF6707@atomide.com>
References: <20181208005403.26330-1-tony@atomide.com>
 <d7382c9f-6da8-6c8f-b1c6-ba2a017245d4@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <d7382c9f-6da8-6c8f-b1c6-ba2a017245d4@ti.com>
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
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [181212 08:00]:
> 
> 
> On 08/12/2018 2.54, Tony Lindgren wrote:
> > We need to add mcasp l3 port ranges for mcasp to use a correct l3
> > data port address for dma. And we're also missing the optional clocks
> > that we have tagged with HWMOD_OPT_CLKS_NEEDED in omap_hwmod_7xx_data.c.
> > 
> > Note that for reading the module revision register HWMOD_OPT_CLKS_NEEDED
> > do not seem to be needed. So they could be probably directly managed
> > only by the mcasp driver, and then we could leave them out for the
> > interconnect target module.
> 
> Tested on dra7-evm and dra72-evm. Works nicely, thanks!
> 
> Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

OK good to hear and thanks for testing. I already pushed this one out
yesterday as I was able to test it myself on beagle-x15.

Regards,

Tony
