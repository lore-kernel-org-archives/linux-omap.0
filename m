From: Kyle Manna <kyle.manna@fuel7.com>
Subject: Re: [PATCH] ARM: OMAP: Add support for AM35xx UART4/ttyO3
Date: Thu, 22 Mar 2012 12:00:00 -0500
Message-ID: <4F6B5A90.6030808@fuel7.com>
References: <1318963661-27755-1-git-send-email-kyle.manna@fuel7.com>
 <4F6B4D4A.2040103@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4F6B4D4A.2040103@denx.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefano Babic <sbabic@denx.de>
Cc: Kevin Hilman <khilman@ti.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 03/22/2012 11:03 AM, Stefano Babic wrote:
> On 18/10/2011 20:47, Kyle Manna wrote:
>> Add hwmod support to enable access to UART4 of the AM35xx series of
>> chips.  The UART4 device referenced from the TRM will show up as ttyO3.
>>
>> This was tested on an AM3505.
>>
>> Signed-off-by: Kyle Manna<kyle.manna@fuel7.com>
>> ---
> Hi Kyle,
>
>>   arch/arm/mach-omap2/clock3xxx_data.c       |   11 ++++++
>>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   52 ++++++++++++++++++++++++++++
>>   arch/arm/mach-omap2/prcm-common.h          |    2 +
>>   arch/arm/plat-omap/include/plat/irqs.h     |    2 +-
>>   arch/arm/plat-omap/include/plat/serial.h   |    1 +
>>   5 files changed, 67 insertions(+), 1 deletions(-)
> Can I gently ask you which pinmux setup do you use to test your patch ?
>
> I am trying to make uart4 working on a am3517 with mainline kernel
> (3.3+, your patch is merged). However, on my board the uart4 pins are
> shared with the camera, and not with SD, as maybe is more common. I set
> the pinmux to switch the pins (gpio_95 / gpio_96 / gpio_97 /gpio_98) to
> the uart4, and ttyO3 is registered and available, and thanks your patch
> both clocks iclk and fclk are active. However, I cannot see activity on
> the tx line if I try to send some characters.
>
> Maybe do you use the same pinmux and am I forgetting something else ?

My pin mux is configured in u-boot and is as follows:

     /* CCDC_FIELD: gpio_95, uP-TXD4 */ \
     MUX_VAL(CP(CCDC_FIELD),     (IDIS | PTD | DIS | M2)) \
     /* CCDC_HD: gpio_96, uP-RTS4# */ \
     MUX_VAL(CP(CCDC_HD),        (IDIS | PTD | DIS | M2)) \
     /* CCDC_VD: gpio_97, uP-CTS4# */ \
     MUX_VAL(CP(CCDC_VD),        (IEN  | PTD | EN  | M2)) \
     /* CCDC_WEN: gpio_98, uP-RXD4 */ \
     MUX_VAL(CP(CCDC_WEN),       (IEN  | PTD | DIS | M2)) \

I've just validated my AM3505 board does in fact toggle the TX line and 
writes valid data.  The running kernel is based on a linux-omap-3.1 and 
was the source for that patch.

Since it sounds like you have the same pinmux, perhaps something changed 
elsewhere in the kernel?  Have you tried validating that your hardware 
can toggle the pin as a GPIO first to eliminate any possibility of shorts?

- Kyle
