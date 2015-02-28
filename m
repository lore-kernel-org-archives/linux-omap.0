From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: am335x: USB DMA IRQ issue
Date: Sat, 28 Feb 2015 22:39:49 +0100
Message-ID: <CAGm1_kubHLEA=wbJ81iHeJ9shnUSjdE4H7L=VYORyMiUH2sLsQ@mail.gmail.com>
References: <CAGm1_ktamp-L8nb7UzGvha6EkEfAnDtv3unPE1th9RjK7RkG1g@mail.gmail.com>
 <20150224163612.GA25042@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:44776 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390AbbB1VkK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 28 Feb 2015 16:40:10 -0500
Received: by padbj1 with SMTP id bj1so6470077pad.11
        for <linux-omap@vger.kernel.org>; Sat, 28 Feb 2015 13:40:10 -0800 (PST)
In-Reply-To: <20150224163612.GA25042@saruman.tx.rr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Feb 24, 2015 at 5:36 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Thu, Feb 05, 2015 at 12:19:23PM +0100, Yegor Yefremov wrote:
>> I have a problem with my am335x based board and USB.
>>
>> Kernel: Linux version 3.18.1 (YegorYefremov@development1) (gcc version
>> 4.9.2 (Buildroot 2015.02-git-00797-gf1b07c0) ) #1 SMP Thu Jan 15
>> 15:31:27 CET 2015
>>
>> I took two devices and equipped them with USB WLAN cards: Bus 001
>> Device 003: ID 148f:5370 Ralink Technology, Corp. RT5370 Wireless
>> Adapter. One device as AP and another as client. Client makes
>> permanent ping to AP. And from time to time I start nuttcp session.
>> After 2-3 days I get following errors:
>
> 2-3 days ? oh man... :-)
>
> Here's one thing to try. Can you do some variable size pingtest ?
> Something like below should do ?
>
> random()
> {
>         size=$(dd if=/dev/urandom count=1 2>/dev/null|cksum|
>         cut -f1 -d" "|tr '-' '\0')
>         size=$(expr $size % 60000)
> }
>
> num=$1
>
> if [ -z $num ]
> then
>         num=10000
> fi
>
> while ! ifconfig usb0 >/dev/null 2>&1; do
>         printf "waiting for usb0\n"
>         sleep 1;
> done
>
> ifconfig usb0 192.168.2.14
>
> for i in $(seq 1 $num); do
>         random
>         printf "%d: \t pinging with size %-27d" $i $size
>         if ! ping -c 6 192.168.2.15 -s $size -q -i 0 >/dev/null 2>&1; then
>                 printf "FAILED\n"
>                 break
>         fi
>         printf "PASSED\n"
> done

Still haven't tried your test, but have seen this interesting
patch/proposal http://e2e.ti.com/support/arm/sitara_arm/f/791/t/404743.
Seems to be somehow related.

Yegor
