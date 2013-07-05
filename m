From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH 4/5] usb: musb: dsps: use proper child nodes
Date: Fri, 5 Jul 2013 17:22:02 +0200
Message-ID: <CAFqH_51dW_GEx8mROjj-rGQ9D7RgrJhN2GJQfQAQ8wbj7n-0DQ@mail.gmail.com>
References: <1373031178-8871-1-git-send-email-bigeasy@linutronix.de>
	<1373031178-8871-5-git-send-email-bigeasy@linutronix.de>
	<CAFqH_529D9rEJJ2rk3jGm0aGt4ZXBpP=R3azAKUxyp9vA-Nf4Q@mail.gmail.com>
	<51D6E2FB.3040303@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:63608 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757352Ab3GEPWF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jul 2013 11:22:05 -0400
In-Reply-To: <51D6E2FB.3040303@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Felipe Balbi <balbi@ti.com>, george.cherian@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, b-cousson@ti.com

2013/7/5 Sebastian Andrzej Siewior <bigeasy@linutronix.de>:
> On 07/05/2013 05:08 PM, Enric Balletbo Serra wrote:
>> Hi Sebastian,
>
> Hi Enric,
>
>> I'm trying to test these patches but I've problems, I've following error,
>>
>> [   10.096492] musb-dsps 47400000.usb: failed to get memory for instance 0
>> [   10.103481] musb-dsps 47400000.usb: failed to create child pdev
>>
>> I'm missing something ?
>
> This is printed if you don't have the memory for the child device. Did
> you update your device tree?
>
Fixed, I didn't update my DT for my custom board properly. Thanks.

>>
>> Thanks in advance,
>>      Enric
>
> Sebastian
