From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: Help wanted with USB and OMAP3 off_mode
Date: Wed, 09 Jan 2013 11:24:09 +0100
Message-ID: <50ED4549.6080802@amarulasolutions.com>
References: <20130109092915.1c2077b5@notabene.brown> <50ED3FA5.9030905@compulab.co.il> <20130109211931.0e00db5d@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:42855 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755352Ab3AIKYR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jan 2013 05:24:17 -0500
Received: by mail-la0-f45.google.com with SMTP id ep20so1669242lab.32
        for <linux-omap@vger.kernel.org>; Wed, 09 Jan 2013 02:24:16 -0800 (PST)
In-Reply-To: <20130109211931.0e00db5d@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Igor Grinberg <grinberg@compulab.co.il>, linux-omap@vger.kernel.org

Hi Neil

On 01/09/2013 11:19 AM, NeilBrown wrote:
> On Wed, 09 Jan 2013 12:00:05 +0200 Igor Grinberg <grinberg@compulab.c=
o.il>
> wrote:
>=20
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>=20
>> Hi Neil,
>=20
>> On 01/09/13 00:29, NeilBrown wrote:
>>>
>>> Hi,
>>>  I'm trying to get off_mode working reliably on my gta04 mobile pho=
ne.
>>>
>>> My current stumbling block is USB.  The "Option" GSM module is atta=
ched via
>>> USB (there is a separate transceiver chip attached to port 1 which =
is placed
>>> in OMAP_EHCI_PORT_MODE_PHY).
>=20
>> Which PHY is this (vendor/model)?
>=20
> Hi Igor,
>   it is the SMSC USB3322
>=20
> http://www.smsc.com/media/Downloads_Public/Data_Sheets/3320.pdf
>=20
>=20
> BTW I subsequently discovered that keeping USBHOST out off off_mode o=
nly
> sometimes avoid the problem, not always.  So there are probably multi=
ple
> issues :-(

Are you sure that you don't have glitch on power, reset pin during susp=
end?

Michael

>=20
> NeilBrown
>=20
>=20
>=20
>=20
>>>
>>> After a suspend/resume cycle with off_mode enabled the GSM module d=
isappears.
>>> i.e. 'lsusb' doesn't see it any more and the various ttyHSxx device=
s don't
>>> exist.
>>> Without off mode, the modem always appears after resume.
>>>
>>> I discovered that the registers set by:
>>>
>>>    drivers/mfd/omap-usb-host.c
>>>
>>> are not maintained across as suspend/resume so I added the followin=
g patch
>>> (which I can make a formal submission of if it looks right to other=
s), but
>>> that didn't help (or didn't help enough).
>>>
>>> If I
>>>
>>>   echo 1 > /sys/kernel/debug/pm_debug/usbhost_pwrdm/suspend
>>>
>>> thus keeping just the USBHOST power domain out of off_mode, the GSM=
 module
>>> doesn't disappear.  So it seems that some context in the usbhost do=
main is
>>> not being save and restored.
>>>
>>> This is as far as I can get.  Can someone suggest where I should lo=
ok to find
>>> out what is not being saved/restored properly, and how to go about =
saving and
>>> restoring?
>>>
>>> Thanks in advance,
>>> NeilBrown
>>>
>>>
>>>
>>> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-hos=
t.c
>>> index 23cec57..522405e 100644
>>> --- a/drivers/mfd/omap-usb-host.c
>>> +++ b/drivers/mfd/omap-usb-host.c
>>> @@ -100,6 +100,10 @@ struct usbhs_hcd_omap {
>>> =20
>>>  	void __iomem			*uhh_base;
>>> =20
>>> +	struct {
>>> +		unsigned		hostconfig;
>>> +	} context;
>>> +
>>>  	struct usbhs_omap_platform_data	platdata;
>>> =20
>>>  	u32				usbhs_rev;
>>> @@ -300,6 +304,10 @@ static int usbhs_runtime_resume(struct device =
*dev)
>>>  	clk_enable(omap->utmi_p1_fck);
>>>  	clk_enable(omap->utmi_p2_fck);
>>> =20
>>> +	usbhs_write(omap->uhh_base,
>>> +		    OMAP_UHH_HOSTCONFIG,
>>> +		    omap->context.hostconfig);
>>> +
>>>  	spin_unlock_irqrestore(&omap->lock, flags);
>>> =20
>>>  	return 0;
>>> @@ -319,6 +327,8 @@ static int usbhs_runtime_suspend(struct device =
*dev)
>>>  	}
>>> =20
>>>  	spin_lock_irqsave(&omap->lock, flags);
>>> +	omap->context.hostconfig =3D usbhs_read(omap->uhh_base,
>>> +					      OMAP_UHH_HOSTCONFIG);
>>> =20
>>>  	if (is_ehci_tll_mode(pdata->port_mode[0]))
>>>  		clk_disable(omap->usbhost_p1_fck);
>=20
>> - --=20
>> Regards,
>> Igor.
>>=20

> N=8B=A7=B2=E6=ECr=B8=9By=FA=E8=9A=D8b=B2X=AC=B6=C7=A7v=D8^=96)=DE=BA{=
=2En=C7+=89=B7=A5=8A{=B1=A2f=A9=8A{ay=BA=1D=CA=87=DA=99=EB,j=07=AD=A2f=A3=
=A2=B7h=9A=8B=E0z=B9=1E=AEw=A5=A2=B8=0C=A2=B7=A6j:+v=89=A8=8Aw=E8j=D8m=B6=
=9F=FF=BE=07=AB=91=EA=E7zZ+=83=F9=9A=8E=8A=DD=A2j"=9D=FA!tml=3D
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
