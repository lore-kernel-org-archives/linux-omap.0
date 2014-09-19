From: Roger Quadros <rogerq@ti.com>
Subject: Re: OMAP3/AM3517 EHCI USB Issue
Date: Fri, 19 Sep 2014 12:48:55 +0300
Message-ID: <541BFC07.1070700@ti.com>
References: <20140728152948.GA28880@sysresccd>	<20140728155718.GF7667@saruman.home>	<20140728175739.GA29212@sysresccd>	<20140728181024.GI7667@saruman.home>	<53D7625B.3070301@ti.com>	<20140729152029.GA20542@sysresccd>	<53D8B4DA.906@ti.com>	<20140801230400.GA27785@sysresccd>	<CAO5Z=i3HF3BMVLamV9P1AOQh6rxyGuGz=Z5goG7w+o8iuNpv7A@mail.gmail.com>	<53DF5398.7000107@ti.com>	<20140804152754.GA12810@sysresccd>	<541BF5C7.3030201@ti.com> <CAOf5uwn4w6Ja7u0AwKzHtEhDkR7PcSaTa4JSXndhxkEgdqZ-_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40174 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753250AbaISJtR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Sep 2014 05:49:17 -0400
In-Reply-To: <CAOf5uwn4w6Ja7u0AwKzHtEhDkR7PcSaTa4JSXndhxkEgdqZ-_g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Michael Welling <mwelling@emacinc.com>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, gregkh@linuxfoundation.org, USB list <linux-usb@vger.kernel.org>, heikki.krogerus@linux.intel.com, chris.ruehl@gtsys.com.hk, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On 09/19/2014 12:37 PM, Michael Trimarchi wrote:
> Hi Roger
> 
> On Fri, Sep 19, 2014 at 11:22 AM, Roger Quadros <rogerq@ti.com> wrote:
>> Hi Michael,
>>

<snip>

>>>>>
>>>>> It should be noted that the external HUB must be prevented from autosuspend
>>>>> otherwise the resume fails.
>>>>
>>>> OK. I was able to reproduce the issue on my beagleboard as well. The key to reproduce the issue is to use a device which has autosuspend working. Earlier I was using a mass storage device so couldn't reproduce the issue. On using a HUB I could see the issue. Debugging this issue is on my action list.
>>>>
>>>
>>> I will keep an eye out for the fix if it is possible. The implementation of
>>> the remote resume workaround as listed in the sprz306d.pdf seems to hack
>>> into the core EHCI drivers and limits you to a single USB host.
>>>
>>
>> Please see Advisory 1.1.33 HSUSB Interoperability Issue with SMSC USB3320 PHY
>> (sprz306d errata doc).
>>
>> It seems ULPI suspend/resume is broken and there is no workaround. So you have to
>> prevent the USB device connected at root port from suspending.
>>
> 
> It's very important to understand if this affect even OMAP4 and
> tusb1210 that is suggested by TI.
> 

This particular issue was fixed in omap3630 ES1.1 onwards. But that doesn't mean OMAP4
is free of issues around USB EHCI. 4430 brought it's own set of issues which
were fixed in 4460. But there were still some issues requiring software workaround
especially around USB suspend/resume.

e.g. There is still an issue with both 4430 and 4460 called i701 
(USB Host - Possible Interoperability With External PHY At Resume Time)
which is observed on certain PHYs (at least not on usb3320).
There is a software workaround for that.

cheers,
-roger
