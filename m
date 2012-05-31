From: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Subject: Re: [RFC PATCH 11/11] ARM: DT: Add support to system control module
 for OMAP4
Date: Thu, 31 May 2012 18:51:10 +0400
Message-ID: <4FC7855E.6040304@dev.rtsoft.ru>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com> <1337934361-1606-12-git-send-email-eduardo.valentin@ti.com> <4FC49BA5.5050008@dev.rtsoft.ru> <4FC5DC9F.7080104@ti.com> <4FC5E2EE.8030504@dev.rtsoft.ru> <4FC5E7DE.2060905@ti.com> <4FC75EA8.6090406@dev.rtsoft.ru> <20120531124958.GD3673@besouro> <4FC76992.1040407@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:35956 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756521Ab2EaOvM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 May 2012 10:51:12 -0400
In-Reply-To: <4FC76992.1040407@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: eduardo.valentin@ti.com, kishon@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com, balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org, Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>

  Hi.

On 05/31/2012 04:52 PM, Cousson, Benoit wrote:
> On 5/31/2012 2:49 PM, Eduardo Valentin wrote:
>> Hello,
>>
>> On Thu, May 31, 2012 at 04:06:00PM +0400, Konstantin Baydarov wrote:
>>>    Hi.
>>>
>>> On 05/30/2012 01:26 PM, Cousson, Benoit wrote:
>>>> On 5/30/2012 11:05 AM, Konstantin Baydarov wrote:
>>>>> On 05/30/2012 12:38 PM, Cousson, Benoit wrote:
>>>>>> On 5/29/2012 11:49 AM, Konstantin Baydarov wrote:
>>>>>>> Hi, Eduardo.
>>>>>>>
>>>>>>> On 05/25/2012 12:26 PM, Eduardo Valentin wrote:
>>>>>>>> This patch add device tree entries on OMAP4 based boards for
>>>>>>>> System Control Module (SCM).
>>>>
>>>> ...
>>>>
>>>>>>> I believe that CPU-specific bandgap definition should be moved to
>>>>>>> bard specific dts.
>>>>>>
>>>>>> Mmm, why, since it is CPU specific and not board specific. I has to
>>>>>> be in the SoC file.
>>>>> Speaking about omap4430 - omap4430 bandgap differs from omap4460, so
>>>>> if omap4430 bandgap support will be added to omap-bandgap driver the
>>>>> version of bandgap should specified in dts file. omap4.dtsi is a
>>>>> common for omap4 boards, that is why I'm suggesting to move bandgap
>>>>> description to probably board specific file.
>>>>
>>>> OK, I got your point, but in that case we could potentially define a omap4460.dtsi file.
>>>>
>>>>> Another solution is to
>>>>> determine bandgap type in driver probe function, but in that case
>>>>> "ti,omap4460-bandgap" in omap4.dtsi should be replaced to
>>>>> "ti,omap4-bandgap".
>>>>
>>>> Yes, this is the best solution, but that assume that we can identify the control module version from the HW, which is not necessarily true :-(
>>>>
>>>> The IP_REVISION (offset = 0) value are unfortunately not documented, so we should read it to check if they are different from omap4430 and 4460.
>>>>
>>>> The bitfield layout in that register is:
>>>>
>>>> IP_REV_MAJOR: 8..10
>>>> IP_REV_CUSTOM: 6..7
>>>> IP_REV_MINOR: 0..5
>>> The value of CONTROL_GEN_CORE_REVISION register on my panda board(4430) is:
>>> CONTROL_GEN_CORE_REVISION: 0x40000900
>>> CONTROL_GEN_CORE_HWINFO:  0x0
>>>
>>>    Eduardo, could you check CONTROL_GEN_CORE_REVISION on your 4460 board.
>>
>> 4460:
>> [root@(none) ~]# omapconf read 0x4A002000
>> 40000A00
>> [root@(none) ~]# omapconf read 0x4A002004
>> 00000000
>>
>> 4470:
>> [root@(none) ~]# omapconf read 0x4A002000
>> 40000B00
>> [root@(none) ~]# omapconf read 0x4A002004
>> 00000000
>
> Nice! We do have a cool progression 1 -> 2 -> 3 for each revision.
> Well at least for the SCM.
>
> Benoit
This patch allows checking of bandgap type dynamically in bandgap driver
probe function by reading omap core control module revision register
CONTROL_GEN_CORE_REVISION. It lets bandgap module to be defined in common
omap4.dtsi, because all cpu specific attributes(irq and tshut number)
were moved to driver.

Patch wasn't tested because I have panda 4430 board.

Signed-off-by: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>

Index: omap-thermal/arch/arm/boot/dts/omap4.dtsi
===================================================================
--- omap-thermal.orig/arch/arm/boot/dts/omap4.dtsi
+++ omap-thermal/arch/arm/boot/dts/omap4.dtsi
@@ -277,9 +277,7 @@
 			compatible = "ti,omap4-control";
 			ti,hwmods = "ctrl_module_core";
 			bandgap {
-				compatible = "ti,omap4460-bandgap";
-				interrupts = <0 126 4>; /* talert */
-				ti,tshut-gpio = <86>; /* tshut */
+				compatible = "ti,omap4-bandgap";
 			};
 			usb {
 				compatible = "ti,omap4-usb-phy";
Index: omap-thermal/drivers/thermal/omap-bandgap.c
===================================================================
--- omap-thermal.orig/drivers/thermal/omap-bandgap.c
+++ omap-thermal/drivers/thermal/omap-bandgap.c
@@ -219,12 +219,14 @@ struct omap_temp_sensor {
 struct omap_bandgap_data {
 	bool				has_talert;
 	bool				has_tshut;
+	int				tshut_gpio;
 	const int			*conv_table;
 	char				*fclock_name;
 	char				*div_ck_name;
 	int				sensor_count;
 	int (*report_temperature)(struct omap_bandgap *bg_ptr, int id);
 	int (*expose_sensor)(struct omap_bandgap *bg_ptr, int id, char *domain);
+	int				irq;
 
 	/* this needs to be at the end */
 	struct omap_temp_sensor		sensors[];
@@ -1189,10 +1191,12 @@ static int omap_bandgap_talert_init(stru
 static const struct omap_bandgap_data omap4460_data = {
 	.has_talert = true,
 	.has_tshut = true,
+	.tshut_gpio = 86,
 	.fclock_name = "bandgap_ts_fclk",
 	.div_ck_name = "div_ts_ck",
 	.conv_table = omap4460_adc_to_temp,
 	.expose_sensor = omap4_thermal_expose_sensor,
+	.irq = 126,
 	.sensors = {
 		{
 			.registers = &omap4460_mpu_temp_sensor_registers,
@@ -1206,9 +1210,11 @@ static const struct omap_bandgap_data om
 static const struct omap_bandgap_data omap5430_data = {
 	.has_talert = true,
 	.has_tshut = true,
+	.tshut_gpio = 0, /* TODO. Fill correct tshut_gpio */
 	.fclock_name = "ts_clk_div_ck",
 	.div_ck_name = "ts_clk_div_ck",
 	.conv_table = omap5430_adc_to_temp,
+	.irq = 0, /* TODO. Fill correct irq */
 	.sensors = {
 		{
 			.registers = &omap5430_mpu_temp_sensor_registers,
@@ -1235,12 +1241,7 @@ static const struct of_device_id of_omap
 	 * { .compatible = "ti,omap4430-bandgap", .data = , },
 	 */
 	{
-		.compatible = "ti,omap4460-bandgap",
-		.data = (void *)&omap4460_data,
-	},
-	{
-		.compatible = "ti,omap5430-bandgap",
-		.data = (void *)&omap5430_data,
+		.compatible = "ti,omap4-bandgap",
 	},
 	/* Sentinel */
 	{ },
@@ -1249,9 +1250,10 @@ static const struct of_device_id of_omap
 static struct omap_bandgap *omap_bandgap_build(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
-	const struct of_device_id *of_id;
 	struct omap_bandgap *bg_ptr;
-	u32 prop;
+	struct device *scm;
+	u32 val;
+	int ret;
 
 	/* just for the sake */
 	if (!node) {
@@ -1266,16 +1268,34 @@ static struct omap_bandgap *omap_bandgap
 		return ERR_PTR(-ENOMEM);
 	}
 
-	of_id = of_match_device(of_omap_bandgap_match, &pdev->dev);
-	if (of_id)
-		bg_ptr->pdata = of_id->data;
+	scm = omap_control_get();
+	if(!scm)
+		return 0;
+
+	ret = omap_control_readl(scm, 0x0, &val);
+	if(ret)
+		return 0;
+
+	/*
+	 * Check omap control core module revision to find out
+	 * bandgap type
+	 */
+	switch ((val & 0x3ff) >> 8) {
+	case 1:
+		/* 4430 */
+		bg_ptr->pdata = &omap4460_data;
+		break;
+	case 2:
+		/* 4460 */
+		bg_ptr->pdata = &omap4460_data;
+		break;
+	default:
+		/* Unknown omap control core module revision */
+		return 0;
+	}
 
 	if (bg_ptr->pdata->has_tshut) {
-		if (of_property_read_u32(node, "ti,tshut-gpio", &prop) < 0) {
-			dev_err(&pdev->dev, "missing tshut gpio in device tree\n");
-			return ERR_PTR(-EINVAL);
-		}
-		bg_ptr->tshut_gpio = prop;
+		bg_ptr->tshut_gpio = bg_ptr->pdata->tshut_gpio;
 		if (!gpio_is_valid(bg_ptr->tshut_gpio)) {
 			dev_err(&pdev->dev, "invalid gpio for tshut (%d)\n",
 				bg_ptr->tshut_gpio);

