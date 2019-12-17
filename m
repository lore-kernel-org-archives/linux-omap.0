From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/14] Remove legacy sdma code for dt booting omaps
Date: Tue, 17 Dec 2019 06:50:53 -0800
Message-ID: <20191217145053.GV35479@atomide.com>
References: <20191217001925.44558-1-tony@atomide.com>
 <a62d8087-afad-fd04-bfe2-79ce6ea08ffe@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <a62d8087-afad-fd04-bfe2-79ce6ea08ffe@ti.com>
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
Cc: devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Vinod Koul <vinod.koul@intel.com>, Vinod Koul <vkoul@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [191217 09:54]:
> Thanks for doing this!
> First things first:
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Thanks for testing!

> But I was only able to test it with CPU_IDLE=n otherwise (even w/o this series)
> I got a flood of (PandaBoard-ES):
> 
> [  315.995819] ------------[ cut here ]------------
> [  316.000457] WARNING: CPU: 0 PID: 0 at drivers/bus/omap_l3_noc.c:141 l3_interrupt_handler+0x264/0x384
> [  316.009613] 44000000.ocp:L3 Standard Error: MASTER USBHOSTHS TARGET ABE (Read Link): At Address: 0x00000000 : Data Access in User mode during Functional access

Can you please email me your .config and I'll take a look?

I'm not seeing that with pandaboard es here at least with
omap2plus_defconfig.

Regards,

Tony
