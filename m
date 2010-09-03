From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH] USB: otg: twl4030: fix phy initialization
Date: Fri, 3 Sep 2010 08:43:00 +0800
Message-ID: <AANLkTimts7SjE9EKrmsSkynWsQc_VtJUVVigrFs2VtrK@mail.gmail.com>
References: <1283443098-15262-1-git-send-email-tom.leiming@gmail.com>
	<ee6a42fe148f72518d475ff3838fc32a@secure211.sgcpanel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ee6a42fe148f72518d475ff3838fc32a@secure211.sgcpanel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: greg@kroah.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <felipe.balbi@nokia.com>, Anand Gadiyar <gadiyar@ti.com>, Mike Frysinger <vapier@gentoo.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>
List-Id: linux-omap@vger.kernel.org

2010/9/3 Felipe Balbi <me@felipebalbi.com>:
> Hi,

thanks for your comments.

>
> On Thu, =A02 Sep 2010 23:58:18 +0800, tom.leiming@gmail.com wrote:
>> From: Ming Lei <tom.leiming@gmail.com>
>>
>> Commit 461c317705eca5cac09a360f488715927fd0a927(into 2.6.36-v3)
>> is put forward to power down phy if no usb cable is connected,
>> but does introduce the two issues below:
>>
>> 1), phy is not into work state if usb cable is connected
>> with PC during poweron, so musb device mode is not usable
>> in such case, follows the reasons:
>
> I'm pretty sure I verified both cases.

Could you verify the beagle board in such case? If you commit is
reverted, no issue #1 for me.

>
>> =A0 =A0 =A0 -twl4030_phy_resume is not called, so
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 regulators are not enabled
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c access are not enabled
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb mode not configurated
>>
>> 2), The kernel warings[1] of regulators 'unbalanced disables'
>> is caused if poweron without usb cable connected
>> with PC or b-device.
>>
>> This patch fixes the two issues above:
>> =A0 =A0 =A0 -power down phy only if no usb cable is connected with P=
C
>> and b-device
>> =A0 =A0 =A0 -do phy initialization(via __twl4030_phy_resume) if usb =
cable
>> is connected with PC(vbus event) or another b-device(ID event) in
>> twl4030_usb_probe.
>>
>> This patch is verified OK on Beagle board either connected with
>> usb cable or not when poweron.
>
> I kinda doubt it, would have to test it myself, but I'm without
> enough gear to test it again.

See my analysis below.

>
>> [1]. warnings of 'unbalanced disables' of regulators.
>> [root@OMAP3EVM /]# dmesg
>> ------------[ cut here ]------------
>> WARNING: at drivers/regulator/core.c:1357
> _regulator_disable+0x38/0x128()
>
> this should not have been caused by that patch, though.

It is surely caused by usb twl4030 otg driver if otg phy is not power d=
own
in bootloader.

See my analysis  below.

