From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: [PATCH] omap3_beagle: Init only uart3 used for console
Date: Tue, 6 Mar 2012 14:33:16 +0530
Message-ID: <CAMrsUdJfSeu8W+gS+HfDKw5WFXvaVK2TzXhqhr6tdRhujU18uQ@mail.gmail.com>
References: <1330945952-14714-1-git-send-email-govindraj.raja@ti.com> <12976EFB-912D-44E2-825C-63034F117635@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:40908 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758822Ab2CFJDh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Mar 2012 04:03:37 -0500
Received: by mail-tul01m020-f180.google.com with SMTP id wd18so7382110obb.11
        for <linux-omap@vger.kernel.org>; Tue, 06 Mar 2012 01:03:36 -0800 (PST)
In-Reply-To: <12976EFB-912D-44E2-825C-63034F117635@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Robert Nelson <robertcnelson@gmail.com>, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>

On Mon, Mar 5, 2012 at 7:36 PM, Koen Kooi <koen@dominion.thruhere.net> wrote:
>
> Op 5 mrt. 2012, om 12:12 heeft Govindraj.R het volgende geschreven:
>
>> From: "Govindraj.R" <govindraj.raja@ti.com>
>>
>> On beagle some of uart mux lines are used for other
>> purpose so init only uart3.
>>
>> Uart2 rx line clashes with gpio_147 used for usb ehci
>> phy reset. Initializing uart2 pad_mux lines can break
>> ehci module on beagle xm.
>> (gpio_147 is available on uart2_rx in mode4 reference
>> mux34xx.c -> uart2_rx.gpio_147)
>
> That's only on xM revision C, right?

Applicable to all beagle boards having external usb
hub (USB2HS_nRST will require uart2_rx.gpio_147)

Beagle Rev Ax/Bx doesn't seem to have external hub
module so not applicable for those boards

Will modify and post a new patch.

--
Thanks,
Govindraj.R
