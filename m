From: "Dasgupta, Romit" <romit@ti.com>
Subject: RE: USB driver issue
Date: Wed, 30 Jul 2008 18:28:35 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593013C880208@dbde02.ent.ti.com>
References: <35fa40850807300459k2558dddak8768318e87a1ab58@mail.gmail.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB02568EAC5C@dbde02.ent.ti.com>
 <35fa40850807300520k221ccf7epc8727ef9a437b5d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44606 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756172AbYG3M7O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jul 2008 08:59:14 -0400
In-Reply-To: <35fa40850807300520k221ccf7epc8727ef9a437b5d5@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: SUBHRANIL CHOUDHURY <subhra85@gmail.com>, "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

What is the application you are using and could you turn the musb driver debug options? You can try it by

echo "D 3"  > /proc/driver/musb_hdrc  (Check if MUSB_DEBUG is enabled).

This should give more helpful messages.



>-----Original Message-----
>From: linux-omap-open-source-bounces@linux.omap.com [mailto:linux-omap-open-
>source-bounces@linux.omap.com] On Behalf Of SUBHRANIL CHOUDHURY
>Sent: Wednesday, July 30, 2008 5:50 PM
>To: Gadiyar, Anand
>Cc: linux-omap-open-source@linux.omap.com
>Subject: Re: USB driver issue
>
>hi,
>I am using Mistral OMAP3430 OSK2.1 board. It is the USB OTG port.
>The Philips tranciever ISP1504.
>I am enabling the EHCI and OHCI in the kernel menuconfig.
>
>This was the error print i was getting:
>
>Unable to handle kernel NULL pointer dereference at virtual address 00000000
>pgd = c54d8000
>[00000000] *pgd=81401031, *pte=00000000, *ppte=00000000
>Internal error: Oops: 817 [#1]
>Modules linked in:
>CPU: 0    Not tainted  (2.6.22.18-omap3 #29)
>PC is at consistent_sync+0x40/0xa4
>LR is at usb_hcd_submit_urb+0x7b0/0x8b4
>pc : [<c00315ac>]    lr : [<c02307e0>]    psr: 20000013
>sp : c1403c48  ip : c1403c58  fp : c1403c54
>r10: ffff8003  r9 : 00000020  r8 : 00000020
>r7 : c483dc20  r6 : c0569000  r5 : c23c040c  r4 : ff2d2000
>r3 : 00000000  r2 : 00000002  r1 : ff2dba38  r0 : ff2d2000
>Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  Segment user
>Control: 00c5387f  Table: 854d8018  DAC: 00000015
>
>Do you get some clue from this about what is happening?
>
>
>
>
>On Wed, Jul 30, 2008 at 5:35 PM, Gadiyar, Anand <gadiyar@ti.com> wrote:
>
>> > Hi all,
>> > I am trying to validate the USB driver on OMAP3430 with the
>> > 2.6.22.18kernel. I am facing problems in the process while trying to
>> > do a USB transfer with DMA enabled.
>> > The apllication is breaking in a function called
>> > consistent_sync. The error message is like "Unable to handle kernel Null
>> pointer".
>>
>> Which board are you using? Which is the USB port - EHCI/OHCI/OTG?
>>
>> Assuming it is the USB OTG port (because that is the only one where you
>> can enable or disable DMA), what is the transceiver being used on the port?
>>
>>
>> > The issue is same with both OHCI and EHCI controller. And the
>> > issue is not coming if i disable DMA.
>>
>> I don't think you have control over DMA disabling with the OHCI/EHCI
>> controller. Are you sure you are using the OHCI/EHCI controller?
>>
>> The "Unable to handle kernel Null pointer" message comes with some more
>> data.
>> We won't be able to help you out without the rest of the log, but the
>> answers to
>> questions above are essential before we move on to this.
>>
>> >
>> > Has anyone tried USB packet transfer with DMA enabled? Please
>> > let me know.
>> >
>> > Regards,
>> > Subhro
>>
>_______________________________________________
>Linux-omap-open-source mailing list
>Linux-omap-open-source@linux.omap.com
>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
