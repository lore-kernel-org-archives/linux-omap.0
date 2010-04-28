From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: omap_musb_board_data -- trouble specifying 500mA supply
Date: Wed, 28 Apr 2010 20:23:04 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E2A5BE4@dbde02.ent.ti.com>
References: <r2of96d234e1004280710p91c1aa1cg41c1a1f96c7d461e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47918 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005Ab0D1OxK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Apr 2010 10:53:10 -0400
In-Reply-To: <r2of96d234e1004280710p91c1aa1cg41c1a1f96c7d461e@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cliff Brake <cliff.brake@gmail.com>, Linux OMAP Users <linux-omap@vger.kernel.org>

Hi,
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Cliff Brake
> Sent: Wednesday, April 28, 2010 7:40 PM
> To: Linux OMAP Users
> Subject: omap_musb_board_data -- trouble specifying 500mA supply
> 
> Hello,
> 
> We are designing a custom OMAP board that will have a 500mA supply on
> the OTG port.  It looks like the power is set with:
> 
> struct omap_musb_board_data {
> 	u8	interface_type;
> 	u8	mode;
> 	u8	power;
> };
> 
> However, with a u8, the max value is 255.  Should power be changed to a
> u16?

There is already a fix submitted and is available at Greg's queue,
http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/usb.current/musb-fix-power-field-to-hold-all-possible-values.patch

Ajay
> 
> Thanks,
> Cliff
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
