From: Gregoire Gentil <gregoire@gentil.com>
Subject: Re: USB charging over TPS65950 BCI
Date: Mon, 14 Sep 2009 15:53:39 -0700
Message-ID: <1252968819.25977.31.camel@gregoire-laptop>
References: <f502236f0907310649t148117f6l8a5a06cb651dca6d@mail.gmail.com>
	 <1249108890.20954.8.camel@gregoire-laptop>
	 <1249489092.24549.9.camel@gregoire-laptop>
	 <f502236f0909110651v1c323f7co1fc515654f236eda@mail.gmail.com>
	 <f502236f0909110701o7b97959br63da1add5d3d37ba@mail.gmail.com>
Reply-To: gregoire@gentil.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:8190 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755354AbZINWxl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Sep 2009 18:53:41 -0400
Received: by qw-out-2122.google.com with SMTP id 9so1133669qwb.37
        for <linux-omap@vger.kernel.org>; Mon, 14 Sep 2009 15:53:44 -0700 (PDT)
In-Reply-To: <f502236f0909110701o7b97959br63da1add5d3d37ba@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: pramod gurav <pramodforum@gmail.com>
Cc: linux-omap@vger.kernel.org, Tim Yamin <plasmaroo@gmail.com>, "Dighe, Gandhar" <gandhar@ti.com>

I don't know. I haven't seen yet a battery driver that works correctly
with the TPS65950 and I have ping multiple times various people at TI.
Perhaps Gandhar will have an idea. I think that it would be valuable fo=
r
the community that somebody at TI provides some patches to report
correctly everything around the battery,

Gr=C3=A9goire


On Fri, 2009-09-11 at 19:31 +0530, pramod gurav wrote:=20
> hi gregoire,
> i did not mention about charge current. the sysfs entry charge_curren=
t
> always returns 360.
>=20
>=20
> --=20
> Best Regards
> Pramod
>=20
>=20
> On Fri, Sep 11, 2009 at 7:21 PM, pramod gurav <pramodforum@gmail.com>=
 wrote:
> > Hello gregoire,
> >
> > Really sorry I could not reply to your mail as I was busy with some=
 other work.
