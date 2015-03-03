From: Bin Liu <binmlist@gmail.com>
Subject: Re: am335x: USB DMA IRQ issue
Date: Tue, 3 Mar 2015 13:30:47 -0600
Message-ID: <CADYTM3axvy1owDt_2Cg4fKyrqS1ASdyczGhK1DVJjdnjgH8K8g@mail.gmail.com>
References: <CAGm1_ktamp-L8nb7UzGvha6EkEfAnDtv3unPE1th9RjK7RkG1g@mail.gmail.com>
	<20150224163612.GA25042@saruman.tx.rr.com>
	<CAGm1_kubHLEA=wbJ81iHeJ9shnUSjdE4H7L=VYORyMiUH2sLsQ@mail.gmail.com>
	<20150228215746.GA10010@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:33656 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbbCCTas (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Mar 2015 14:30:48 -0500
Received: by igbhl2 with SMTP id hl2so28285913igb.0
        for <linux-omap@vger.kernel.org>; Tue, 03 Mar 2015 11:30:48 -0800 (PST)
In-Reply-To: <20150228215746.GA10010@saruman.tx.rr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Yegor Yefremov <yegorslists@googlemail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sat, Feb 28, 2015 at 3:57 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Sat, Feb 28, 2015 at 10:39:49PM +0100, Yegor Yefremov wrote:
>> On Tue, Feb 24, 2015 at 5:36 PM, Felipe Balbi <balbi@ti.com> wrote:
>> > Hi,
>> >
>> > On Thu, Feb 05, 2015 at 12:19:23PM +0100, Yegor Yefremov wrote:
>> >> I have a problem with my am335x based board and USB.
>> >>
>> >> Kernel: Linux version 3.18.1 (YegorYefremov@development1) (gcc version
>> >> 4.9.2 (Buildroot 2015.02-git-00797-gf1b07c0) ) #1 SMP Thu Jan 15
>> >> 15:31:27 CET 2015
>> >>
>> >> I took two devices and equipped them with USB WLAN cards: Bus 001
>> >> Device 003: ID 148f:5370 Ralink Technology, Corp. RT5370 Wireless
>> >> Adapter. One device as AP and another as client. Client makes
>> >> permanent ping to AP. And from time to time I start nuttcp session.
>> >> After 2-3 days I get following errors:
>> >
>> > 2-3 days ? oh man... :-)
>> >
>> > Here's one thing to try. Can you do some variable size pingtest ?
>> > Something like below should do ?
>> >
>> > random()
>> > {
>> >         size=$(dd if=/dev/urandom count=1 2>/dev/null|cksum|
>> >         cut -f1 -d" "|tr '-' '\0')
>> >         size=$(expr $size % 60000)
>> > }
>> >
>> > num=$1
>> >
>> > if [ -z $num ]
>> > then
>> >         num=10000
>> > fi
>> >
>> > while ! ifconfig usb0 >/dev/null 2>&1; do
>> >         printf "waiting for usb0\n"
>> >         sleep 1;
>> > done
>> >
>> > ifconfig usb0 192.168.2.14
>> >
>> > for i in $(seq 1 $num); do
>> >         random
>> >         printf "%d: \t pinging with size %-27d" $i $size
>> >         if ! ping -c 6 192.168.2.15 -s $size -q -i 0 >/dev/null 2>&1; then
>> >                 printf "FAILED\n"
>> >                 break
>> >         fi
>> >         printf "PASSED\n"
>> > done
>>
>> Still haven't tried your test, but have seen this interesting
>> patch/proposal http://e2e.ti.com/support/arm/sitara_arm/f/791/t/404743.
>> Seems to be somehow related.
>
> patch makes sense. If you can make sure it really solves your problem
> then send it as a proper patch on top of my testing/next, I'd be glad.

FYI, the patch is posted here
http://marc.info/?l=linux-usb&m=142526223500889&w=2.

>
> At some point, I'll just split dma callback into dedicated rx and tx
> callbacks to avoid confusion in the future.
>
> --
> balbi
