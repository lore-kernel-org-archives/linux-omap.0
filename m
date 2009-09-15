From: "Dighe, Gandhar" <gandhar@ti.com>
Subject: RE: USB charging over TPS65950 BCI
Date: Tue, 15 Sep 2009 00:04:15 -0500
Message-ID: <F12EBA124C6E064B9CF1B45E67DDB7E780A2A5ED@dlee02.ent.ti.com>
References: <f502236f0907310649t148117f6l8a5a06cb651dca6d@mail.gmail.com>
	 <1249108890.20954.8.camel@gregoire-laptop>
	 <1249489092.24549.9.camel@gregoire-laptop>
	 <f502236f0909110651v1c323f7co1fc515654f236eda@mail.gmail.com>
	 <f502236f0909110701o7b97959br63da1add5d3d37ba@mail.gmail.com>
 <1252968819.25977.31.camel@gregoire-laptop>
 <0680EC522D0CC943BC586913CF3768C0037CF214AE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37776 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751664AbZIOFE2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Sep 2009 01:04:28 -0400
In-Reply-To: <0680EC522D0CC943BC586913CF3768C0037CF214AE@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>, "gregoire@gentil.com" <gregoire@gentil.com>, pramod gurav <pramodforum@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tim Yamin <plasmaroo@gmail.com>

Hi Khasim,

Actually it works very well on Pandora. For some reasons he had problem=
s with CV mode. When he switched his schematics to non-limited charger =
as in part (D) in the data manual he was able to use charger properly.


Regards,

Gandhar Dighe,
Texas Instruments Inc.
phone: (214)567-4146
TPS659xx Forum - http://community.ti.com/forums/107.aspx

My carbon footprint is 11 tons/yr and is reducing. What's your? Check h=
ere and join the rally!!
-----Original Message-----
=46rom: Syed Mohammed, Khasim
Sent: Monday, September 14, 2009 6:21 PM
To: gregoire@gentil.com; pramod gurav
Cc: linux-omap@vger.kernel.org; Tim Yamin; Dighe, Gandhar
Subject: RE: USB charging over TPS65950 BCI



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Gregoire Gentil
> Sent: Tuesday, September 15, 2009 4:24 AM
> To: pramod gurav
> Cc: linux-omap@vger.kernel.org; Tim Yamin; Dighe, Gandhar
> Subject: Re: USB charging over TPS65950 BCI
>
> I don't know. I haven't seen yet a battery driver that works correctl=
y
> with the TPS65950 and I have ping multiple times various people at TI=
=2E
Isn't this driver working for you? http://git.omapzoom.org/?p=3Drepo/om=
apkernel.git;a=3Dblob;f=3Ddrivers/power/twl4030_bci_battery.c;h=3D816db=
99e086f69d3efa46efd0ccbb60753a57b59;hb=3Dandroid-2.6.27

I know OMAP Zoom has battery driver and it does support USB charging. I=
t works on Open Pandora to an extent as well.

> Perhaps Gandhar will have an idea. I think that it would be valuable =
for
> the community that somebody at TI provides some patches to report
> correctly everything around the battery,
No idea why it wasn't published.

Regards,
Khasim

> Gr=E9goire
>
>
> On Fri, 2009-09-11 at 19:31 +0530, pramod gurav wrote:
> > hi gregoire,
> > i did not mention about charge current. the sysfs entry charge_curr=
ent
> > always returns 360.
> >
> >
> > --
> > Best Regards
> > Pramod
> >
> >
> > On Fri, Sep 11, 2009 at 7:21 PM, pramod gurav <pramodforum@gmail.co=
m>
> wrote:
> > > Hello gregoire,
> > >
> > > Really sorry I could not reply to your mail as I was busy with so=
me other
> work.
> > > I applied your above patch tested. The sysfs entries return corre=
ct
> > > values for status, charger device(online), voltage_now. But the
> > > current across the battery is reported wrong. I compared the valu=
es
> > > returned by current_now sysfs entry with multimeter values across=
 the
