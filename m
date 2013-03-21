From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv2 5/7] usb: phy: twl4030-usb: check if vbus is driven by
 twl itself
Date: Thu, 21 Mar 2013 15:42:46 +0200
Message-ID: <CANOLnOOS6X95ijodL903zqLn3emNZ-rDX0xrxYQUXFJ1PR-PZw@mail.gmail.com>
References: <1363544607-17634-1-git-send-email-notasas@gmail.com>
	<1363544607-17634-6-git-send-email-notasas@gmail.com>
	<20130320130750.GR29659@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130320130750.GR29659-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>, kishon <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 20, 2013 at 3:07 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> On Sun, Mar 17, 2013 at 08:23:25PM +0200, Grazvydas Ignotas wrote:
>> At least on pandora, STS_VBUS gets set even when VBUS is driven by t=
wl
>> itself. Reporting VBUS in this case confuses OMAP musb glue and char=
ger
>> driver, so check if OTG VBUS charge pump is on before reporting VBUS
>> event to avoid this problem.
>>
>> Signed-off-by: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/usb/phy/phy-twl4030-usb.c |   36 ++++++++++++++++++++++++++=
+++++-----
>>  1 file changed, 31 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/usb/phy/phy-twl4030-usb.c b/drivers/usb/phy/phy=
-twl4030-usb.c
>> index 425c18a..87bf11d 100644
>> --- a/drivers/usb/phy/phy-twl4030-usb.c
>> +++ b/drivers/usb/phy/phy-twl4030-usb.c
>> @@ -248,11 +248,31 @@ twl4030_usb_clear_bits(struct twl4030_usb *twl=
, u8 reg, u8 bits)
>>
>>  /*-----------------------------------------------------------------=
--------*/
>>
>> +static bool twl4030_is_driving_vbus(struct twl4030_usb *twl)
>> +{
>> +     int ret;
>> +
>> +     ret =3D twl4030_usb_read(twl, PHY_CLK_CTRL_STS);
>> +     if (ret < 0 || !(ret & PHY_DPLL_CLK))
>> +             /*
>> +              * if clocks are off, registers are not updated,
>> +              * but we can assume we don't drive VBUS in this case
>> +              */
>> +             return false;
>> +
>> +     ret =3D twl4030_usb_read(twl, ULPI_OTG_CTRL);
>> +     if (ret < 0)
>> +             return false;
>> +
>> +     return (ret & (ULPI_OTG_DRVVBUS | ULPI_OTG_CHRGVBUS)) ? true :=
 false;
>> +}
>> +
>>  static enum omap_musb_vbus_id_status
>>       twl4030_usb_linkstat(struct twl4030_usb *twl)
>>  {
>>       int     status;
>>       enum omap_musb_vbus_id_status linkstat =3D OMAP_MUSB_UNKNOWN;
>> +     bool    driving_vbus =3D false;
>>
>>       twl->vbus_supplied =3D false;
>>
>> @@ -270,20 +290,26 @@ static enum omap_musb_vbus_id_status
>>       if (status < 0)
>>               dev_err(twl->dev, "USB link status err %d\n", status);
>>       else if (status & (BIT(7) | BIT(2))) {
>> -             if (status & (BIT(7)))
>> -                        twl->vbus_supplied =3D true;
>> +             if (status & BIT(7)) {
>> +                     driving_vbus =3D twl4030_is_driving_vbus(twl);
>> +                     if (driving_vbus)
>
> how about just:
>
> if (twl4030_is_driving_vbus(twl))
>         status &=3D ~BIT(7);
>
> ????

I'm logging driving_vbus below with dev_dbg(), so that it's easier to
see what going on..

>
> --
> balbi

--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
