From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH V2 5/5] Input: ads7846: set proper debounce time in driver
 level
Date: Thu, 14 Jun 2012 09:44:38 +0300
Message-ID: <4FD98856.8070601@compulab.co.il>
References: <zumeng.chen@gmail.com> <1339551850-20827-1-git-send-email-zumeng.chen@gmail.com> <1339551850-20827-6-git-send-email-zumeng.chen@gmail.com> <79CD15C6BA57404B839C016229A409A83EA4F07F@DBDE01.ent.ti.com> <4FD96CBF.5040106@windriver.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030907060309060308040905"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:42979 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751098Ab2FNGop (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 02:44:45 -0400
In-Reply-To: <4FD96CBF.5040106@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Zumeng Chen <zumeng.chen@windriver.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, mike@compulab.co.il, Zumeng Chen <zumeng.chen@gmail.com>, "tony@atomide.com" <tony@atomide.com>, "Hunter, Jon" <jon-hunter@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, "Syed Mohammed, Khasim" <khasim@ti.com>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

This is a multi-part message in MIME format.
--------------030907060309060308040905
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/14/12 07:46, Zumeng Chen wrote:
> =E4=BA=8E 2012=E5=B9=B406=E6=9C=8813=E6=97=A5 20:18, Hiremath, Vaibhav =
=E5=86=99=E9=81=93:
>> On Wed, Jun 13, 2012 at 07:14:10, Zumeng Chen wrote:
>>> From: Zumeng Chen<zumeng.chen@windriver.com>
>>>
>>> If we don't set proper debouce time for ads7846, then there are
>>> flooded interrupt counters of ads7846 responding to one time
>>> touch on screen, so the driver couldn't work well.
>>>
>>> And since most OMAP3 series boards pass NULL pointer of board_pdata
>>> to omap_ads7846_init, so it's more proper to set it in driver level
>>> after having gpio_request done.
>>>
>>> This patch has been validated on 3530evm.
>>>
>>> Signed-off-by: Zumeng Chen<zumeng.chen@windriver.com>
>>> Signed-off-by: Syed Mohammed Khasim<khasim@ti.com>
>>> ---
>>>   drivers/input/touchscreen/ads7846.c |    4 ++++
>>>   1 files changed, 4 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touc=
hscreen/ads7846.c
>>> index f02028e..459ff29 100644
>>> --- a/drivers/input/touchscreen/ads7846.c
>>> +++ b/drivers/input/touchscreen/ads7846.c
>>> @@ -980,6 +980,10 @@ static int __devinit ads7846_setup_pendown(struc=
t spi_device *spi, struct ads784
>>>           }
>>>
>>>           ts->gpio_pendown =3D pdata->gpio_pendown;
>>> +#ifdef CONFIG_ARCH_OMAP3
>>> +        /* 310 means about 10 microsecond for omap3 */
>>> +        gpio_set_debounce(pdata->gpio_pendown, 310);
>>> +#endif
>>>
>> Zumeng,
>>
>> With my sign-off you are changing the original code, that too
>> without my sign-off and ack.
>> I wouldn't mind you to submit patches from my tree, but the expectatio=
n is
>> if you are changing the original code, it should be under your sign-of=
f.
> Thanks, good to learn. I'll remove in next time.
>> Coming to the patch, #ifdef in driver is not recommended, and this 10m=
sec
>> delay is specific to OMAP GPIO and driver should not be aware of this,
>> that's where you will find the original patch handling it in board fil=
e.
> According to the git blame of the board-omap3evm.c I think
> 96974a24 did a good thing to all the related codes for omap3
> boards. So I think we can call board and driver as BSP level :-)
>=20
> If #ifdef in driver can save many codes, I guess it's deserved.

No, platform/board specific ifdefs in the generic driver code are never
deserved.
How about the attached patch, does it fix the problem for you?


--=20
Regards,
Igor.

--------------030907060309060308040905
Content-Type: text/x-patch;
 name="ads7846.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ads7846.patch"

diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/mach-omap2/common-board-devices.c
index 1706ebc..c187586 100644
--- a/arch/arm/mach-omap2/common-board-devices.c
+++ b/arch/arm/mach-omap2/common-board-devices.c
@@ -63,28 +63,30 @@ void __init omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
 	struct spi_board_info *spi_bi = &ads7846_spi_board_info;
 	int err;
 
-	if (board_pdata && board_pdata->get_pendown_state) {
-		err = gpio_request_one(gpio_pendown, GPIOF_IN, "TSPenDown");
-		if (err) {
-			pr_err("Couldn't obtain gpio for TSPenDown: %d\n", err);
-			return;
-		}
-		gpio_export(gpio_pendown, 0);
-
-		if (gpio_debounce)
-			gpio_set_debounce(gpio_pendown, gpio_debounce);
+	err = gpio_request_one(gpio_pendown, GPIOF_IN, "TSPenDown");
+	if (err) {
+		pr_err("Couldn't obtain gpio for TSPenDown: %d\n", err);
+		return;
 	}
 
+	if (gpio_debounce)
+		gpio_set_debounce(gpio_pendown, gpio_debounce);
+
 	spi_bi->bus_num	= bus_num;
 	spi_bi->irq	= gpio_to_irq(gpio_pendown);
 
 	if (board_pdata) {
 		board_pdata->gpio_pendown = gpio_pendown;
 		spi_bi->platform_data = board_pdata;
+		if (board_pdata->get_pendown_state)
+			gpio_export(gpio_pendown, 0);
 	} else {
 		ads7846_config.gpio_pendown = gpio_pendown;
 	}
 
+	if (!board_pdata || (board_pdata && !board_pdata->get_pendown_state))
+		gpio_free(gpio_pendown);
+
 	spi_register_board_info(&ads7846_spi_board_info, 1);
 }
 #else

--------------030907060309060308040905--
