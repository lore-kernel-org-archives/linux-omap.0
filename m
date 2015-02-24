From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] ARM: omap2plus_defconfig: Fix SATA and NAND for
 v4.0-rc
Date: Tue, 24 Feb 2015 10:02:53 -0800
Message-ID: <20150224180253.GF11056@atomide.com>
References: <1424704717-29728-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1424704717-29728-1-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Roger Quadros <rogerq@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, grygorii.strashko@linaro.org, grinberg@compulab.co.il, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [150223 07:22]:
> Hi,
> 
> These changes fix SATA boot and NAND for OMAP based boards.
> 
> I must also point out that basic SATA operation is also
> broken when TI_PIPE3 driver is built as a module.
> I will be investigating that on lower priority.

OK applying into omap-for-v4.0/fixes. At some point we're going
to make everything use loadable modules and initramfs so best
to make sure things work as loadable modules.

Regards,

Tony
 
> Roger Quadros (2):
>   ARM: omap2plus_defconfig: Enable OMAP NAND BCH driver
>   ARM: omap2plus_defconfig: Fix SATA boot
> 
>  arch/arm/configs/omap2plus_defconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> -- 
> 2.1.0
> 
