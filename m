From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH] omap3_beagle: Init only uart3 used for console
Date: Tue, 6 Mar 2012 10:10:13 +0100
Message-ID: <C67C8239-2E17-42E5-BEB4-2B7F623515B8@dominion.thruhere.net>
References: <1330945952-14714-1-git-send-email-govindraj.raja@ti.com> <12976EFB-912D-44E2-825C-63034F117635@dominion.thruhere.net> <CAMrsUdJfSeu8W+gS+HfDKw5WFXvaVK2TzXhqhr6tdRhujU18uQ@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:51100 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173Ab2CFJKR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Mar 2012 04:10:17 -0500
Received: by wibhm2 with SMTP id hm2so2474679wib.19
        for <linux-omap@vger.kernel.org>; Tue, 06 Mar 2012 01:10:16 -0800 (PST)
In-Reply-To: <CAMrsUdJfSeu8W+gS+HfDKw5WFXvaVK2TzXhqhr6tdRhujU18uQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Raja, Govindraj" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Robert Nelson <robertcnelson@gmail.com>, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>


Op 6 mrt. 2012, om 10:03 heeft Raja, Govindraj het volgende geschreven:

> On Mon, Mar 5, 2012 at 7:36 PM, Koen Kooi <koen@dominion.thruhere.net> wrote:
>> 
>> Op 5 mrt. 2012, om 12:12 heeft Govindraj.R het volgende geschreven:
>> 
>>> From: "Govindraj.R" <govindraj.raja@ti.com>
>>> 
>>> On beagle some of uart mux lines are used for other
>>> purpose so init only uart3.
>>> 
>>> Uart2 rx line clashes with gpio_147 used for usb ehci
>>> phy reset. Initializing uart2 pad_mux lines can break
>>> ehci module on beagle xm.
>>> (gpio_147 is available on uart2_rx in mode4 reference
>>> mux34xx.c -> uart2_rx.gpio_147)
>> 
>> That's only on xM revision C, right?
> 
> Applicable to all beagle boards having external usb
> hub (USB2HS_nRST will require uart2_rx.gpio_147)

My apologies, I was confusing it with the DVI reset GPIO (which changed in between revisions) and the polarity of the USB pin (which changed during xM A -> C).

regards,

Koen