> > > battery. The values were varying whenever I remove AC and plug it
> > > back. But what I could see was the current_now value was approxim=
ately
> > > double the actual current across the battery.
> > > Without your patch the twl4030_bci gives wrong values for current=
_now,
> > > voltage_now, capacity etc.
> > > But your patch fixes this issue.
> > >
> > > But the USB charging did not work. Is USB charging functional wit=
h
> > > TWL4030 on any of the OMAP boards?
> > >
> > >
> > > Don't mind for the late reply. Thanks for your help.
> > >
> > > --
> > > Thanks and Best Regards
> > > Pramod
> > >
> > > On Wed, Aug 5, 2009 at 9:48 PM, Gregoire Gentil <gregoire@gentil.=
com>
> wrote:
> > >> Hello,
> > >>
> > >> Any feed-back on the patch I sent? Have you tried it? Have you f=
ixed
> > >> your problem?
> > >>
> > >> Gr=E9goire
> > >>
> > >>
> > >> On Fri, 2009-07-31 at 23:41 -0700, Gregoire Gentil wrote:
> > >>> On Fri, 2009-07-31 at 19:19 +0530, pramod gurav wrote:
> > >>> > Hi All,
> > >>> > I was trying to get the USB battery charging working over TPS=
65950
> BCI
> > >>> > on the OMAP3430 custom board. I am working with linux-omap-2.=
6
> > >>> > v2.6.28-omap1 tag. I enabled the TWL4030 MADC and TWL4030 BCI=
 drivers.
> > >>> > I passed interrupt details to these drivers from platform_dev=
ice
> > >>> > structure from my board file. I could get the AC charging wor=
king.
> The
> > >>> > AC and USB detection worked. However the USB charging is not
> > >>> > happening.
> > >>> > I read through the TPS TRM and took the dumps of the register=
s from
> > >>> > BCI and some from TWL USB module and BOOT_BCI whenever I plug=
 in the
> > >>> > USB charger between host and the board. The register settings=
 seem to
> > >>> > be fine. But the battery is not charging. I am using BQ27000 =
chip for
> > >>> > battery monitoring and I can see the battery voltage is decre=
asing.
> > >>> >
> > >>> > Following are the register dumps of TWL with and without USB =
plugged
> in:
> > >>> >
> > >>> > These are the register contents when USB charger is plugged i=
n:
> > >>> > BCIMDEN         =3D 0x11
> > >>> > REG_BOOT_BCI    =3D 0x37
> > >>> > REG_POWER_CTRL  =3D 0x20
> > >>> > REG_BCIMFSTS4   =3D 0xf4
> > >>> > REG_BCIMFSTS1   =3D 0x13
> > >>> > REG_BCIIREF1    =3D 0x68
> > >>> > REG_BCIIREF2    =3D 0x3
> > >>> > REG_BCIMFEN4    =3D 0x6f
> > >>> > REG_BCIMFSTS2   =3D 0x0
> > >>> > REG_BCIMSTATEC  =3D 0x12
> > >>> > REG_STS_HW_CONDITIONS=3D 0x90
> > >>> >
> > >>> >
> > >>> > These are the register contents when USB charger is plugged o=
ut:
> > >>> > BCIMDEN         =3D 0x0
> > >>> > REG_BOOT_BCI    =3D 0x35
> > >>> > REG_POWER_CTRL  =3D 0x20
> > >>> > REG_BCIMFSTS4   =3D 0xf0
> > >>> > REG_BCIMFSTS1   =3D 0xaa
> > >>> > REG_BCIIREF1    =3D 0x68
> > >>> > REG_BCIIREF2    =3D 0x3
> > >>> > REG_BCIMFEN4    =3D 0x68
> > >>> > REG_BCIMFSTS2   =3D 0x0
> > >>> > REG_BCIMSTATEC  =3D0x0
> > >>> > REG_STS_HW_CONDITIONS=3D 0x10
> > >>> >
> > >>> > Is there anything more I need to support to get BCI USB charg=
ing
> > >>> > working? Need I follow any USB Communication protocol between=
 Host
> and
> > >>> > the board.
> > >>> > I have pasted the kernel boot logs for reference at the end.
> > >>> > Can any one please guide me to some pointers?
> > >>> >
> > >>> > --
> > >>> > Best Regards
> > >>> > Pramod
> > >>> I'm experiencing some problems with TWL4030 DC charging and I'm
> > >>> interested by this kind of problem. Basically, the values repor=
ted by
> > >>> our patch is different from the current going to the battery. W=
e wrote
> > >>> the attached enhanced patch so as to edit at run-time the charg=
ing mode
> > >>> and various values including charge_current. It's against 2.6.2=
9 but I
> > >>> think that it should work again 2.6.28. Unfortunately, starting=
 2.6.30,
