From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 4/6] OMAP: LDP: Port the display driver to new DSS2
Date: Thu, 12 May 2011 10:16:07 +0300
Message-ID: <4DCB8937.2060101@compulab.co.il>
References: <1304926567-26814-1-git-send-email-tomi.valkeinen@ti.com>	 <1304926567-26814-5-git-send-email-tomi.valkeinen@ti.com>	 <EAF47CD23C76F840A9E7FCE10091EFAB033DBC0C34@dbde02.ent.ti.com> <1305095563.2097.11.camel@deskari> <4DCB80DD.5090408@compulab.co.il>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010505020606020607070001"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:43322
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750846Ab1ELHQL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 May 2011 03:16:11 -0400
In-Reply-To: <4DCB80DD.5090408@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "Janorkar, Mayuresh" <mayur@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Stanley Miao <stanley.miao@windriver.com>

This is a multi-part message in MIME format.
--------------010505020606020607070001
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/12/11 09:40, Igor Grinberg wrote:

> On 05/11/11 09:32, Tomi Valkeinen wrote:
>> On Wed, 2011-05-11 at 10:28 +0530, Janorkar, Mayuresh wrote:
>>>> +static void __init ldp_display_init(void)
>>>> +{
>>>> +	int r;
>>>> +
>>>> +	struct gpio gpios[] = {
>>>> +		{LCD_PANEL_RESET_GPIO, GPIOF_OUT_INIT_HIGH, "LCD RESET"},
>>>> +		{LCD_PANEL_QVGA_GPIO, GPIOF_OUT_INIT_HIGH, "LCD QVGA"},
>>>> +		{LCD_PANEL_ENABLE_GPIO, GPIOF_OUT_INIT_LOW, "LCD ENABLE"},
>>>> +		{LCD_PANEL_BACKLIGHT_GPIO, GPIOF_OUT_INIT_LOW, "LCD
>>>> BACKLIGHT"},
>>>> +	};
>>>> +
>>>> +	r = gpio_request_array(gpios, ARRAY_SIZE(gpios));
>>>> +	if (r) {
>>>> +		pr_err("Cannot request LCD GPIOs, error %d\n", r);
>>>> +		return;
>>>> +	}
>>> If I test with this patch, this request is returning error.
>> Hmm. Well, the GPIOs are the same as in the old driver. However, the old
>> driver doesn't even seem to check if it manages to request the GPIOs, so
>> it may well be that it was failing also.
>>
>> Can you check from /sys/class/gpio/ if some of the GPIOs are already
>> allocated: 207, 199, 55, 56?
>>
>> The definition of two of those GPIOs look kinda funny to me: (15 +
>> OMAP_MAX_GPIO_LINES). I don't know what OMAP_MAX_GPIO_LINES means, but
>> it sure doesn't sound ok to have a GPIO number that is 15 over the
>> maximum =).
>>
> This means that some kind of gpio expander is used.
> I bet those are twl gpios (or may be some other discrete chip).
> If those are twl gpios then you need to provide the .setup callback
> in struct twl4030_gpio_platform_data which will request and setup those gpios.
>

No need to wonder ;)

Mayuresh,
try the attached patch (though some changes to Tomi's patch will be needed)
if it works, then we're good.

Tomi,
Your "ldp" patch does not apply, it would be nice if you rebase on top
of Tony's master.


-- 
Regards,
Igor.


--------------010505020606020607070001
Content-Type: text/x-patch;
 name="ldp-twl-gpios.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ldp-twl-gpios.patch"

 arch/arm/mach-omap2/board-ldp.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index f7d6038..ca92e43 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -203,10 +203,27 @@ static struct twl4030_usb_data ldp_usb_data = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
 
+static int ldp_twl_gpio_setup(struct device *dev, unsigned gpio, unsigned ngpio)
+{
+	int r;
+
+	struct gpio twl_gpios[] = {
+		{gpio + 7 , GPIOF_OUT_INIT_LOW, "LCD ENABLE"},
+		{gpio + 15, GPIOF_OUT_INIT_LOW, "LCD BACKLIGHT"},
+	};
+
+	r = gpio_request_array(twl_gpios, ARRAY_SIZE(gpios));
+	if (r)
+		pr_err("Cannot request LCD GPIOs, error %d\n", r);
+
+	return r;
+}
+
 static struct twl4030_gpio_platform_data ldp_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
 	.irq_end	= TWL4030_GPIO_IRQ_END,
+	.setup		= ldp_twl_gpios_setup,
 };
 
 static struct twl4030_madc_platform_data ldp_madc_data = {

--------------010505020606020607070001--
