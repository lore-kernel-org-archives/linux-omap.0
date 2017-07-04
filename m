From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] gpio: drop unnecessary includes from
 include/linux/gpio/driver.h
Date: Tue, 4 Jul 2017 09:30:45 +0100
Message-ID: <20170704083045.fqruqn6i5sxhfhu6@localhost.localdomain>
References: <1499140415-31677-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1499140415-31677-1-git-send-email-yamada.masahiro@socionext.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Thor Thayer <thor.thayer@linux.intel.com>, Tien Hock Loh <thloh@altera.com>, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Alban Bedel <albeu@free.fr>, Florian Fainelli <f.fainelli@gmail.com>, Alexander Shiyan <shc_work@mail.ru>, Kevin Hilman <khilman@kernel.org>, Michal Simek <michal.simek@xilinx.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-acpi@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Joel Stanley <joel@jms.id.au>, Grygorii Strashko <grygorii.strashko@ti.com>, Ray Jui <rjui@broadcom.com>, William Breathitt Gray <vilhelm.gray@gmail.com>, linux-gpio@vger.kernel.org, Santosh Shilimkar <ssantosh@kernel.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-arm-kernel@lists.infradead.org, =?iso-885
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 04, 2017 at 12:53:34PM +0900, Masahiro Yamada wrote:
> Some of include directives in include/linux/gpio/driver.h are
> unneeded because the header does not need to know the content of
> struct device, irq_chip, etc.  Just declare they are structures.
> 
> On the other hand, <linux/irqhandler.h> and <linux/spinlock_types.h>
> turned out to be necessary for irq_flow_handler_t and spinlock_t,
> respectively.
> 
> Each driver should include what it needs without relying on what is
> implicitly included from <linux/gpio/driver.h>.  This will cut down
> unnecessary header parsing.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  drivers/gpio/gpio-wm831x.c       |  1 +
>  drivers/gpio/gpio-wm8994.c       |  1 +

For the Wolfson Micro bits:

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