> > I applied your above patch tested. The sysfs entries return correct
> > values for status, charger device(online), voltage_now. But the
> > current across the battery is reported wrong. I compared the values
> > returned by current_now sysfs entry with multimeter values across t=
he
> > battery. The values were varying whenever I remove AC and plug it
> > back. But what I could see was the current_now value was approximat=
ely
> > double the actual current across the battery.
> > Without your patch the twl4030_bci gives wrong values for current_n=
ow,
> > voltage_now, capacity etc.
> > But your patch fixes this issue.
> >
> > But the USB charging did not work. Is USB charging functional with
> > TWL4030 on any of the OMAP boards?
> >
> >
> > Don't mind for the late reply. Thanks for your help.
> >
> > --
> > Thanks and Best Regards
> > Pramod
> >
> > On Wed, Aug 5, 2009 at 9:48 PM, Gregoire Gentil <gregoire@gentil.co=
m> wrote:
> >> Hello,
> >>
> >> Any feed-back on the patch I sent? Have you tried it? Have you fix=
ed
> >> your problem?
> >>
> >> Gr=C3=A9goire
> >>
> >>
> >> On Fri, 2009-07-31 at 23:41 -0700, Gregoire Gentil wrote:
> >>> On Fri, 2009-07-31 at 19:19 +0530, pramod gurav wrote:
> >>> > Hi All,
> >>> > I was trying to get the USB battery charging working over TPS65=
950 BCI
> >>> > on the OMAP3430 custom board. I am working with linux-omap-2.6
> >>> > v2.6.28-omap1 tag. I enabled the TWL4030 MADC and TWL4030 BCI d=
rivers.
> >>> > I passed interrupt details to these drivers from platform_devic=
e
> >>> > structure from my board file. I could get the AC charging worki=
ng. The
> >>> > AC and USB detection worked. However the USB charging is not
> >>> > happening.
> >>> > I read through the TPS TRM and took the dumps of the registers =
from
> >>> > BCI and some from TWL USB module and BOOT_BCI whenever I plug i=
n the
> >>> > USB charger between host and the board. The register settings s=
eem to
> >>> > be fine. But the battery is not charging. I am using BQ27000 ch=
ip for
> >>> > battery monitoring and I can see the battery voltage is decreas=
ing.
> >>> >
> >>> > Following are the register dumps of TWL with and without USB pl=
ugged in:
> >>> >
> >>> > These are the register contents when USB charger is plugged in:
> >>> > BCIMDEN         =3D 0x11
> >>> > REG_BOOT_BCI    =3D 0x37
> >>> > REG_POWER_CTRL  =3D 0x20
> >>> > REG_BCIMFSTS4   =3D 0xf4
> >>> > REG_BCIMFSTS1   =3D 0x13
> >>> > REG_BCIIREF1    =3D 0x68
> >>> > REG_BCIIREF2    =3D 0x3
> >>> > REG_BCIMFEN4    =3D 0x6f
> >>> > REG_BCIMFSTS2   =3D 0x0
> >>> > REG_BCIMSTATEC  =3D 0x12
> >>> > REG_STS_HW_CONDITIONS=3D 0x90
> >>> >
> >>> >
> >>> > These are the register contents when USB charger is plugged out=
:
> >>> > BCIMDEN         =3D 0x0
> >>> > REG_BOOT_BCI    =3D 0x35
> >>> > REG_POWER_CTRL  =3D 0x20
> >>> > REG_BCIMFSTS4   =3D 0xf0
> >>> > REG_BCIMFSTS1   =3D 0xaa
> >>> > REG_BCIIREF1    =3D 0x68
> >>> > REG_BCIIREF2    =3D 0x3
> >>> > REG_BCIMFEN4    =3D 0x68
> >>> > REG_BCIMFSTS2   =3D 0x0
> >>> > REG_BCIMSTATEC  =3D0x0
> >>> > REG_STS_HW_CONDITIONS=3D 0x10
> >>> >
> >>> > Is there anything more I need to support to get BCI USB chargin=
g
> >>> > working? Need I follow any USB Communication protocol between H=
ost and
> >>> > the board.
> >>> > I have pasted the kernel boot logs for reference at the end.
> >>> > Can any one please guide me to some pointers?
> >>> >
> >>> > --
> >>> > Best Regards
> >>> > Pramod
> >>> I'm experiencing some problems with TWL4030 DC charging and I'm
> >>> interested by this kind of problem. Basically, the values reporte=
d by
> >>> our patch is different from the current going to the battery. We =
wrote
> >>> the attached enhanced patch so as to edit at run-time the chargin=
g mode
> >>> and various values including charge_current. It's against 2.6.29 =
but I
> >>> think that it should work again 2.6.28. Unfortunately, starting 2=
=2E6.30,
> >>> Tony has removed all the BCI battery code and has asked for updat=
ed code
> >>> against mainline but I've not seen anything so far.
> >>>
> >>> Pramod, can you try the attached patch (perhaps, it will help you=
) and
> >>> can you tell if you see the exact current going to the battery re=
ported
> >>> by the driver?
> >>>
> >>> Gr=C3=A9goire
> >>>
> >>>
> >>>
> >>>
> >>>
> >>> --- a/drivers/power/twl4030_bci_battery.c     2009-07-22 18:27:16=
=2E000000000
> >>> -0700
> >>> +++ b/drivers/power/twl4030_bci_battery.c     2009-07-22 18:30:22=
=2E000000000
> >>> -0700
> >>> @@ -15,6 +15,9 @@
> >>>   * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PU=
RPOSE.
> >>>   */
> >>>
> >>> +/* Boot with automatic charge */
> >>> +#define CHARGE_MODE 1
> >>> +
> >>>  #include <linux/init.h>
> >>>  #include <linux/module.h>
> >>>  #include <linux/device.h>
> >>> @@ -50,6 +53,7 @@
> >>>  /* Boot BCI flag bits */
> >>>  #define BCIAUTOWEN           0x020
> >>>  #define CONFIG_DONE          0x010
> >>> +#define CVENAC                       0x004
> >>>  #define BCIAUTOUSB           0x002
> >>>  #define BCIAUTOAC            0x001
> >>>  #define BCIMSTAT_MASK                0x03F
> >>> @@ -81,6 +85,11 @@
> >>>  #define REG_BB_CFG           0x012
> >>>  #define BBCHEN                       0x010
> >>>
> >>> +/* GPBR */
> >>> +#define REG_GPBR1            0x0c
> >>> +#define MADC_HFCLK_EN                0x80
> >>> +#define DEFAULT_MADC_CLK_EN  0x10
> >>> +
> >>>  /* Power supply charge interrupt */
> >>>  #define REG_PWR_ISR1         0x00
> >>>  #define REG_PWR_IMR1         0x01
> >>> @@ -125,6 +134,18 @@
> >>>  /* BCIEDR3 */
> >>>  #define      VBATLVL_EDRRISIN        0x02
> >>>
> >>> +/* BCIIREF1 */
> >>> +#define REG_BCIIREF1         0x027
> >>> +#define REG_BCIIREF2         0x028
> >>> +
> >>> +/* BCIMFTH1 */
> >>> +#define REG_BCIMFTH1         0x016
> >>> +
> >>> +/* Key */
> >>> +#define KEY_IIREF            0xE7
> >>> +#define KEY_FTH1             0xD2
> >>> +#define REG_BCIMFKEY         0x011
> >>> +
> >>>  /* Step size and prescaler ratio */
> >>>  #define TEMP_STEP_SIZE               147
> >>>  #define TEMP_PSR_R           100
> >>> @@ -142,9 +163,6 @@
> >>>  #define ENABLE               1
> >>>  #define DISABLE              1
> >>>
> >>> -/* Ptr to thermistor table */
> >>> -int *therm_tbl;
> >>> -
> >>>  struct twl4030_bci_device_info {
> >>>       struct device           *dev;
> >>>
> >>> @@ -160,6 +178,8 @@
> >>>       struct power_supply     bk_bat;
> >>>       struct delayed_work     twl4030_bci_monitor_work;
> >>>       struct delayed_work     twl4030_bk_bci_monitor_work;
> >>> +
> >>> +     struct twl4030_bci_platform_data *pdata;
> >>>  };
> >>>
> >>>  static int usb_charger_flag;
> >>> @@ -425,15 +445,21 @@
> >>>  /*
> >>>   * Enable/Disable AC Charge funtionality.
> >>>   */
> >>> -static int twl4030charger_ac_en(int enable)
> >>> +static int twl4030charger_ac_en(int enable, int automatic)
> >>>  {
> >>>       int ret;
> >>>
> >>>       if (enable) {
> >>>               /* forcing the field BCIAUTOAC (BOOT_BCI[0) to 1 */
> >>> -             ret =3D clear_n_set(TWL4030_MODULE_PM_MASTER, 0,
> >>> -                     (CONFIG_DONE | BCIAUTOWEN | BCIAUTOAC),
> >>> -                     REG_BOOT_BCI);
> >>> +             if(!automatic) {
> >>> +                     ret =3D clear_n_set(TWL4030_MODULE_PM_MASTE=
R, BCIAUTOAC | CVENAC,
> >>> +                             (CONFIG_DONE | BCIAUTOWEN),
> >>> +                             REG_BOOT_BCI);
> >>> +             } else {
> >>> +                     ret =3D clear_n_set(TWL4030_MODULE_PM_MASTE=
R, 0,
> >>> +                             (CONFIG_DONE | BCIAUTOWEN | BCIAUTO=
AC | CVENAC),
> >>> +                             REG_BOOT_BCI);
> >>> +             }
> >>>               if (ret)
> >>>                       return ret;
> >>>       } else {
> >>> @@ -518,11 +544,15 @@
> >>>   * Return battery temperature
> >>>   * Or < 0 on failure.
> >>>   */
> >>> -static int twl4030battery_temperature(void)
> >>> +static int twl4030battery_temperature(struct twl4030_bci_device_=
info
> >>> *di)
> >>>  {
> >>>       u8 val;
> >>>       int temp, curr, volt, res, ret;
> >>>
> >>> +     /* Is a temperature table specified? */
> >>> +     if (!di->pdata->tblsize)
> >>> +             return 0;
> >>> +
> >>>       /* Getting and calculating the thermistor voltage */
> >>>       ret =3D read_bci_val(T2_BATTERY_TEMP);
> >>>       if (ret < 0)
> >>> @@ -543,7 +573,7 @@
> >>>
> >>>       /*calculating temperature*/
> >>>       for (temp =3D 58; temp >=3D 0; temp--) {
> >>> -             int actual =3D therm_tbl[temp];
> >>> +             int actual =3D di->pdata->battery_tmp_tbl[temp];
> >>>               if ((actual - res) >=3D 0)
> >>>                       break;
> >>>       }
> >>> @@ -661,6 +691,9 @@
> >>>               return ret;
> >>>       }
> >>>
> >>> +#ifdef DEBUG
> >>> +     printk("BCI DEBUG: BCIMSTATEC Charge state is 0x%x\n", stat=
us);
> >>> +#endif
> >>>       return (int) (status & BCIMSTAT_MASK);
> >>>  }
> >>>
> >>> @@ -709,14 +742,43 @@
> >>>   */
> >>>  static int twl4030battery_temp_setup(void)
> >>>  {
> >>> -     int ret;
> >>> +#ifdef DEBUG
> >>> +     u8 i;
> >>> +#endif
> >>> +     u8 ret;
> >>>
> >>>       /* Enabling thermistor current */
> >>> -     ret =3D clear_n_set(TWL4030_MODULE_MAIN_CHARGE, 0, ITHEN,
> >>> +     ret =3D clear_n_set(TWL4030_MODULE_MAIN_CHARGE, 0, 0x1B,
> >>>               REG_BCICTL1);
> >>>       if (ret)
> >>>               return ret;
> >>>
> >>> +#ifdef DEBUG
> >>> +     twl4030_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &ret, REG_BOO=
T_BCI);
> >>> +     printk("BCI DEBUG: BOOT_BCI Value is 0x%x\n", ret);
> >>> +
> >>> +     twl4030_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &ret,
> >>> REG_STS_HW_CONDITIONS);
> >>> +     printk("BCI DEBUG: STS_HW_CONDITIONS Value is 0x%x\n", ret)=
;
> >>> +
> >>> +     twl4030_i2c_read_u8(TWL4030_MODULE_MAIN_CHARGE, &ret, REG_B=
CICTL1);
> >>> +     printk("BCI DEBUG: BCICTL1 Value is 0x%x\n", ret);
> >>> +
> >>> +     twl4030_i2c_read_u8(TWL4030_MODULE_MAIN_CHARGE, &ret, REG_B=
CICTL2);
> >>> +     printk("BCI DEBUG: BCICTL2 Value is 0x%x\n", ret);
> >>> +
> >>> +     twl4030_i2c_read_u8(TWL4030_MODULE_MAIN_CHARGE, &ret, 0x0);
> >>> +     printk("BCI DEBUG: BCIMDEN Value is 0x%x\n", ret);
> >>> +
> >>> +     twl4030_i2c_read_u8(TWL4030_MODULE_INTBR, &ret, REG_GPBR1);
> >>> +     printk("BCI DEBUG: GPBR1 Value is 0x%x\n", ret);
> >>> +
> >>> +     for(i =3D 0x0; i <=3D 0x32; i++)
> >>> +     {
> >>> +             twl4030_i2c_read_u8(TWL4030_MODULE_MAIN_CHARGE, &re=
t, i);
> >>> +             printk("BCI DEBUG: BCI 0x%x Value is 0x%x\n", i, re=
t);
> >>> +     }
> >>> +#endif
> >>> +
> >>>       return 0;
> >>>  }
> >>>
> >>> @@ -732,7 +794,6 @@
> >>>       ret =3D twl4030_i2c_read_u8(mod_no, &val, reg);
> >>>       if (ret)
> >>>               return ret;
> >>> -
> >>>       /* Clearing all those bits to clear */
> >>>       val &=3D ~(clear);
> >>>
> >>> @@ -772,13 +833,14 @@
> >>>               struct twl4030_bci_device_info,
> >>>               twl4030_bk_bci_monitor_work.work);
> >>>
> >>> -     twl4030_bk_bci_battery_read_status(di);
> >>> +     if(!di->pdata->no_backup_battery)
> >>> +             twl4030_bk_bci_battery_read_status(di);
> >>>       schedule_delayed_work(&di->twl4030_bk_bci_monitor_work, 500=
);
> >>>  }
> >>>
> >>>  static void twl4030_bci_battery_read_status(struct
> >>> twl4030_bci_device_info *di)
> >>>  {
> >>> -     di->temp_C =3D twl4030battery_temperature();
> >>> +     di->temp_C =3D twl4030battery_temperature(di);
> >>>       di->voltage_uV =3D twl4030battery_voltage();
> >>>       di->current_uA =3D twl4030battery_current();
> >>>  }
> >>> @@ -819,6 +881,87 @@
> >>>  #define to_twl4030_bk_bci_device_info(x) container_of((x), \
> >>>               struct twl4030_bci_device_info, bk_bat);
> >>>
> >>> +static ssize_t
> >>> +show_charge_current(struct device *dev, struct device_attribute =
*attr,
> >>> char *buf)
> >>> +{
> >>> +     u8  ctl;
> >>> +     int ret =3D read_bci_val(REG_BCIIREF1) & 0x1FF;
> >>> +     twl4030_i2c_read_u8(TWL4030_MODULE_MAIN_CHARGE, &ctl, REG_B=
CICTL1);
> >>> +
> >>> +     if (ctl & CGAIN)
> >>> +             ret |=3D 0x200;
> >>> +
> >>> +#ifdef DEBUG
> >>> +     /* Dump debug */
> >>> +     twl4030battery_temp_setup();
> >>> +#endif
> >>> +
> >>> +     return sprintf(buf, "%d\n", ret);
> >>> +}
> >>> +
> >>> +static ssize_t
> >>> +set_charge_current(struct device *dev, struct device_attribute *=
attr,
> >>> const char *buf, size_t count)
> >>> +{
> >>> +     unsigned long newCurrent;
> >>> +     int ret;
> >>> +
> >>> +     ret =3D strict_strtoul(buf, 10, &newCurrent);
> >>> +     if (ret)
> >>> +             return -EINVAL;
> >>> +
> >>> +     ret =3D twl4030_i2c_write_u8(TWL4030_MODULE_MAIN_CHARGE, KE=
Y_IIREF,
> >>> REG_BCIMFKEY);
> >>> +     if (ret)
> >>> +             return ret;
> >>> +
> >>> +     ret =3D twl4030_i2c_write_u8(TWL4030_MODULE_MAIN_CHARGE, ne=
wCurrent &
> >>> 0xff, REG_BCIIREF1);
> >>> +     if (ret)
> >>> +             return ret;
> >>> +
> >>> +     ret =3D twl4030_i2c_write_u8(TWL4030_MODULE_MAIN_CHARGE, KE=
Y_IIREF,
> >>> REG_BCIMFKEY);
> >>> +     if (ret)
> >>> +             return ret;
> >>> +
> >>> +     ret =3D twl4030_i2c_write_u8(TWL4030_MODULE_MAIN_CHARGE, (n=
ewCurrent >>
> >>> 8) & 0x1, REG_BCIIREF2);
> >>> +     if (ret)
> >>> +             return ret;
> >>> +
> >>> +     /* Set software-controlled charge */
> >>> +     twl4030charger_ac_en(ENABLE, 0);
> >>> +
> >>> +     /* Set CGAIN =3D 0 or 1 */
> >>> +     if(newCurrent > 511) {
> >>> +             u8 tmp;
> >>> +
> >>> +             /* Set CGAIN =3D 1 -- need to wait until automatic =
charge turns off */
> >>> +             while(!ret) {
> >>> +                     clear_n_set(TWL4030_MODULE_MAIN_CHARGE, 0, =
CGAIN | 0x1B,
> >>> REG_BCICTL1);
> >>> +                     twl4030_i2c_read_u8(TWL4030_MODULE_MAIN_CHA=
RGE, &tmp, REG_BCICTL1);
> >>> +
> >>> +                     ret =3D tmp & CGAIN;
> >>> +                     if(!ret)
> >>> +                             mdelay(50);
> >>> +             }
> >>> +     } else {
> >>> +             u8 tmp;
> >>> +
> >>> +             /* Set CGAIN =3D 0 -- need to wait until automatic =
charge turns off */
> >>> +             while(!ret) {
> >>> +                     clear_n_set(TWL4030_MODULE_MAIN_CHARGE, CGA=
IN, 0x1B, REG_BCICTL1);
> >>> +                     twl4030_i2c_read_u8(TWL4030_MODULE_MAIN_CHA=
RGE, &tmp, REG_BCICTL1);
> >>> +
> >>> +                     ret =3D !(tmp & CGAIN);
> >>> +                     if(!ret)
> >>> +                             mdelay(50);
> >>> +             }
> >>> +     }
> >>> +
> >>> +     /* Set automatic charge (CGAIN =3D 0/1 persists) */
> >>> +     twl4030charger_ac_en(ENABLE, 1);
> >>> +
> >>> +     return count;
> >>> +}
> >>> +static DEVICE_ATTR(charge_current, S_IRUGO | S_IWUSR,
> >>> show_charge_current, set_charge_current);
> >>> +
> >>>  static int twl4030_bk_bci_battery_get_property(struct power_supp=
ly
> >>> *psy,
> >>>                                       enum power_supply_property =
psp,
> >>>                                       union power_supply_propval =
*val)
> >>> @@ -912,8 +1055,6 @@
> >>>       int irq;
> >>>       int ret;
> >>>
> >>> -     therm_tbl =3D pdata->battery_tmp_tbl;
> >>> -
> >>>       di =3D kzalloc(sizeof(*di), GFP_KERNEL);
> >>>       if (!di)
> >>>               return -ENOMEM;
> >>> @@ -937,8 +1078,12 @@
> >>>       di->bk_bat.num_properties =3D ARRAY_SIZE(twl4030_bk_bci_bat=
tery_props);
> >>>       di->bk_bat.get_property =3D twl4030_bk_bci_battery_get_prop=
erty;
> >>>       di->bk_bat.external_power_changed =3D NULL;
> >>> +     di->pdata =3D pdata;
> >>>
> >>> -     twl4030charger_ac_en(ENABLE);
> >>> +     /* Set up clocks */
> >>> +     twl4030_i2c_write_u8(TWL4030_MODULE_INTBR, MADC_HFCLK_EN |
> >>> DEFAULT_MADC_CLK_EN, REG_GPBR1);
> >>> +
> >>> +     twl4030charger_ac_en(ENABLE, CHARGE_MODE);
> >>>       twl4030charger_usb_en(ENABLE);
> >>>       twl4030battery_hw_level_en(ENABLE);
> >>>       twl4030battery_hw_presence_en(ENABLE);
> >>> @@ -951,9 +1096,12 @@
> >>>               goto temp_setup_fail;
> >>>
> >>>       /* enabling GPCH09 for read back battery voltage */
> >>> -     ret =3D twl4030backupbatt_voltage_setup();
> >>> -     if (ret)
> >>> -             goto voltage_setup_fail;
> >>> +     if(!di->pdata->no_backup_battery)
> >>> +     {
> >>> +             ret =3D twl4030backupbatt_voltage_setup();
> >>> +             if (ret)
> >>> +                     goto voltage_setup_fail;
> >>> +     }
> >>>
> >>>       /* REVISIT do we need to request both IRQs ?? */
> >>>
> >>> @@ -988,9 +1136,18 @@
> >>>                               twl4030_bci_battery_work);
> >>>       schedule_delayed_work(&di->twl4030_bci_monitor_work, 0);
> >>>
> >>> -     ret =3D power_supply_register(&pdev->dev, &di->bk_bat);
> >>> +     if(!pdata->no_backup_battery)
> >>> +     {
> >>> +             ret =3D power_supply_register(&pdev->dev, &di->bk_b=
at);
> >>> +             if (ret) {
> >>> +                     dev_dbg(&pdev->dev, "failed to register bac=
kup battery\n");
> >>> +                     goto bk_batt_failed;
> >>> +             }
> >>> +     }
> >>> +
> >>> +     ret =3D device_create_file(di->bat.dev, &dev_attr_charge_cu=
rrent);
> >>>       if (ret) {
> >>> -             dev_dbg(&pdev->dev, "failed to register backup batt=
ery\n");
> >>> +             dev_err(&pdev->dev, "failed to create sysfs entries=
\n");
> >>>               goto bk_batt_failed;
> >>>       }
> >>>
> >>> @@ -1001,7 +1158,8 @@
> >>>       return 0;
> >>>
> >>>  bk_batt_failed:
> >>> -     power_supply_unregister(&di->bat);
> >>> +     if(!pdata->no_backup_battery)
> >>> +             power_supply_unregister(&di->bat);
> >>>  batt_failed:
> >>>       free_irq(irq, di);
> >>>  chg_irq_fail:
> >>> @@ -1010,7 +1168,7 @@
> >>>  batt_irq_fail:
> >>>  voltage_setup_fail:
> >>>  temp_setup_fail:
> >>> -     twl4030charger_ac_en(DISABLE);
> >>> +     twl4030charger_ac_en(DISABLE, CHARGE_MODE);
> >>>       twl4030charger_usb_en(DISABLE);
> >>>       twl4030battery_hw_level_en(DISABLE);
> >>>       twl4030battery_hw_presence_en(DISABLE);
> >>> @@ -1024,7 +1182,7 @@
> >>>       struct twl4030_bci_device_info *di =3D platform_get_drvdata=
(pdev);
> >>>       int irq;
> >>>
> >>> -     twl4030charger_ac_en(DISABLE);
> >>> +     twl4030charger_ac_en(DISABLE, CHARGE_MODE);
> >>>       twl4030charger_usb_en(DISABLE);
> >>>       twl4030battery_hw_level_en(DISABLE);
> >>>       twl4030battery_hw_presence_en(DISABLE);
> >>> --- a/include/linux/i2c/twl4030.h
> >>> +++ b/include/linux/i2c/twl4030.h
> >>> @@ -299,6 +299,8 @@ int twl4030_i2c_read(u8 mod_no, u8 *value, u8=
 reg,
> >>> unsigned num_bytes);
> >>>  struct twl4030_bci_platform_data {
> >>>       int *battery_tmp_tbl;
> >>>       unsigned int tblsize;
> >>> +
> >>> +     bool no_backup_battery;
> >>>  };
> >>>
> >>>  /* TWL4030_GPIO_MAX (18) GPIOs, with interrupts */
> >>>
> >>
> >>
> >

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
