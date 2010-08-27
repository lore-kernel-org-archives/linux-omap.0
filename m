From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH 1/2] USB: musb-gadget: enable autoclear for OUT transfer
 in both DMA 0 and DMA 1
Date: Fri, 27 Aug 2010 23:26:14 +0800
Message-ID: <AANLkTimTJW6gA8uUqq6WN3iOsxZDSWfHbKn_PP1uMtEg@mail.gmail.com>
References: <1282920723-12459-1-git-send-email-tom.leiming@gmail.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0328C1CB91@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62849 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754263Ab0H0P0Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Aug 2010 11:26:16 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0328C1CB91@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "greg@kroah.com" <greg@kroah.com>, "dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Mike Frysinger <vapier@gentoo.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

2010/8/27 Gadiyar, Anand <gadiyar@ti.com>:
> tom.leiming@gmail.com wrote:
>>
>> From: Ming Lei <tom.leiming@gmail.com>
>>
>> This patch fixes one bugs of OUT transfer in double buffer case:
>>
>> -the current code only enable autoclear for dma mode 1, and not
>> for dma mode 0
>>
>> Without this patch, test #5 of usbtest can't be passed if we
>> configure musb as g_zero and use fifo mode 3 to enable double
>> buffer mode.
>>
>> With this patch and the following patch(fix dma length),
>> on my beagle B5, test#5(queued bulk out) may go beyond
>> 18Mbyte/s(seems dma mode 0 is quicker in double buffer case)
>> if musb is configured as g_zero and fifo mode 3 is taken, follows
>> the test command:
>>
>> =A0 =A0 #./testusb -D DEV_NAME -c 1024 -t 5 -s 32768 -g 8 =A0 [1]
>>
>> Also I have tested this patch can't make g_ether broken.
>>
>> [1],
>> =A0 =A0 -source of testusb : tools/usb/testusb.c under linux kernel;
>>
>> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
>> Cc: Anand Gadiyar <gadiyar@ti.com>
>> Cc: Mike Frysinger <vapier@gentoo.org>
>> Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>
> I'm not 100% sure why not having autoclear was causing a failure
> with double-buffering enabled. I'd like this patch to be tested
> more on OMAP as well as on Blackfin/Davinci.

We don't clear MUSB_RXCSR_RXPKTRDY explicitly when dma complete,
so if autoclear is not enabled, the dma read for packets from fifo will
not be acked, then any odd things may happen...

I have tested the patch for both single buffer and double buffer case,
test #5 and test #6 are passed, and result of test #5 in double buffer
may go beyond 18M/s(seems much quicker than dma mode 1).

Also, g_ether is OK with the patch.

>
> I'll need time to study MUSB specs again to understand this,
> so I'll skip acking this patch and let Felipe/Sergei/Mike/Ajay
> take a look.

Very good.

>
> Thanks for taking the time to debug this - if this patch series
> makes double buffering work reliably, that's a very good boost
> to throughput.

>
> - Anand
>
>> ---
>> =A0drivers/usb/musb/musb_gadget.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_=
gadget.c
>> index e0bd1c1..c0dfec4 100644
>> --- a/drivers/usb/musb/musb_gadget.c
>> +++ b/drivers/usb/musb/musb_gadget.c
>> @@ -645,9 +645,9 @@ static void rxstate(struct musb *musb, struct mu=
sb_request *req)
>> =A0 =A0 =A0 =A0*/
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 csr |=3D=
 MUSB_RXCSR_DMAENAB;
>> -#ifdef USE_MODE1
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!mus=
b_ep->hb_mult)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 csr |=3D MUSB_RXCSR_AUTOCLEAR;
>> +#ifdef USE_MODE1
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* csr |=
=3D MUSB_RXCSR_DMAMODE; */
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* this =
special sequence (enabling and then
>> --
>> 1.6.2.5
>>
>>



--=20
Lei Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
