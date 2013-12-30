From: Sricharan R <r.sricharan@ti.com>
Subject: Re: [PATCH V4 0/3] ARM: DTS: DRA7: Updates for adding crossbar device
Date: Mon, 30 Dec 2013 12:28:02 +0530
Message-ID: <52C1197A.5010701@ti.com>
References: <1384431928-2328-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1384431928-2328-1-git-send-email-r.sricharan@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linus.walleij@linaro.org, linux@arm.linux.org.uk, tony@atomide.com, rnayak@ti.com, marc.zyngier@arm.com, grant.likely@linaro.org, mark.rutland@arm.com, robherring2@gmail.com, tglx@linutronix.de, galak@codeaurora.org, rob.herring@calxeda.com, santosh.shilimkar@ti.com, nm@ti.com, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

Hi Benoit,

On Thursday 14 November 2013 05:55 PM, Sricharan R wrote:
> Some socs have a large number of interrupts requests to service
> the needs of its many peripherals and subsystems. All of the interrupt
> requests lines from the subsystems are not needed at the same
> time, so they have to be muxed to the controllers appropriately.
> In such places a interrupt controllers are preceded by an
> IRQ CROSSBAR that provides flexibility in muxing the device interrupt
> requests to the controller inputs.
> 
> The driver support for the same was added here.
> 	http://marc.info/?l=linux-omap&m=138443167321614&w=2
> 
> The dts file update to support the crossbar device and convert
> peripheral irq numbers to crossbar number are added here.
> This series was originally a part of the series [1] and now split
> to keep the DTS updates separately as per comments from
> Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Applied this series on top of
>   git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git
>   for_3.13/dts
> 
> [1] http://www.kernelhub.org/?msg=356470&p=2
> 
> Sricharan R (3):
>   ARM: DTS: DRA: Add crossbar device binding
>   ARM: DTS: DRA: Replace peripheral interrupt numbers with crossbar
>     inputs
>   ARM: DTS: DRA7: Add routable-irqs property for gic node
> 
>  arch/arm/boot/dts/dra7.dtsi |   95 +++++++++++++++++++++++--------------------
>  1 file changed, 52 insertions(+), 43 deletions(-)
> 

I have pushed a branch with this series here

git://github.com/Sricharanti/sricharan.git
branch: crossbar_dts

This is on top of your for_3.14/dts branch

This series has a dependency with crossbar driver functional changes, which is yet
to be pulled

https://lkml.org/lkml/2013/12/30/9

Regards,
 Sricharan
