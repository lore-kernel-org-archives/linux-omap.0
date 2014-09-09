From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [resend PATCH 0/3] Add DRA7xx CPSW Ethernet support in Device
 Tree
Date: Tue, 9 Sep 2014 18:26:36 +0530
Message-ID: <540EF904.5070701@ti.com>
References: <1410203998-8700-1-git-send-email-mugunthanvnm@ti.com>	<20140908193440.GC12150@kahuna>	<540EE4B0.70207@ti.com> <CAGo_u6riiMVTW2y1qZWdJ2QUVdxX7uZyaTO3tRTGivX8Pjni1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48262 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbaIIM4m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2014 08:56:42 -0400
In-Reply-To: <CAGo_u6riiMVTW2y1qZWdJ2QUVdxX7uZyaTO3tRTGivX8Pjni1w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, dt list <devicetree@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

On Tuesday 09 September 2014 05:45 PM, Nishanth Menon wrote:
> On Tue, Sep 9, 2014 at 6:29 AM, Mugunthan V N <mugunthanvnm@ti.com> wrote:
>>
>>> Sorry this is now blocked inside TI. could you explain the testing done
>>> for sleep state? did you attempt sleep mode before testing this?
>>>
>>
>> I have not tested sleep mode, just tested boot and ping test.
> 
> I must NAK then for the reason that this is a patch that is just build
> tested and is not tested for the feature it claims to introduce.
> 
> 

Is suspend/resume supported in mainline, i was not able to test it.

root@dra7xx-evm:~# echo mem > /sys/power/state
-sh: echo: write error: Invalid argument

I was not able to use rtc wake also as the rtc device is not created.

Regards
Mugunthan V N

