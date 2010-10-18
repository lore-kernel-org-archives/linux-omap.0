From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC 0/5] OMAP4: mux: Add the OMAP4430 ES1 support
Date: Tue, 19 Oct 2010 01:12:37 +0200
Message-ID: <4CBCD465.4070306@ti.com>
References: <1285319748-28976-1-git-send-email-b-cousson@ti.com> <7A436F7769CA33409C6B44B358BFFF0C014FAB2762@dlee02.ent.ti.com> <4CBCB35E.9080502@ti.com> <20101018230013.GI13341@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37092 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757886Ab0JRXMk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Oct 2010 19:12:40 -0400
In-Reply-To: <20101018230013.GI13341@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tony,

On 10/19/2010 1:00 AM, Tony Lindgren wrote:
> * Cousson, Benoit<b-cousson@ti.com>  [101018 13:42]:
>> Hi Nishanth,
>>
>> On 10/18/2010 8:09 PM, Menon, Nishanth wrote:
>>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>>>> owner@vger.kernel.org] On Behalf Of Benoit Cousson
>>>>
>>> Ping? Is there a possibility for a v2 non-rfc ES2 support?
>>
>> And what about a RFC v2? With ES2 support of course :-)
>>
>> The changes I have done are breaking RX51 support due to the usage
>> of low-level API from the mux code.
>>
>> For the moment I just disabled that code from the RX51, so there is
>> no way I send that except in a RFC form :-(
>
> I have some ideas on doing the board specific runtime remuxing.
> That should also solve the rx51 emmc remuxing.

That's cool, I had some poor ideas as well, but I was not sure you will 
like them :-)

> Let's plan on merging your patches first after the merge window,
> then I'll do my patches on top of yours to avoid rebasing.

Great, I'll send that when I will have the time to test that on an ES2.0 
at least...

Just FYI, the wip code is there:
git://gitorious.org/omap-pm/linux.git ctrl-wip/mux-omap4-v2

Thanks,
Benoit

