From: Stefano Babic <sbabic@denx.de>
Subject: Re: [PATCH] ARM: OMAP: Add support for AM35xx UART4/ttyO3
Date: Thu, 22 Mar 2012 17:03:22 +0100
Message-ID: <4F6B4D4A.2040103@denx.de>
References: <1318963661-27755-1-git-send-email-kyle.manna@fuel7.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1318963661-27755-1-git-send-email-kyle.manna@fuel7.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kyle Manna <kyle.manna@fuel7.com>
Cc: Kevin Hilman <khilman@ti.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 18/10/2011 20:47, Kyle Manna wrote:
> Add hwmod support to enable access to UART4 of the AM35xx series of
> chips.  The UART4 device referenced from the TRM will show up as ttyO3.
> 
> This was tested on an AM3505.
> 
> Signed-off-by: Kyle Manna <kyle.manna@fuel7.com>
> ---

Hi Kyle,

>  arch/arm/mach-omap2/clock3xxx_data.c       |   11 ++++++
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   52 ++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/prcm-common.h          |    2 +
>  arch/arm/plat-omap/include/plat/irqs.h     |    2 +-
>  arch/arm/plat-omap/include/plat/serial.h   |    1 +
>  5 files changed, 67 insertions(+), 1 deletions(-)

Can I gently ask you which pinmux setup do you use to test your patch ?

I am trying to make uart4 working on a am3517 with mainline kernel
(3.3+, your patch is merged). However, on my board the uart4 pins are
shared with the camera, and not with SD, as maybe is more common. I set
the pinmux to switch the pins (gpio_95 / gpio_96 / gpio_97 /gpio_98) to
the uart4, and ttyO3 is registered and available, and thanks your patch
both clocks iclk and fclk are active. However, I cannot see activity on
the tx line if I try to send some characters.

Maybe do you use the same pinmux and am I forgetting something else ?

Thanks,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
