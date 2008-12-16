From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: Issue: TWL4030-USB
Date: Wed, 17 Dec 2008 02:25:29 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087025127BDFE@dbde02.ent.ti.com>
References: <A24693684029E5489D1D202277BE894415E6E3C1@dlee02.ent.ti.com>
 <200812111524.57050.david-b@pacbell.net>
 <FCCFB4CDC6E5564B9182F639FC356087025127BDF7@dbde02.ent.ti.com>
 <200812161236.17658.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33928 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757937AbYLPUzg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Dec 2008 15:55:36 -0500
In-Reply-To: <200812161236.17658.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


>-----Original Message-----
>From: David Brownell [mailto:david-b@pacbell.net]
>Sent: Tuesday, December 16, 2008 2:36 PM
>To: Pandita, Vikram
>Cc: linux-omap@vger.kernel.org
>Subject: Re: Issue: TWL4030-USB
>
>On Tuesday 16 December 2008, Pandita, Vikram wrote:
>>
>> I have not been following much of the TWL4030 USB development.
>> I came across this code:
>>
>> <snip-start>
>> static int twl4030_set_peripheral(struct otg_transceiver *x,
>>                 struct usb_gadget *gadget)
>> {
>> ...
>> if (!gadget) {
>> >>>>>       omap_writew(0, OTG_IRQ_EN);
>> ...
>> <snip-end>
>>
>> This code will not work for OMAP3. There is no OHCI OTG block on OMAP3.
>
>Exactly why that code is removed in the latest code ... I don't
>see it in drivers/usb/otg/twl4030-usb.c do you?

I looked into: drivers/i2c/chips/twl4030-usb.c
Is this supposed to be removed then? 

>
>- Dave
>
>
>
>>
>>
>> Regards,
>> Vikram
>>
>>
>
>

