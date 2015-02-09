From: Bin Liu <binmlist@gmail.com>
Subject: Re: [PATCH 2/2] usb: musb: Fix getting a generic phy for musb_dsps
Date: Mon, 9 Feb 2015 13:02:56 -0600
Message-ID: <CADYTM3ZqmVmnWMsx+znfnwe5AownFgPKStO7t1VhKjpXZ1gJkA@mail.gmail.com>
References: <1423154113-23463-1-git-send-email-tony@atomide.com>
	<1423154113-23463-3-git-send-email-tony@atomide.com>
	<54D4BA78.9030704@ti.com>
	<20150206172313.GF25235@atomide.com>
	<CADYTM3brwenr4706Xqp91Vg7OVxT0CENy8aHhyzJ+vOGxxvRVw@mail.gmail.com>
	<20150209183922.GB2531@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:62606 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933756AbbBITC5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Feb 2015 14:02:57 -0500
In-Reply-To: <20150209183922.GB2531@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: George Cherian <george.cherian@ti.com>, Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>

On Mon, Feb 9, 2015 at 12:39 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Bin Liu <binmlist@gmail.com> [150206 10:21]:
>> Tony,
>>
>> On Fri, Feb 6, 2015 at 11:23 AM, Tony Lindgren <tony@atomide.com> wrote:
>> > * George Cherian <george.cherian@ti.com> [150206 05:05]:
>> >> Hi Tony,
>> >>
>> >> You also need to add similar things in dsps_musb_reset();
>> >>
>> >> Otherwise you might not recover from a BABBLE condition.
>> >
>> > Thank I totally missed that, updated patch below.
>> >
>> > Do you have some testcase that easily triggers BABBLE
>> > on MUSB?
>>
>> I normally just shorten DP or DM to VBUS to trigger babble. No device
>> is connected to the port, if I remembered correctly.
>
> Oh OK, that sounds a bit risky with 5V on the VBUS if a
> device is detected? I think I'll wait on that :)

Sorry, 'shorten' is not a good work for what I did. Just use a wire to
quickly touch DP or DM to VBUS, which pulls up DP/DM shortly, but long
enough to cross SOF to generate a babble.

Regards,
-Bin.

>
> Regards,
>
> Tony
