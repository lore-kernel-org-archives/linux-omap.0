From: pramod gurav <pramodforum@gmail.com>
Subject: Re: USB charging over TPS65950 BCI
Date: Fri, 11 Sep 2009 19:31:02 +0530
Message-ID: <f502236f0909110701o7b97959br63da1add5d3d37ba@mail.gmail.com>
References: <f502236f0907310649t148117f6l8a5a06cb651dca6d@mail.gmail.com>
	 <1249108890.20954.8.camel@gregoire-laptop>
	 <1249489092.24549.9.camel@gregoire-laptop>
	 <f502236f0909110651v1c323f7co1fc515654f236eda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f184.google.com ([209.85.222.184]:41533 "EHLO
	mail-pz0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbZIKOA7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Sep 2009 10:00:59 -0400
Received: by pzk14 with SMTP id 14so926835pzk.1
        for <linux-omap@vger.kernel.org>; Fri, 11 Sep 2009 07:01:02 -0700 (PDT)
In-Reply-To: <f502236f0909110651v1c323f7co1fc515654f236eda@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: gregoire@gentil.com, linux-omap@vger.kernel.org

hi gregoire,
i did not mention about charge current. the sysfs entry charge_current
always returns 360.


--=20
Best Regards
Pramod


On Fri, Sep 11, 2009 at 7:21 PM, pramod gurav <pramodforum@gmail.com> w=
rote:
> Hello gregoire,
>
> Really sorry I could not reply to your mail as I was busy with some o=
ther work.
> I applied your above patch tested. The sysfs entries return correct
> values for status, charger device(online), voltage_now. But the
> current across the battery is reported wrong. I compared the values
> returned by current_now sysfs entry with multimeter values across the
> battery. The values were varying whenever I remove AC and plug it
> back. But what I could see was the current_now value was approximatel=
y
> double the actual current across the battery.
> Without your patch the twl4030_bci gives wrong values for current_now=
,
> voltage_now, capacity etc.
> But your patch fixes this issue.
>
> But the USB charging did not work. Is USB charging functional with
> TWL4030 on any of the OMAP boards?
>
>
> Don't mind for the late reply. Thanks for your help.
>
> --
> Thanks and Best Regards
> Pramod
>
> On Wed, Aug 5, 2009 at 9:48 PM, Gregoire Gentil <gregoire@gentil.com>=
 wrote:
>> Hello,
>>
>> Any feed-back on the patch I sent? Have you tried it? Have you fixed
>> your problem?
>>
>> Gr=E9goire
>>
>>
>> On Fri, 2009-07-31 at 23:41 -0700, Gregoire Gentil wrote:
>>> On Fri, 2009-07-31 at 19:19 +0530, pramod gurav wrote:
>>> > Hi All,
>>> > I was trying to get the USB battery charging working over TPS6595=
0 BCI
>>> > on the OMAP3430 custom board. I am working with linux-omap-2.6
>>> > v2.6.28-omap1 tag. I enabled the TWL4030 MADC and TWL4030 BCI dri=
vers.
>>> > I passed interrupt details to these drivers from platform_device
>>> > structure from my board file. I could get the AC charging working=
=2E The
>>> > AC and USB detection worked. However the USB charging is not
>>> > happening.
>>> > I read through the TPS TRM and took the dumps of the registers fr=
om
>>> > BCI and some from TWL USB module and BOOT_BCI whenever I plug in =
the
>>> > USB charger between host and the board. The register settings see=
m to
>>> > be fine. But the battery is not charging. I am using BQ27000 chip=
 for
>>> > battery monitoring and I can see the battery voltage is decreasin=
g.
>>> >
>>> > Following are the register dumps of TWL with and without USB plug=
ged in:
>>> >
>>> > These are the register contents when USB charger is plugged in:
>>> > BCIMDEN =A0 =A0 =A0 =A0 =3D 0x11
>>> > REG_BOOT_BCI =A0 =A0=3D 0x37
>>> > REG_POWER_CTRL =A0=3D 0x20
>>> > REG_BCIMFSTS4 =A0 =3D 0xf4
>>> > REG_BCIMFSTS1 =A0 =3D 0x13
>>> > REG_BCIIREF1 =A0 =A0=3D 0x68
>>> > REG_BCIIREF2 =A0 =A0=3D 0x3
>>> > REG_BCIMFEN4 =A0 =A0=3D 0x6f
>>> > REG_BCIMFSTS2 =A0 =3D 0x0
>>> > REG_BCIMSTATEC =A0=3D 0x12
>>> > REG_STS_HW_CONDITIONS=3D 0x90
>>> >
>>> >
>>> > These are the register contents when USB charger is plugged out:
>>> > BCIMDEN =A0 =A0 =A0 =A0 =3D 0x0
>>> > REG_BOOT_BCI =A0 =A0=3D 0x35
>>> > REG_POWER_CTRL =A0=3D 0x20
>>> > REG_BCIMFSTS4 =A0 =3D 0xf0
>>> > REG_BCIMFSTS1 =A0 =3D 0xaa
>>> > REG_BCIIREF1 =A0 =A0=3D 0x68
>>> > REG_BCIIREF2 =A0 =A0=3D 0x3
>>> > REG_BCIMFEN4 =A0 =A0=3D 0x68
>>> > REG_BCIMFSTS2 =A0 =3D 0x0
>>> > REG_BCIMSTATEC =A0=3D0x0
>>> > REG_STS_HW_CONDITIONS=3D 0x10
>>> >
>>> > Is there anything more I need to support to get BCI USB charging
>>> > working? Need I follow any USB Communication protocol between Hos=
t and
>>> > the board.
>>> > I have pasted the kernel boot logs for reference at the end.
>>> > Can any one please guide me to some pointers?
>>> >
>>> > --
>>> > Best Regards
>>> > Pramod
>>> I'm experiencing some problems with TWL4030 DC charging and I'm
>>> interested by this kind of problem. Basically, the values reported =
by
>>> our patch is different from the current going to the battery. We wr=
ote
>>> the attached enhanced patch so as to edit at run-time the charging =
mode
>>> and various values including charge_current. It's against 2.6.29 bu=
t I
>>> think that it should work again 2.6.28. Unfortunately, starting 2.6=
=2E30,
>>> Tony has removed all the BCI battery code and has asked for updated=
 code
>>> against mainline but I've not seen anything so far.
>>>
>>> Pramod, can you try the attached patch (perhaps, it will help you) =
and
>>> can you tell if you see the exact current going to the battery repo=
rted
>>> by the driver?
>>>
>>> Gr=E9goire
>>>
>>>
>>>
>>>
>>>
>>> --- a/drivers/power/twl4030_bci_battery.c =A0 =A0 2009-07-22 18:27:=
16.000000000
>>> -0700
>>> +++ b/drivers/power/twl4030_bci_battery.c =A0 =A0 2009-07-22 18:30:=
22.000000000
>>> -0700
>>> @@ -15,6 +15,9 @@
>>> =A0 * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PU=
RPOSE.
>>> =A0 */
>>>
>>> +/* Boot with automatic charge */
>>> +#define CHARGE_MODE 1
>>> +
>>> =A0#include <linux/init.h>
>>> =A0#include <linux/module.h>
>>> =A0#include <linux/device.h>
>>> @@ -50,6 +53,7 @@
>>> =A0/* Boot BCI flag bits */
>>> =A0#define BCIAUTOWEN =A0 =A0 =A0 =A0 =A0 0x020
>>> =A0#define CONFIG_DONE =A0 =A0 =A0 =A0 =A00x010
>>> +#define CVENAC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x004
>>> =A0#define BCIAUTOUSB =A0 =A0 =A0 =A0 =A0 0x002
>>> =A0#define BCIAUTOAC =A0 =A0 =A0 =A0 =A0 =A00x001
>>> =A0#define BCIMSTAT_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x03F
>>> @@ -81,6 +85,11 @@
>>> =A0#define REG_BB_CFG =A0 =A0 =A0 =A0 =A0 0x012
>>> =A0#define BBCHEN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x010
>>>
>>> +/* GPBR */
>>> +#define REG_GPBR1 =A0 =A0 =A0 =A0 =A0 =A00x0c
>>> +#define MADC_HFCLK_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x80
>>> +#define DEFAULT_MADC_CLK_EN =A00x10
>>> +
>>> =A0/* Power supply charge interrupt */
>>> =A0#define REG_PWR_ISR1 =A0 =A0 =A0 =A0 0x00
>>> =A0#define REG_PWR_IMR1 =A0 =A0 =A0 =A0 0x01
>>> @@ -125,6 +134,18 @@
>>> =A0/* BCIEDR3 */
>>> =A0#define =A0 =A0 =A0VBATLVL_EDRRISIN =A0 =A0 =A0 =A00x02
>>>
>>> +/* BCIIREF1 */
>>> +#define REG_BCIIREF1 =A0 =A0 =A0 =A0 0x027
>>> +#define REG_BCIIREF2 =A0 =A0 =A0 =A0 0x028
>>> +
>>> +/* BCIMFTH1 */
>>> +#define REG_BCIMFTH1 =A0 =A0 =A0 =A0 0x016
>>> +
>>> +/* Key */
>>> +#define KEY_IIREF =A0 =A0 =A0 =A0 =A0 =A00xE7
>>> +#define KEY_FTH1 =A0 =A0 =A0 =A0 =A0 =A0 0xD2
>>> +#define REG_BCIMFKEY =A0 =A0 =A0 =A0 0x011
>>> +
>>> =A0/* Step size and prescaler ratio */
>>> =A0#define TEMP_STEP_SIZE =A0 =A0 =A0 =A0 =A0 =A0 =A0 147
>>> =A0#define TEMP_PSR_R =A0 =A0 =A0 =A0 =A0 100
>>> @@ -142,9 +163,6 @@
>>> =A0#define ENABLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 1
>>> =A0#define DISABLE =A0 =A0 =A0 =A0 =A0 =A0 =A01
>>>
>>> -/* Ptr to thermistor table */
>>> -int *therm_tbl;
>>> -
>>> =A0struct twl4030_bci_device_info {
>>> =A0 =A0 =A0 struct device =A0 =A0 =A0 =A0 =A0 *dev;
>>>
>>> @@ -160,6 +178,8 @@
>>> =A0 =A0 =A0 struct power_supply =A0 =A0 bk_bat;
>>> =A0 =A0 =A0 struct delayed_work =A0 =A0 twl4030_bci_monitor_work;
>>> =A0 =A0 =A0 struct delayed_work =A0 =A0 twl4030_bk_bci_monitor_work=
;
>>> +
>>> + =A0 =A0 struct twl4030_bci_platform_data *pdata;
>>> =A0};
>>>
>>> =A0static int usb_charger_flag;
>>> @@ -425,15 +445,21 @@
>>> =A0/*
>>> =A0 * Enable/Disable AC Charge funtionality.
>>> =A0 */
>>> -static int twl4030charger_ac_en(int enable)
>>> +static int twl4030charger_ac_en(int enable, int automatic)
>>> =A0{
>>> =A0 =A0 =A0 int ret;
>>>
>>> =A0 =A0 =A0 if (enable) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* forcing the field BCIAUTOAC (BOOT_BC=
I[0) to 1 */
>>> - =A0 =A0 =A0 =A0 =A0 =A0 ret =3D clear_n_set(TWL4030_MODULE_PM_MAS=
TER, 0,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (CONFIG_DONE | BCIAUTOWEN=
 | BCIAUTOAC),
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 REG_BOOT_BCI);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 if(!automatic) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D clear_n_set(TWL40=
30_MODULE_PM_MASTER, BCIAUTOAC | CVENAC,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (CONFIG_D=
ONE | BCIAUTOWEN),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 REG_BOOT_=
BCI);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D clear_n_set(TWL40=
30_MODULE_PM_MASTER, 0,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (CONFIG_D=
ONE | BCIAUTOWEN | BCIAUTOAC | CVENAC),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 REG_BOOT_=
BCI);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>>> =A0 =A0 =A0 } else {
>>> @@ -518,11 +544,15 @@
>>> =A0 * Return battery temperature
>>> =A0 * Or < 0 on failure.
>>> =A0 */
>>> -static int twl4030battery_temperature(void)
>>> +static int twl4030battery_temperature(struct twl4030_bci_device_in=
fo
>>> *di)
>>> =A0{
>>> =A0 =A0 =A0 u8 val;
>>> =A0 =A0 =A0 int temp, curr, volt, res, ret;
>>>
>>> + =A0 =A0 /* Is a temperature table specified? */
>>> + =A0 =A0 if (!di->pdata->tblsize)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>> +
>>> =A0 =A0 =A0 /* Getting and calculating the thermistor voltage */
>>> =A0 =A0 =A0 ret =3D read_bci_val(T2_BATTERY_TEMP);
>>> =A0 =A0 =A0 if (ret < 0)
>>> @@ -543,7 +573,7 @@
>>>
>>> =A0 =A0 =A0 /*calculating temperature*/
>>> =A0 =A0 =A0 for (temp =3D 58; temp >=3D 0; temp--) {
>>> - =A0 =A0 =A0 =A0 =A0 =A0 int actual =3D therm_tbl[temp];
>>> + =A0 =A0 =A0 =A0 =A0 =A0 int actual =3D di->pdata->battery_tmp_tbl=
[temp];
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((actual - res) >=3D 0)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>> =A0 =A0 =A0 }
>>> @@ -661,6 +691,9 @@
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>>> =A0 =A0 =A0 }
>>>
>>> +#ifdef DEBUG
>>> + =A0 =A0 printk("BCI DEBUG: BCIMSTATEC Charge state is 0x%x\n", st=
atus);
>>> +#endif
>>> =A0 =A0 =A0 return (int) (status & BCIMSTAT_MASK);
>>> =A0}
>>>
>>> @@ -709,14 +742,43 @@
>>> =A0 */
>>> =A0static int twl4030battery_temp_setup(void)
>>> =A0{
>>> - =A0 =A0 int ret;
>>> +#ifdef DEBUG
>>> + =A0 =A0 u8 i;
>>> +#endif
>>> + =A0 =A0 u8 ret;
>>>
>>> =A0 =A0 =A0 /* Enabling thermistor current */
>>> - =A0 =A0 ret =3D clear_n_set(TWL4030_MODULE_MAIN_CHARGE, 0, ITHEN,
>>> + =A0 =A0 ret =3D clear_n_set(TWL4030_MODULE_MAIN_CHARGE, 0, 0x1B,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 REG_BCICTL1);
>>> =A0 =A0 =A0 if (ret)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>>>
>>> +#ifdef DEBUG
>>> + =A0 =A0 twl4030_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &ret, REG_B=
OOT_BCI);
>>> + =A0 =A0 printk("BCI DEBUG: BOOT_BCI Value is 0x%x\n", ret);
>>> +
>>> + =A0 =A0 twl4030_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &ret,
>>> REG_STS_HW_CONDITIONS);
>>> + =A0 =A0 printk("BCI DEBUG: STS_HW_CONDITIONS Value is 0x%x\n", re=
t);
>>> +
>>> + =A0 =A0 twl4030_i2c_read_u8(TWL4030_MODULE_MAIN_CHARGE, &ret, REG=
_BCICTL1);
>>> + =A0 =A0 printk("BCI DEBUG: BCICTL1 Value is 0x%x\n", ret);
>>> +
>>> + =A0 =A0 twl4030_i2c_read_u8(TWL4030_MODULE_MAIN_CHARGE, &ret, REG=
_BCICTL2);
>>> + =A0 =A0 printk("BCI DEBUG: BCICTL2 Value is 0x%x\n", ret);
>>> +
>>> + =A0 =A0 twl4030_i2c_read_u8(TWL4030_MODULE_MAIN_CHARGE, &ret, 0x0=
);
>>> + =A0 =A0 printk("BCI DEBUG: BCIMDEN Value is 0x%x\n", ret);
>>> +
>>> + =A0 =A0 twl4030_i2c_read_u8(TWL4030_MODULE_INTBR, &ret, REG_GPBR1=
);
>>> + =A0 =A0 printk("BCI DEBUG: GPBR1 Value is 0x%x\n", ret);
>>> +
>>> + =A0 =A0 for(i =3D 0x0; i <=3D 0x32; i++)
>>> + =A0 =A0 {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 twl4030_i2c_read_u8(TWL4030_MODULE_MAIN_C=
HARGE, &ret, i);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 printk("BCI DEBUG: BCI 0x%x Value is 0x%x=
\n", i, ret);
>>> + =A0 =A0 }
>>> +#endif
>>> +
>>> =A0 =A0 =A0 return 0;
>>> =A0}
>>>
>>> @@ -732,7 +794,6 @@
>>> =A0 =A0 =A0 ret =3D twl4030_i2c_read_u8(mod_no, &val, reg);
>>> =A0 =A0 =A0 if (ret)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>>> -
>>> =A0 =A0 =A0 /* Clearing all those bits to clear */
>>> =A0 =A0 =A0 val &=3D ~(clear);
>>>
>>> @@ -772,13 +833,14 @@
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct twl4030_bci_device_info,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl4030_bk_bci_monitor_work.work);
>>>
>>> - =A0 =A0 twl4030_bk_bci_battery_read_status(di);
>>> + =A0 =A0 if(!di->pdata->no_backup_battery)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 twl4030_bk_bci_battery_read_status(di);
>>> =A0 =A0 =A0 schedule_delayed_work(&di->twl4030_bk_bci_monitor_work,=
 500);
>>> =A0}
>>>
>>> =A0static void twl4030_bci_battery_read_status(struct
>>> twl4030_bci_device_info *di)
>>> =A0{
>>> - =A0 =A0 di->temp_C =3D twl4030battery_temperature();
>>> + =A0 =A0 di->temp_C =3D twl4030battery_temperature(di);
>>> =A0 =A0 =A0 di->voltage_uV =3D twl4030battery_voltage();
>>> =A0 =A0 =A0 di->current_uA =3D twl4030battery_current();
>>> =A0}
>>> @@ -819,6 +881,87 @@
>>> =A0#define to_twl4030_bk_bci_device_info(x) container_of((x), \
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct twl4030_bci_device_info, bk_bat)=
;
>>>
>>> +static ssize_t
>>> +show_charge_current(struct device *dev, struct device_attribute *a=
ttr,
>>> char *buf)
>>> +{
>>> + =A0 =A0 u8 =A0ctl;
>>> + =A0 =A0 int ret =3D read_bci_val(REG_BCIIREF1) & 0x1FF;
>>> + =A0 =A0 twl4030_i2c_read_u8(TWL4030_MODULE_MAIN_CHARGE, &ctl, REG=
_BCICTL1);
>>> +
>>> + =A0 =A0 if (ctl & CGAIN)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 ret |=3D 0x200;
>>> +
>>> +#ifdef DEBUG
>>> + =A0 =A0 /* Dump debug */
>>> + =A0 =A0 twl4030battery_temp_setup();
>>> +#endif
>>> +
>>> + =A0 =A0 return sprintf(buf, "%d\n", ret);
>>> +}
>>> +
>>> +static ssize_t
>>> +set_charge_current(struct device *dev, struct device_attribute *at=
tr,
>>> const char *buf, size_t count)
>>> +{
>>> + =A0 =A0 unsigned long newCurrent;
>>> + =A0 =A0 int ret;
>>> +
>>> + =A0 =A0 ret =3D strict_strtoul(buf, 10, &newCurrent);
>>> + =A0 =A0 if (ret)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>>> +
>>> + =A0 =A0 ret =3D twl4030_i2c_write_u8(TWL4030_MODULE_MAIN_CHARGE, =
KEY_IIREF,
>>> REG_BCIMFKEY);
>>> + =A0 =A0 if (ret)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>>> +
>>> + =A0 =A0 ret =3D twl4030_i2c_write_u8(TWL4030_MODULE_MAIN_CHARGE, =
newCurrent &
>>> 0xff, REG_BCIIREF1);
>>> + =A0 =A0 if (ret)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>>> +
>>> + =A0 =A0 ret =3D twl4030_i2c_write_u8(TWL4030_MODULE_MAIN_CHARGE, =
KEY_IIREF,
>>> REG_BCIMFKEY);
>>> + =A0 =A0 if (ret)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>>> +
>>> + =A0 =A0 ret =3D twl4030_i2c_write_u8(TWL4030_MODULE_MAIN_CHARGE, =
(newCurrent >>
>>> 8) & 0x1, REG_BCIIREF2);
>>> + =A0 =A0 if (ret)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>>> +
>>> + =A0 =A0 /* Set software-controlled charge */
>>> + =A0 =A0 twl4030charger_ac_en(ENABLE, 0);
>>> +
>>> + =A0 =A0 /* Set CGAIN =3D 0 or 1 */
>>> + =A0 =A0 if(newCurrent > 511) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 u8 tmp;
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Set CGAIN =3D 1 -- need to wait until =
automatic charge turns off */
>>> + =A0 =A0 =A0 =A0 =A0 =A0 while(!ret) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_n_set(TWL4030_MODUL=
E_MAIN_CHARGE, 0, CGAIN | 0x1B,
>>> REG_BCICTL1);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl4030_i2c_read_u8(TWL40=
30_MODULE_MAIN_CHARGE, &tmp, REG_BCICTL1);
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D tmp & CGAIN;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if(!ret)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdelay(50=
);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>>> + =A0 =A0 } else {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 u8 tmp;
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Set CGAIN =3D 0 -- need to wait until =
automatic charge turns off */
>>> + =A0 =A0 =A0 =A0 =A0 =A0 while(!ret) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_n_set(TWL4030_MODUL=
E_MAIN_CHARGE, CGAIN, 0x1B, REG_BCICTL1);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl4030_i2c_read_u8(TWL40=
30_MODULE_MAIN_CHARGE, &tmp, REG_BCICTL1);
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D !(tmp & CGAIN);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if(!ret)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdelay(50=
);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>>> + =A0 =A0 }
>>> +
>>> + =A0 =A0 /* Set automatic charge (CGAIN =3D 0/1 persists) */
>>> + =A0 =A0 twl4030charger_ac_en(ENABLE, 1);
>>> +
>>> + =A0 =A0 return count;
>>> +}
>>> +static DEVICE_ATTR(charge_current, S_IRUGO | S_IWUSR,
>>> show_charge_current, set_charge_current);
>>> +
>>> =A0static int twl4030_bk_bci_battery_get_property(struct power_supp=
ly
>>> *psy,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 enum power_supply_property psp,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 union power_supply_propval *val)
>>> @@ -912,8 +1055,6 @@
>>> =A0 =A0 =A0 int irq;
>>> =A0 =A0 =A0 int ret;
>>>
>>> - =A0 =A0 therm_tbl =3D pdata->battery_tmp_tbl;
>>> -
>>> =A0 =A0 =A0 di =3D kzalloc(sizeof(*di), GFP_KERNEL);
>>> =A0 =A0 =A0 if (!di)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>>> @@ -937,8 +1078,12 @@
>>> =A0 =A0 =A0 di->bk_bat.num_properties =3D ARRAY_SIZE(twl4030_bk_bci=
_battery_props);
>>> =A0 =A0 =A0 di->bk_bat.get_property =3D twl4030_bk_bci_battery_get_=
property;
>>> =A0 =A0 =A0 di->bk_bat.external_power_changed =3D NULL;
>>> + =A0 =A0 di->pdata =3D pdata;
>>>
>>> - =A0 =A0 twl4030charger_ac_en(ENABLE);
>>> + =A0 =A0 /* Set up clocks */
>>> + =A0 =A0 twl4030_i2c_write_u8(TWL4030_MODULE_INTBR, MADC_HFCLK_EN =
|
>>> DEFAULT_MADC_CLK_EN, REG_GPBR1);
>>> +
>>> + =A0 =A0 twl4030charger_ac_en(ENABLE, CHARGE_MODE);
>>> =A0 =A0 =A0 twl4030charger_usb_en(ENABLE);
>>> =A0 =A0 =A0 twl4030battery_hw_level_en(ENABLE);
>>> =A0 =A0 =A0 twl4030battery_hw_presence_en(ENABLE);
>>> @@ -951,9 +1096,12 @@
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto temp_setup_fail;
>>>
>>> =A0 =A0 =A0 /* enabling GPCH09 for read back battery voltage */
>>> - =A0 =A0 ret =3D twl4030backupbatt_voltage_setup();
>>> - =A0 =A0 if (ret)
>>> - =A0 =A0 =A0 =A0 =A0 =A0 goto voltage_setup_fail;
>>> + =A0 =A0 if(!di->pdata->no_backup_battery)
>>> + =A0 =A0 {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D twl4030backupbatt_voltage_setup()=
;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto voltage_setup_fail;
>>> + =A0 =A0 }
>>>
>>> =A0 =A0 =A0 /* REVISIT do we need to request both IRQs ?? */
>>>
>>> @@ -988,9 +1136,18 @@
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl4030=
_bci_battery_work);
>>> =A0 =A0 =A0 schedule_delayed_work(&di->twl4030_bci_monitor_work, 0)=
;
>>>
>>> - =A0 =A0 ret =3D power_supply_register(&pdev->dev, &di->bk_bat);
>>> + =A0 =A0 if(!pdata->no_backup_battery)
>>> + =A0 =A0 {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D power_supply_register(&pdev->dev,=
 &di->bk_bat);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev, "fail=
ed to register backup battery\n");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto bk_batt_failed;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>>> + =A0 =A0 }
>>> +
>>> + =A0 =A0 ret =3D device_create_file(di->bat.dev, &dev_attr_charge_=
current);
>>> =A0 =A0 =A0 if (ret) {
>>> - =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev, "failed to register b=
ackup battery\n");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to create sys=
fs entries\n");
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto bk_batt_failed;
>>> =A0 =A0 =A0 }
>>>
>>> @@ -1001,7 +1158,8 @@
>>> =A0 =A0 =A0 return 0;
>>>
>>> =A0bk_batt_failed:
>>> - =A0 =A0 power_supply_unregister(&di->bat);
>>> + =A0 =A0 if(!pdata->no_backup_battery)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 power_supply_unregister(&di->bat);
>>> =A0batt_failed:
>>> =A0 =A0 =A0 free_irq(irq, di);
>>> =A0chg_irq_fail:
>>> @@ -1010,7 +1168,7 @@
>>> =A0batt_irq_fail:
>>> =A0voltage_setup_fail:
>>> =A0temp_setup_fail:
>>> - =A0 =A0 twl4030charger_ac_en(DISABLE);
>>> + =A0 =A0 twl4030charger_ac_en(DISABLE, CHARGE_MODE);
>>> =A0 =A0 =A0 twl4030charger_usb_en(DISABLE);
>>> =A0 =A0 =A0 twl4030battery_hw_level_en(DISABLE);
>>> =A0 =A0 =A0 twl4030battery_hw_presence_en(DISABLE);
>>> @@ -1024,7 +1182,7 @@
>>> =A0 =A0 =A0 struct twl4030_bci_device_info *di =3D platform_get_drv=
data(pdev);
>>> =A0 =A0 =A0 int irq;
>>>
>>> - =A0 =A0 twl4030charger_ac_en(DISABLE);
>>> + =A0 =A0 twl4030charger_ac_en(DISABLE, CHARGE_MODE);
>>> =A0 =A0 =A0 twl4030charger_usb_en(DISABLE);
>>> =A0 =A0 =A0 twl4030battery_hw_level_en(DISABLE);
>>> =A0 =A0 =A0 twl4030battery_hw_presence_en(DISABLE);
>>> --- a/include/linux/i2c/twl4030.h
>>> +++ b/include/linux/i2c/twl4030.h
>>> @@ -299,6 +299,8 @@ int twl4030_i2c_read(u8 mod_no, u8 *value, u8 r=
eg,
>>> unsigned num_bytes);
>>> =A0struct twl4030_bci_platform_data {
>>> =A0 =A0 =A0 int *battery_tmp_tbl;
>>> =A0 =A0 =A0 unsigned int tblsize;
>>> +
>>> + =A0 =A0 bool no_backup_battery;
>>> =A0};
>>>
>>> =A0/* TWL4030_GPIO_MAX (18) GPIOs, with interrupts */
>>>
>>
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