> > >>> Tony has removed all the BCI battery code and has asked for upd=
ated
> code
> > >>> against mainline but I've not seen anything so far.
> > >>>
> > >>> Pramod, can you try the attached patch (perhaps, it will help y=
ou) and
> > >>> can you tell if you see the exact current going to the battery =
reported
> > >>> by the driver?
> > >>>
> > >>> Gr=E9goire
> > >>>
> > >>>
> > >>>
> > >>>
> > >>>
> > >>> --- a/drivers/power/twl4030_bci_battery.c     2009-07-22
> 18:27:16.000000000
> > >>> -0700
> > >>> +++ b/drivers/power/twl4030_bci_battery.c     2009-07-22
> 18:30:22.000000000
> > >>> -0700
> > >>> @@ -15,6 +15,9 @@
> > >>>   * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR =
PURPOSE.
> > >>>   */
> > >>>
> > >>> +/* Boot with automatic charge */
> > >>> +#define CHARGE_MODE 1
> > >>> +
> > >>>  #include <linux/init.h>
> > >>>  #include <linux/module.h>
> > >>>  #include <linux/device.h>
> > >>> @@ -50,6 +53,7 @@
> > >>>  /* Boot BCI flag bits */
> > >>>  #define BCIAUTOWEN           0x020
> > >>>  #define CONFIG_DONE          0x010
> > >>> +#define CVENAC                       0x004
> > >>>  #define BCIAUTOUSB           0x002
> > >>>  #define BCIAUTOAC            0x001
> > >>>  #define BCIMSTAT_MASK                0x03F
> > >>> @@ -81,6 +85,11 @@
> > >>>  #define REG_BB_CFG           0x012
> > >>>  #define BBCHEN                       0x010
> > >>>
> > >>> +/* GPBR */
> > >>> +#define REG_GPBR1            0x0c
> > >>> +#define MADC_HFCLK_EN                0x80
> > >>> +#define DEFAULT_MADC_CLK_EN  0x10
> > >>> +
> > >>>  /* Power supply charge interrupt */
> > >>>  #define REG_PWR_ISR1         0x00
> > >>>  #define REG_PWR_IMR1         0x01
> > >>> @@ -125,6 +134,18 @@
> > >>>  /* BCIEDR3 */
> > >>>  #define      VBATLVL_EDRRISIN        0x02
> > >>>
> > >>> +/* BCIIREF1 */
> > >>> +#define REG_BCIIREF1         0x027
> > >>> +#define REG_BCIIREF2         0x028
> > >>> +
> > >>> +/* BCIMFTH1 */
> > >>> +#define REG_BCIMFTH1         0x016
> > >>> +
> > >>> +/* Key */
> > >>> +#define KEY_IIREF            0xE7
> > >>> +#define KEY_FTH1             0xD2
> > >>> +#define REG_BCIMFKEY         0x011
> > >>> +
> > >>>  /* Step size and prescaler ratio */
> > >>>  #define TEMP_STEP_SIZE               147
> > >>>  #define TEMP_PSR_R           100
> > >>> @@ -142,9 +163,6 @@
> > >>>  #define ENABLE               1
> > >>>  #define DISABLE              1
> > >>>
> > >>> -/* Ptr to thermistor table */
> > >>> -int *therm_tbl;
> > >>> -
> > >>>  struct twl4030_bci_device_info {
> > >>>       struct device           *dev;
> > >>>
> > >>> @@ -160,6 +178,8 @@
> > >>>       struct power_supply     bk_bat;
> > >>>       struct delayed_work     twl4030_bci_monitor_work;
> > >>>       struct delayed_work     twl4030_bk_bci_monitor_work;
> > >>> +
> > >>> +     struct twl4030_bci_platform_data *pdata;
> > >>>  };
> > >>>
> > >>>  static int usb_charger_flag;
> > >>> @@ -425,15 +445,21 @@
> > >>>  /*
> > >>>   * Enable/Disable AC Charge funtionality.
> > >>>   */
> > >>> -static int twl4030charger_ac_en(int enable)
> > >>> +static int twl4030charger_ac_en(int enable, int automatic)
> > >>>  {
> > >>>       int ret;
> > >>>
> > >>>       if (enable) {
> > >>>               /* forcing the field BCIAUTOAC (BOOT_BCI[0) to 1 =
*/
> > >>> -             ret =3D clear_n_set(TWL4030_MODULE_PM_MASTER, 0,
> > >>> -                     (CONFIG_DONE | BCIAUTOWEN | BCIAUTOAC),
> > >>> -                     REG_BOOT_BCI);
> > >>> +             if(!automatic) {
> > >>> +                     ret =3D clear_n_set(TWL4030_MODULE_PM_MAS=
TER,
> BCIAUTOAC | CVENAC,
> > >>> +                             (CONFIG_DONE | BCIAUTOWEN),
> > >>> +                             REG_BOOT_BCI);
> > >>> +             } else {
> > >>> +                     ret =3D clear_n_set(TWL4030_MODULE_PM_MAS=
TER, 0,
> > >>> +                             (CONFIG_DONE | BCIAUTOWEN | BCIAU=
TOAC |
> CVENAC),
> > >>> +                             REG_BOOT_BCI);
> > >>> +             }
> > >>>               if (ret)
> > >>>                       return ret;
> > >>>       } else {
> > >>> @@ -518,11 +544,15 @@
> > >>>   * Return battery temperature
> > >>>   * Or < 0 on failure.
> > >>>   */
> > >>> -static int twl4030battery_temperature(void)
> > >>> +static int twl4030battery_temperature(struct twl4030_bci_devic=
e_info
> > >>> *di)
> > >>>  {
> > >>>       u8 val;
> > >>>       int temp, curr, volt, res, ret;
> > >>>
> > >>> +     /* Is a temperature table specified? */
> > >>> +     if (!di->pdata->tblsize)
> > >>> +             return 0;
> > >>> +
> > >>>       /* Getting and calculating the thermistor voltage */
> > >>>       ret =3D read_bci_val(T2_BATTERY_TEMP);
> > >>>       if (ret < 0)
> > >>> @@ -543,7 +573,7 @@
> > >>>
> > >>>       /*calculating temperature*/
> > >>>       for (temp =3D 58; temp >=3D 0; temp--) {
> > >>> -             int actual =3D therm_tbl[temp];
> > >>> +             int actual =3D di->pdata->battery_tmp_tbl[temp];
> > >>>               if ((actual - res) >=3D 0)
> > >>>                       break;
> > >>>       }
> > >>> @@ -661,6 +691,9 @@
> > >>>               return ret;
> > >>>       }
> > >>>
> > >>> +#ifdef DEBUG
> > >>> +     printk("BCI DEBUG: BCIMSTATEC Charge state is 0x%x\n", st=
atus);
> > >>> +#endif
> > >>>       return (int) (status & BCIMSTAT_MASK);
> > >>>  }
> > >>>
> > >>> @@ -709,14 +742,43 @@
> > >>>   */
> > >>>  static int twl4030battery_temp_setup(void)
> > >>>  {
> > >>> -     int ret;
> > >>> +#ifdef DEBUG
> > >>> +     u8 i;
> > >>> +#endif
> > >>> +     u8 ret;
> > >>>
> > >>>       /* Enabling thermistor current */
> > >>> -     ret =3D clear_n_set(TWL4030_MODULE_MAIN_CHARGE, 0, ITHEN,
> > >>> +     ret =3D clear_n_set(TWL4030_MODULE_MAIN_CHARGE, 0, 0x1B,
> > >>>               REG_BCICTL1);
> > >>>       if (ret)
> > >>>               return ret;
> > >>>
> > >>> +#ifdef DEBUG
> > >>> +     twl4030_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &ret,
> REG_BOOT_BCI);
> > >>> +     printk("BCI DEBUG: BOOT_BCI Value is 0x%x\n", ret);
> > >>> +
> > >>> +     twl4030_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &ret,
> > >>> REG_STS_HW_CONDITIONS);
> > >>> +     printk("BCI DEBUG: STS_HW_CONDITIONS Value is 0x%x\n", re=
t);
> > >>> +
> > >>> +     twl4030_i2c_read_u8(TWL4030_MODULE_MAIN_CHARGE, &ret,
> REG_BCICTL1);
> > >>> +     printk("BCI DEBUG: BCICTL1 Value is 0x%x\n", ret);
> > >>> +
> > >>> +     twl4030_i2c_read_u8(TWL4030_MODULE_MAIN_CHARGE, &ret,
> REG_BCICTL2);
> > >>> +     printk("BCI DEBUG: BCICTL2 Value is 0x%x\n", ret);
> > >>> +
> > >>> +     twl4030_i2c_read_u8(TWL4030_MODULE_MAIN_CHARGE, &ret, 0x0=
);
> > >>> +     printk("BCI DEBUG: BCIMDEN Value is 0x%x\n", ret);
> > >>> +
> > >>> +     twl4030_i2c_read_u8(TWL4030_MODULE_INTBR, &ret, REG_GPBR1=
);
> > >>> +     printk("BCI DEBUG: GPBR1 Value is 0x%x\n", ret);
> > >>> +
> > >>> +     for(i =3D 0x0; i <=3D 0x32; i++)
> > >>> +     {
> > >>> +             twl4030_i2c_read_u8(TWL4030_MODULE_MAIN_CHARGE, &=
ret, i);
> > >>> +             printk("BCI DEBUG: BCI 0x%x Value is 0x%x\n", i, =
ret);
> > >>> +     }
> > >>> +#endif
> > >>> +
> > >>>       return 0;
> > >>>  }
> > >>>
> > >>> @@ -732,7 +794,6 @@
> > >>>       ret =3D twl4030_i2c_read_u8(mod_no, &val, reg);
> > >>>       if (ret)
> > >>>               return ret;
> > >>> -
> > >>>       /* Clearing all those bits to clear */
> > >>>       val &=3D ~(clear);
> > >>>
> > >>> @@ -772,13 +833,14 @@
> > >>>               struct twl4030_bci_device_info,
> > >>>               twl4030_bk_bci_monitor_work.work);
> > >>>
> > >>> -     twl4030_bk_bci_battery_read_status(di);
> > >>> +     if(!di->pdata->no_backup_battery)
> > >>> +             twl4030_bk_bci_battery_read_status(di);
> > >>>       schedule_delayed_work(&di->twl4030_bk_bci_monitor_work, 5=
00);
> > >>>  }
> > >>>
> > >>>  static void twl4030_bci_battery_read_status(struct
> > >>> twl4030_bci_device_info *di)
> > >>>  {
> > >>> -     di->temp_C =3D twl4030battery_temperature();
> > >>> +     di->temp_C =3D twl4030battery_temperature(di);
> > >>>       di->voltage_uV =3D twl4030battery_voltage();
> > >>>       di->current_uA =3D twl4030battery_current();
> > >>>  }
> > >>> @@ -819,6 +881,87 @@
> > >>>  #define to_twl4030_bk_bci_device_info(x) container_of((x), \
> > >>>               struct twl4030_bci_device_info, bk_bat);
> > >>>
> > >>> +static ssize_t
> > >>> +show_charge_current(struct device *dev, struct device_attribut=
e *attr,
> > >>> char *buf)
> > >>> +{
> > >>> +     u8  ctl;
> > >>> +     int ret =3D read_bci_val(REG_BCIIREF1) & 0x1FF;
> > >>> +     twl4030_i2c_read_u8(TWL4030_MODULE_MAIN_CHARGE, &ctl,
> REG_BCICTL1);
> > >>> +
> > >>> +     if (ctl & CGAIN)
> > >>> +             ret |=3D 0x200;
> > >>> +
> > >>> +#ifdef DEBUG
> > >>> +     /* Dump debug */
> > >>> +     twl4030battery_temp_setup();
> > >>> +#endif
> > >>> +
> > >>> +     return sprintf(buf, "%d\n", ret);
> > >>> +}
> > >>> +
> > >>> +static ssize_t
> > >>> +set_charge_current(struct device *dev, struct device_attribute=
 *attr,
> > >>> const char *buf, size_t count)
> > >>> +{
> > >>> +     unsigned long newCurrent;
> > >>> +     int ret;
> > >>> +
> > >>> +     ret =3D strict_strtoul(buf, 10, &newCurrent);
> > >>> +     if (ret)
> > >>> +             return -EINVAL;
> > >>> +
> > >>> +     ret =3D twl4030_i2c_write_u8(TWL4030_MODULE_MAIN_CHARGE, =
KEY_IIREF,
> > >>> REG_BCIMFKEY);
> > >>> +     if (ret)
> > >>> +             return ret;
> > >>> +
> > >>> +     ret =3D twl4030_i2c_write_u8(TWL4030_MODULE_MAIN_CHARGE, =
newCurrent
> &
> > >>> 0xff, REG_BCIIREF1);
> > >>> +     if (ret)
> > >>> +             return ret;
> > >>> +
> > >>> +     ret =3D twl4030_i2c_write_u8(TWL4030_MODULE_MAIN_CHARGE, =
KEY_IIREF,
> > >>> REG_BCIMFKEY);
> > >>> +     if (ret)
> > >>> +             return ret;
> > >>> +
> > >>> +     ret =3D twl4030_i2c_write_u8(TWL4030_MODULE_MAIN_CHARGE,
> (newCurrent >>
> > >>> 8) & 0x1, REG_BCIIREF2);
> > >>> +     if (ret)
> > >>> +             return ret;
> > >>> +
> > >>> +     /* Set software-controlled charge */
> > >>> +     twl4030charger_ac_en(ENABLE, 0);
> > >>> +
> > >>> +     /* Set CGAIN =3D 0 or 1 */
> > >>> +     if(newCurrent > 511) {
> > >>> +             u8 tmp;
> > >>> +
> > >>> +             /* Set CGAIN =3D 1 -- need to wait until automati=
c charge
> turns off */
> > >>> +             while(!ret) {
> > >>> +                     clear_n_set(TWL4030_MODULE_MAIN_CHARGE, 0=
, CGAIN
> | 0x1B,
> > >>> REG_BCICTL1);
> > >>> +                     twl4030_i2c_read_u8(TWL4030_MODULE_MAIN_C=
HARGE,
> &tmp, REG_BCICTL1);
> > >>> +
> > >>> +                     ret =3D tmp & CGAIN;
> > >>> +                     if(!ret)
> > >>> +                             mdelay(50);
> > >>> +             }
> > >>> +     } else {
> > >>> +             u8 tmp;
> > >>> +
> > >>> +             /* Set CGAIN =3D 0 -- need to wait until automati=
c charge
> turns off */
> > >>> +             while(!ret) {
> > >>> +                     clear_n_set(TWL4030_MODULE_MAIN_CHARGE, C=
GAIN,
> 0x1B, REG_BCICTL1);
> > >>> +                     twl4030_i2c_read_u8(TWL4030_MODULE_MAIN_C=
HARGE,
> &tmp, REG_BCICTL1);
> > >>> +
> > >>> +                     ret =3D !(tmp & CGAIN);
> > >>> +                     if(!ret)
> > >>> +                             mdelay(50);
> > >>> +             }
> > >>> +     }
> > >>> +
> > >>> +     /* Set automatic charge (CGAIN =3D 0/1 persists) */
> > >>> +     twl4030charger_ac_en(ENABLE, 1);
> > >>> +
> > >>> +     return count;
> > >>> +}
> > >>> +static DEVICE_ATTR(charge_current, S_IRUGO | S_IWUSR,
> > >>> show_charge_current, set_charge_current);
> > >>> +
> > >>>  static int twl4030_bk_bci_battery_get_property(struct power_su=
pply
> > >>> *psy,
> > >>>                                       enum power_supply_propert=
y psp,
> > >>>                                       union power_supply_propva=
l *val)
> > >>> @@ -912,8 +1055,6 @@
> > >>>       int irq;
> > >>>       int ret;
> > >>>
> > >>> -     therm_tbl =3D pdata->battery_tmp_tbl;
> > >>> -
> > >>>       di =3D kzalloc(sizeof(*di), GFP_KERNEL);
> > >>>       if (!di)
> > >>>               return -ENOMEM;
> > >>> @@ -937,8 +1078,12 @@
> > >>>       di->bk_bat.num_properties =3D
> ARRAY_SIZE(twl4030_bk_bci_battery_props);
> > >>>       di->bk_bat.get_property =3D twl4030_bk_bci_battery_get_pr=
operty;
> > >>>       di->bk_bat.external_power_changed =3D NULL;
> > >>> +     di->pdata =3D pdata;
> > >>>
> > >>> -     twl4030charger_ac_en(ENABLE);
> > >>> +     /* Set up clocks */
> > >>> +     twl4030_i2c_write_u8(TWL4030_MODULE_INTBR, MADC_HFCLK_EN =
|
> > >>> DEFAULT_MADC_CLK_EN, REG_GPBR1);
> > >>> +
> > >>> +     twl4030charger_ac_en(ENABLE, CHARGE_MODE);
> > >>>       twl4030charger_usb_en(ENABLE);
> > >>>       twl4030battery_hw_level_en(ENABLE);
> > >>>       twl4030battery_hw_presence_en(ENABLE);
> > >>> @@ -951,9 +1096,12 @@
> > >>>               goto temp_setup_fail;
> > >>>
> > >>>       /* enabling GPCH09 for read back battery voltage */
> > >>> -     ret =3D twl4030backupbatt_voltage_setup();
> > >>> -     if (ret)
> > >>> -             goto voltage_setup_fail;
> > >>> +     if(!di->pdata->no_backup_battery)
> > >>> +     {
> > >>> +             ret =3D twl4030backupbatt_voltage_setup();
> > >>> +             if (ret)
> > >>> +                     goto voltage_setup_fail;
> > >>> +     }
> > >>>
> > >>>       /* REVISIT do we need to request both IRQs ?? */
> > >>>
> > >>> @@ -988,9 +1136,18 @@
> > >>>                               twl4030_bci_battery_work);
> > >>>       schedule_delayed_work(&di->twl4030_bci_monitor_work, 0);
> > >>>
> > >>> -     ret =3D power_supply_register(&pdev->dev, &di->bk_bat);
> > >>> +     if(!pdata->no_backup_battery)
> > >>> +     {
> > >>> +             ret =3D power_supply_register(&pdev->dev, &di->bk=
_bat);
> > >>> +             if (ret) {
> > >>> +                     dev_dbg(&pdev->dev, "failed to register b=
ackup
> battery\n");
> > >>> +                     goto bk_batt_failed;
> > >>> +             }
> > >>> +     }
> > >>> +
> > >>> +     ret =3D device_create_file(di->bat.dev, &dev_attr_charge_=
current);
> > >>>       if (ret) {
> > >>> -             dev_dbg(&pdev->dev, "failed to register backup
> battery\n");
> > >>> +             dev_err(&pdev->dev, "failed to create sysfs entri=
es\n");
> > >>>               goto bk_batt_failed;
> > >>>       }
> > >>>
> > >>> @@ -1001,7 +1158,8 @@
> > >>>       return 0;
> > >>>
> > >>>  bk_batt_failed:
> > >>> -     power_supply_unregister(&di->bat);
> > >>> +     if(!pdata->no_backup_battery)
> > >>> +             power_supply_unregister(&di->bat);
> > >>>  batt_failed:
> > >>>       free_irq(irq, di);
> > >>>  chg_irq_fail:
> > >>> @@ -1010,7 +1168,7 @@
> > >>>  batt_irq_fail:
> > >>>  voltage_setup_fail:
> > >>>  temp_setup_fail:
> > >>> -     twl4030charger_ac_en(DISABLE);
> > >>> +     twl4030charger_ac_en(DISABLE, CHARGE_MODE);
> > >>>       twl4030charger_usb_en(DISABLE);
> > >>>       twl4030battery_hw_level_en(DISABLE);
> > >>>       twl4030battery_hw_presence_en(DISABLE);
> > >>> @@ -1024,7 +1182,7 @@
> > >>>       struct twl4030_bci_device_info *di =3D platform_get_drvda=
ta(pdev);
> > >>>       int irq;
> > >>>
> > >>> -     twl4030charger_ac_en(DISABLE);
> > >>> +     twl4030charger_ac_en(DISABLE, CHARGE_MODE);
> > >>>       twl4030charger_usb_en(DISABLE);
> > >>>       twl4030battery_hw_level_en(DISABLE);
> > >>>       twl4030battery_hw_presence_en(DISABLE);
> > >>> --- a/include/linux/i2c/twl4030.h
> > >>> +++ b/include/linux/i2c/twl4030.h
> > >>> @@ -299,6 +299,8 @@ int twl4030_i2c_read(u8 mod_no, u8 *value, =
u8 reg,
> > >>> unsigned num_bytes);
> > >>>  struct twl4030_bci_platform_data {
> > >>>       int *battery_tmp_tbl;
> > >>>       unsigned int tblsize;
> > >>> +
> > >>> +     bool no_backup_battery;
> > >>>  };
> > >>>
> > >>>  /* TWL4030_GPIO_MAX (18) GPIOs, with interrupts */
> > >>>
> > >>
> > >>
> > >
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
