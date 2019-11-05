From: Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH v1 7/7] dt-bindings: PCI: Use IRQ flags for legacy PCI
 IRQ interrupts
Date: Tue, 5 Nov 2019 15:16:23 +0000
Message-ID: <20191105151622.GN9723@e119886-lin.cambridge.arm.com>
References: <20191104163834.8932-1-andrew.murray@arm.com>
 <20191104163834.8932-8-andrew.murray@arm.com>
 <CACRpkdb=5i3+H3OtGXSYQEjSq5ROrysfmnG-koGck+chEEgLnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdb=5i3+H3OtGXSYQEjSq5ROrysfmnG-koGck+chEEgLnQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Heiko Stuebner <heiko@sntech.de>, Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, David Daney <david.daney@cavium.com>, linux-pci <linux-pci@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, Binghui Wang <wangbinghui@hisilicon.com>, Michal Simek <michal.simek@xilinx.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Jonathan Chocron <jonnyc@amazon.com>, Toan Le <toan@os.amperecomputing.com>, Will Deacon <will@kernel.org>, Jesper Nilsson <jesper.nilsson@axis.com>, Ryder Lee <ryder.lee@mediatek.com>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Fabio Estevam <festevam@gmail.com>, Tom Joseph <tjoseph@cadence.com>, linux-arm-kernel@axis.com, Kishon Vijay Abraham I <kishon@ti.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Andy Gross <agross@ke>
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 05, 2019 at 04:08:29PM +0100, Linus Walleij wrote:
> Hi Andrew,
> 
> thanks for your patch!

Thanks for the review.

> 
> On Mon, Nov 4, 2019 at 5:39 PM Andrew Murray <andrew.murray@arm.com> wrote:
> 
> > Replace magic numbers used to describe legacy PCI IRQ interrupts
> > with #define.
> >
> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> 
> When I add examples I usually make sure that above the examples
> are the appropriate #include files, this is becoming more important
> as we convert to yaml, then you need the right includes because the
> examples will get compiled.

OK thanks - I can see other files in Documentation that take this approach
I'll update this patch on my respin.

Thanks,

Andrew Murray

> 
> With that taken into account:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Yours,
> Linus Walleij
