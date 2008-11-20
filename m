From: "Sudipta GHOSH" <sudipta.in@gmail.com>
Subject: Re: omap display controller strange problem
Date: Thu, 20 Nov 2008 17:59:28 +0200
Message-ID: <9e6474ae0811200759n40ad3d29y51d55f31b203c6fa@mail.gmail.com>
References: <9e6474ae0811200718t52b99d76m2e738254de770765@mail.gmail.com>
	 <19F8576C6E063C45BE387C64729E739403E8E67B9A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.185]:42296 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754915AbYKTP7h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Nov 2008 10:59:37 -0500
Received: by gv-out-0910.google.com with SMTP id e6so141705gvc.37
        for <linux-omap@vger.kernel.org>; Thu, 20 Nov 2008 07:59:35 -0800 (PST)
In-Reply-To: <19F8576C6E063C45BE387C64729E739403E8E67B9A@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

thanks for the reply.

in my board, there is a sharp lcd display.
We are using RFBI. and manual update.

So after configuraing dispc, rfbi, sharp from omapfb_do_probe

calling fbdev->ext_if->transfer_area(240,320,omapfb_cb,fbdev); return 0;

I see linux logo and debug prints but after some boot time prints, it
stop refresing the display.
I mean I cant see any more prints. (I have few prints in key press).

But if I use printk("omap_irqH\n"); in omap_dispc_irq_handler. I saw
all prints coming including key press.
I mean if I use that printk then display is working.

let me know if you need any more info.

Regards,
-SG



2008/11/20 Hiremath, Vaibhav <hvaibhav@ti.com>:
>
>
> Thanks,
> Vaibhav Hiremath
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Sudipta GHOSH
>> Sent: Thursday, November 20, 2008 8:48 PM
>> To: linux-omap@vger.kernel.org
>> Subject: omap display controller strange problem
>>
>> Hi,
>>
>> I am facing a strange problem with omap display controller. (kernel
>> 2.6.25)
>>
>> in omap_dispc_irq_handler, if I use printk then only display is
>> working (initialization and refreshing)
>>
> [Hiremath, Vaibhav] What do you mean by "only display"?
>
> Can you please provide detailed information about the issue? Your mail doesn't convey much.
>
>> else after few refresh ......its stop working.
>>
>> static irqreturn_t omap_dispc_irq_handler(int irq, void *dev)
>> {
>>       ....................
>>
>>       if ((stat & dispc.enabled_irqs) && dispc.irq_callback) {
>>               printk("omap_irqH\n"); <--------------------------------
>> -------- ?????
>>               dispc.irq_callback(dispc.irq_callback_data);
>>       }
>>
>>
>> Regards,
>> -SG
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-
>> omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
