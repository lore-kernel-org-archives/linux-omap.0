From: Cliff Brake <cliff.brake@gmail.com>
Subject: Re: omap_musb_board_data -- trouble specifying 500mA supply
Date: Fri, 30 Apr 2010 17:14:10 -0400
Message-ID: <g2nf96d234e1004301414rb6e36c84la58820a28e1e12b4@mail.gmail.com>
References: <r2of96d234e1004280710p91c1aa1cg41c1a1f96c7d461e@mail.gmail.com>
	 <19F8576C6E063C45BE387C64729E7394044E2A5BE4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63797 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754191Ab0D3VOM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 17:14:12 -0400
Received: by wye20 with SMTP id 20so516121wye.19
        for <linux-omap@vger.kernel.org>; Fri, 30 Apr 2010 14:14:11 -0700 (PDT)
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044E2A5BE4@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: Linux OMAP Users <linux-omap@vger.kernel.org>

On Wed, Apr 28, 2010 at 10:53 AM, Gupta, Ajay Kumar <ajay.gupta@ti.com>=
 wrote:
> Hi,
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Cliff Brake
>> Sent: Wednesday, April 28, 2010 7:40 PM
>> To: Linux OMAP Users
>> Subject: omap_musb_board_data -- trouble specifying 500mA supply
>>
>> Hello,
>>
>> We are designing a custom OMAP board that will have a 500mA supply o=
n
>> the OTG port. =A0It looks like the power is set with:
>>
>> struct omap_musb_board_data {
>> =A0 =A0 =A0 u8 =A0 =A0 =A0interface_type;
>> =A0 =A0 =A0 u8 =A0 =A0 =A0mode;
>> =A0 =A0 =A0 u8 =A0 =A0 =A0power;
>> };
>>
>> However, with a u8, the max value is 255. =A0Should power be changed=
 to a
>> u16?
>
> There is already a fix submitted and is available at Greg's queue,
> http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patch=
es/usb.current/musb-fix-power-field-to-hold-all-possible-values.patch

I'm also having trouble figuring out the correct way to convince the
OTG system not to use the internal phy VBUS power supply.  Are there
any examples of a board config that does this?  Perhaps the AM35xx,
etc?

Thanks,
Cliff
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
