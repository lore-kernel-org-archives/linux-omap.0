From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCHv2 0/3] omap gpio add level idle, cpu_pm and drop
 runtime_irq_safe
Date: Fri, 21 Sep 2018 22:12:52 -0500
Message-ID: <e3dbeb73-c14e-282b-f2bb-449131d6ed33@ti.com>
References: <20180920193532.7714-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180920193532.7714-1-tony@atomide.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On 09/20/2018 02:35 PM, Tony Lindgren wrote:
> Hi,
> 
> Here's v2 of the patches to add support for omap4 and later level interrupt
> idle support, get rid of the custom pm calls, and finally after these we can
> drop pm_runtime_irq_safe().
> 
> Linus, assuming people are happy with these, I'd appreciate an immutable branch
> with these in case we run into merge conflicts for arch/arm/mach-omap2 changes.
> 
> Regards,
> 
> Tony
> 
> 
> Changes since v1:
> - Fix issue noted in v1 set and update comments accordingly
> 
> - Don't call pm_runtime from cpu_pm to avoid further dependencies to
>    pm_runtime_irq_safe() as discussed offline with Grygorii
> 
> - Add a patch to drop pm_runtime_irq_safe() as it's no longer needed
> 
> Tony Lindgren (3):
>    gpio: omap: Add level wakeup handling for omap4 based SoCs
>    gpio: omap: Remove custom PM calls and use cpu_pm instead
>    gpio: omap: Get rid of pm_runtime_irq_safe()
> 
>   arch/arm/mach-omap2/pm24xx.c            |   7 +-
>   arch/arm/mach-omap2/pm34xx.c            |  14 +-
>   drivers/gpio/gpio-omap.c                | 331 ++++++++++++++++--------
>   include/linux/platform_data/gpio-omap.h |  15 +-
>   4 files changed, 237 insertions(+), 130 deletions(-)
> 

Thank you
Acked-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
regards,
-grygorii
