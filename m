From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC v2 0/7] OMAP4: mux: Add the OMAP4430 ES1 & ES2 support
Date: Wed, 20 Oct 2010 22:52:27 +0200
Message-ID: <4CBF568B.2010909@ti.com>
References: <1287526956-21853-1-git-send-email-b-cousson@ti.com> <20101019230642.GF3038@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41394 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753359Ab0JTUwc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Oct 2010 16:52:32 -0400
In-Reply-To: <20101019230642.GF3038@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>

Hi Tony,

On 10/20/2010 1:06 AM, Tony Lindgren wrote:
> * Benoit Cousson<b-cousson@ti.com>  [101019 15:14]:
>> Hi Tony,
>>
>> Upon Nishanth request, here is the updated version...
>>
>> It takes into account your proposal to store partition
>> information in a partition structure instead of inside every pad entries.
>> The mechanism relies on the uniqueness of the pad name in each partition to
>> find the correct partition during iteration.
>
> OK, using the offset defines won't be unique necessarily..

They should. The defines are all based on pad names that are all unique. 
Assuming HW folks didn't messed up the spec...

>
>> Removed as well some cpu_is_xxx calls from the core code by adding a couple of
>> flags during partition init.
>
> That's great.
>
>> Please note that due to low level access to mux api from the RX51 board code,
>> I have to disable the mux change to build properly with omap2plus_defconfig.
>> Look like you do have some idea to fix that :-)
>> I was thinking of:
>> - brute force approach that consist of keeping all the data after init, and
>> thus allowing removing the __init in the omap_mux_init_signal API
>> - or adding some flag in the pad entry to keep them after init .
>
> Well I was thinking we just register a board specific dynamic mux table
> and then call that when hitting retention or off and restore after that.
> Still need to think about that a bit more, I don't know if we want
> the automatic muxing of gpio pins still in addition to that.

OK, you were thinking of the MMC remux case only.
That might be enough for the moment, because the other needs I heard 
about does not seems to be in mainline anyway (USB or modem link).

>> Boot tested on SDP4430 with ES1.0&  ES2.0 with omap2plus_defconfig. Still require
>> some real driver to use that mux API in order to validate it.
>
> You can test by echoing wrong values after booting via /sys to
> mess up the MMC data lines and then type sync :)

I played with debugfs a little bit but was trying to avoid messing up 
with pins already used... in fact I should do the opposite. That's a 
nice technique...

>> The series is on top of lo/master (2.6.36-rc8) and is available here:
>> git://gitorious.org/omap-pm/linux.git ctrl-wip/mux-omap4-v2
>
> For pulling anything in, the git branches need to be based on something
> that's immutable. So preferrably v2.6.35 or some recent -rc tag
> in this case. Or rebase it on v2.6.36 after that's been released.

In that case only the ES1 can be there. ES2 support will be in 2.6.37 only.

That's why I have a dependency with lo/master. Do you want to split the 
series in two parts?

Thanks,
Benoit

