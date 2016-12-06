From: Mark Jackson <mpfj-list@newflow.co.uk>
Subject: How do I define SRAM chip in GPMC device tree ?
Date: Tue, 6 Dec 2016 12:33:10 +0000
Message-ID: <3f98534e-2176-e03e-ac53-b60b8d0ead7c@newflow.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi

We have an existing board supported in Linux v4.1 (see am335x-nano.dts)
and I was looking to update to a more recent kernel but have hit a stumbling
block.

Our unit has an SRAM device connected to CS1 and we currently rely on uboot
to init the GPMC settings.

>From v4.2+ I now see that the GPMC code has been changed to reset all the
GPMC settings when the kernel starts, so our SRAM is now inaccessible.

I've tried the following to add an extra device to the GPMC, but no go:-

	sram@1,0 {
		reg = <1 0x00000000 0x01000000>;
		/*compatible = "mmio-sram";*/
		bank-width = <2>;

		gpmc,mux-add-data = <2>;

		gpmc,sync-clk-ps = <0>;
		gpmc,cs-on-ns = <0>;
		gpmc,cs-rd-off-ns = <160>;
		gpmc,cs-wr-off-ns = <160>;
		gpmc,adv-on-ns = <10>;
		gpmc,adv-rd-off-ns = <30>;
		gpmc,adv-wr-off-ns = <30>;
		gpmc,oe-on-ns = <40>;
		gpmc,oe-off-ns = <160>;
		gpmc,we-on-ns = <40>;
		gpmc,we-off-ns = <160>;
		gpmc,rd-cycle-ns = <160>;
		gpmc,wr-cycle-ns = <160>;
		gpmc,access-ns = <150>;
		gpmc,page-burst-access-ns = <10>;
		gpmc,cycle2cycle-samecsen;
		gpmc,cycle2cycle-delay-ns = <20>;
		gpmc,wr-data-mux-bus-ns = <70>;
		gpmc,wr-access-ns = <80>;
	};

Looking at drivers/memory/omap-gpmc.c, I can see that when the GPMC
children are scanned, only the following are matched:-

"nand","onenand","ethernet","nor","uart"

So can anyone explain how to add a standard SRAM chip ?

Cheers
Mark J.
