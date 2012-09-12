From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv8 00/23]I2C big cleanup
Date: Wed, 12 Sep 2012 16:08:20 -0700
Message-ID: <87wqzysuu3.fsf@deeprootsystems.com>
References: <1347447496-16793-1-git-send-email-shubhrajyoti@ti.com>
	<20120912131615.GB16547@pengutronix.de>
	<87pq5quaqr.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46613 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193Ab2ILXIV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Sep 2012 19:08:21 -0400
Received: by pbbrr13 with SMTP id rr13so3029956pbb.19
        for <linux-omap@vger.kernel.org>; Wed, 12 Sep 2012 16:08:21 -0700 (PDT)
In-Reply-To: <87pq5quaqr.fsf@deeprootsystems.com> (Kevin Hilman's message of
	"Wed, 12 Sep 2012 15:39:24 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com

Kevin Hilman <khilman@deeprootsystems.com> writes:

> Wolfram Sang <w.sang@pengutronix.de> writes:
>
>> On Wed, Sep 12, 2012 at 04:27:54PM +0530, Shubhrajyoti D wrote:
>
> [...]
>
>>> This is the cleanup only series.
>>>   
>>> Tested on omap4sdp and 3430sdp.
>>> 
>>> The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:
>>> 
>>>   Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)
>>> 
>>> are available in the git repository at:
>>>   git://gitorious.org/linus-tree/linus-tree.git for_3.7/i2c/big_cleanups
>>
>> Pushed to -next. Thanks to all involved!
>
> Sorry to be late to the party (again), but still catching up after some
> time off.
>
> Unfortunately, this series causes PM regressions on several OMAP
> platforms.  I hope we can hold off on this until those issues are
> addressed.

I tracked the regression down to [PATCHv8 21/22] (see reply there.)

Since this series is already merged, I suggest that the problem patch be
reverted, at least for v3.7 and until the problem is better understood
and tested.

With that patch reverted, all my PM tests are passing.  Feel free to
add:

Tested-by: Kevin Hilman <khilman@ti.com>

Kevin