>
>
>> Cc: Felipe Balbi <felipe.balbi@nokia.com>
>
> this email doesn't exist anymore... I'm yet to subscribe the new one,
> for now keep this one in Cc, sorry for that.
>
>> diff --git a/drivers/usb/otg/twl4030-usb.c
> b/drivers/usb/otg/twl4030-usb.c
>> index 05aaac1..df6381f 100644
>> --- a/drivers/usb/otg/twl4030-usb.c
>> +++ b/drivers/usb/otg/twl4030-usb.c
>> @@ -347,11 +347,22 @@ static void twl4030_i2c_access(struct twl4030_=
usb
>> *twl, int on)
>> =A0 =A0 =A0 }
>> =A0}
>>
>> -static void twl4030_phy_power(struct twl4030_usb *twl, int on)
>> +static void __twl4030_phy_power(struct twl4030_usb *twl, int on)
>> =A0{
>> + =A0 =A0 u8 old_pwr =3D twl4030_usb_read(twl, PHY_PWR_CTRL);
>> =A0 =A0 =A0 u8 pwr;
>>
>> - =A0 =A0 pwr =3D twl4030_usb_read(twl, PHY_PWR_CTRL);
>> + =A0 =A0 if (on)
>> + =A0 =A0 =A0 =A0 =A0 =A0 pwr =3D old_pwr & ~PHY_PWR_PHYPWD;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 pwr =3D old_pwr | PHY_PWR_PHYPWD;
>> +
>> + =A0 =A0 if (pwr !=3D old_pwr)
>> + =A0 =A0 =A0 =A0 =A0 =A0 WARN_ON(twl4030_usb_write_verify(twl, PHY_=
PWR_CTRL, pwr) < 0);
>
> writing 1 if register is one won't cause any problems, you're just
> wasting a variable.
>
>> +static void twl4030_phy_power(struct twl4030_usb *twl, int on)
>> +{
>> =A0 =A0 =A0 if (on) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 regulator_enable(twl->usb3v1);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 regulator_enable(twl->usb1v8);
>> @@ -365,15 +376,13 @@ static void twl4030_phy_power(struct twl4030_u=
sb
>> *twl, int on)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl_i2c_write_u8(TWL4030_MODULE_PM_RECEI=
VER, 0,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 VUSB_DEDICATED2);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 regulator_enable(twl->usb1v5);
>> - =A0 =A0 =A0 =A0 =A0 =A0 pwr &=3D ~PHY_PWR_PHYPWD;
>> - =A0 =A0 =A0 =A0 =A0 =A0 WARN_ON(twl4030_usb_write_verify(twl, PHY_=
PWR_CTRL, pwr) < 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 __twl4030_phy_power(twl, 1);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl4030_usb_write(twl, PHY_CLK_CTRL,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl4=
030_usb_read(twl, PHY_CLK_CTRL) |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (PHY_CLK_CTRL_CLOCKGATING_EN |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 PHY_CLK_CTRL_CLK32K_EN));
>> =A0 =A0 =A0 } else =A0{
>> - =A0 =A0 =A0 =A0 =A0 =A0 pwr |=3D PHY_PWR_PHYPWD;
>> - =A0 =A0 =A0 =A0 =A0 =A0 WARN_ON(twl4030_usb_write_verify(twl, PHY_=
PWR_CTRL, pwr) < 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 __twl4030_phy_power(twl, 0);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 regulator_disable(twl->usb1v5);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 regulator_disable(twl->usb1v8);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 regulator_disable(twl->usb3v1);
>> @@ -387,19 +396,25 @@ static void twl4030_phy_suspend(struct twl4030=
_usb
>> *twl, int controller_off)
>>
>> =A0 =A0 =A0 twl4030_phy_power(twl, 0);
>> =A0 =A0 =A0 twl->asleep =3D 1;
>> + =A0 =A0 dev_dbg(twl->dev, "%s\n", __func__);
>
> this is noise.

It is useful to troubleshoot the two issues above,  and I can
remove it if you doesn't like it.

>
>> =A0}
>>
>> -static void twl4030_phy_resume(struct twl4030_usb *twl)
>> +static void __twl4030_phy_resume(struct twl4030_usb *twl)
>> =A0{
>> - =A0 =A0 if (!twl->asleep)
>> - =A0 =A0 =A0 =A0 =A0 =A0 return;
>> -
>> =A0 =A0 =A0 twl4030_phy_power(twl, 1);
>> =A0 =A0 =A0 twl4030_i2c_access(twl, 1);
>> =A0 =A0 =A0 twl4030_usb_set_mode(twl, twl->usb_mode);
>> =A0 =A0 =A0 if (twl->usb_mode =3D=3D T2_USB_MODE_ULPI)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl4030_i2c_access(twl, 0);
>> +}
>> +
>> +static void twl4030_phy_resume(struct twl4030_usb *twl)
>> +{
>> + =A0 =A0 if (!twl->asleep)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 __twl4030_phy_resume(twl);
>> =A0 =A0 =A0 twl->asleep =3D 0;
>> + =A0 =A0 dev_dbg(twl->dev, "%s\n", __func__);
>
> this is noise.

see above.

>> @@ -502,6 +517,26 @@ static irqreturn_t twl4030_usb_irq(int irq, voi=
d
>> *_twl)
>> =A0 =A0 =A0 return IRQ_HANDLED;
>> =A0}
>>
>> +static void twl4030_usb_phy_init(struct twl4030_usb *twl)
>> +{
>> + =A0 =A0 int status;
>> +
>> + =A0 =A0 status =3D twl4030_usb_linkstat(twl);
>> + =A0 =A0 if (status >=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (status =3D=3D USB_EVENT_NONE) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __twl4030_phy_power(twl, 0=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl->asleep =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __twl4030_phy_resume(twl);
>
> this might break people who are using charger detection, although I
> would have to revisit some code to be sure.

twl4030_usb_phy_init is only called once from .probe, and I don't think
break chager detection, which in principle is same with vbus detect, ri=
ght?

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl->asleep =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 blocking_notifier_call_chain(&twl->otg.not=
ifier, status,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl->otg.g=
adget);
>> + =A0 =A0 }
>> + =A0 =A0 sysfs_notify(&twl->dev->kobj, NULL, "vbus");
>
> th=EDs should only be called from IRQ handler and is duplicating
> code.

=46or the 1st case, something is not same.

>
>> @@ -550,7 +585,6 @@ static int __devinit twl4030_usb_probe(struct
>> platform_device *pdev)
>> =A0 =A0 =A0 struct twl4030_usb_data *pdata =3D pdev->dev.platform_da=
ta;
>> =A0 =A0 =A0 struct twl4030_usb =A0 =A0 =A0*twl;
>> =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status, err;
>> - =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pwr;
>>
>> =A0 =A0 =A0 if (!pdata) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev, "platform_data not a=
vailable\n");
>> @@ -569,10 +603,7 @@ static int __devinit twl4030_usb_probe(struct
>> platform_device *pdev)
>> =A0 =A0 =A0 twl->otg.set_peripheral =3D twl4030_set_peripheral;
>> =A0 =A0 =A0 twl->otg.set_suspend =A0 =A0=3D twl4030_set_suspend;
>> =A0 =A0 =A0 twl->usb_mode =A0 =A0 =A0 =A0 =A0 =3D pdata->usb_mode;
>> -
>> - =A0 =A0 pwr =3D twl4030_usb_read(twl, PHY_PWR_CTRL);
>> -
>> - =A0 =A0 twl->asleep =A0 =A0 =A0 =A0 =A0 =A0 =3D (pwr & PHY_PWR_PHY=
PWD);
>> + =A0 =A0 twl->asleep =3D 1;
>
> and now you're lying to the driver again. What happens if
> bootloader has put transceiver to sleep ??

If bootloader has put transceiver to sleep, all is OK and the two
issues above will not happen. The patch is to fix the two issues if
bootloader did not power down phy.

issue #1:
         -twl->asleep is set as zero in .probe since bootloader has not
powerdown phy
         -EVENT_VBUS returned from twl4030_usb_linkstat since usb cable
is connected with PC
         -twl4030_phy_resume is called but does nothing since
twl->asleep is zero
         -the following are not called to initialize otg phy:
                  twl4030_phy_power / twl4030_i2c_access / twl4030_usb_=
set_mode
         -so musb device mode does not work

issue #2:
         -twl->asleep is set as zero in .probe since bootloader has
not powerdown phy
         -EVENT_NONE returned from twl4030_usb_linkstat since no usb ca=
ble is
connected with board
         -twl4030_phy_suspend is called
         -twl4030_phy_power is called since twl->asleep is zero
         -regulator_disable is called for power down case
         -so cause the kernel warning since no regulator_enable is call=
ed before

>
>> @@ -610,15 +641,10 @@ static int __devinit twl4030_usb_probe(struct
>> platform_device *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return status;
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 /* The IRQ handler just handles changes from the previous =
states
>> - =A0 =A0 =A0* of the ID and VBUS pins ... in probe() we must initia=
lize that
>> - =A0 =A0 =A0* previous state. =A0The easy way: =A0fake an IRQ.
>> - =A0 =A0 =A0*
>> - =A0 =A0 =A0* REVISIT: =A0a real IRQ might have happened already, i=
f PREEMPT is
>> - =A0 =A0 =A0* enabled. =A0Else the IRQ may not yet be configured or=
 enabled,
>> - =A0 =A0 =A0* because of scheduling delays.
>> + =A0 =A0 /* Power down phy or make it work according to
>> + =A0 =A0 =A0* current link state.
>
> if you're changing the comment you might as well fix the comment styl=
e.
>
>> =A0 =A0 =A0 =A0*/
>> - =A0 =A0 twl4030_usb_irq(twl->irq, twl);
>> + =A0 =A0 twl4030_usb_phy_init(twl);
>
> now I see, this doesn't care about that flag, so why even setting
> it above ??

You mean .asleep? If so, the flag is set to be consistent
with the actual link state.

--=20
Lei Ming
