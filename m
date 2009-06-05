From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: PM error: Powerdomain (core_pwddm) didn't enter target state 1
Date: Fri, 05 Jun 2009 10:49:41 -0700
Message-ID: <87tz2ua7uy.fsf@deeprootsystems.com>
References: <42B46BA8-AF35-42B5-9616-EADA31EF0553@mac.com>
	<87fxeebrsc.fsf@deeprootsystems.com>
	<277E4F10-4228-40C5-85C8-5B365B861DFF@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f202.google.com ([209.85.216.202]:60076 "EHLO
	mail-px0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756160AbZFERto (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 13:49:44 -0400
Received: by pxi40 with SMTP id 40so146066pxi.33
        for <linux-omap@vger.kernel.org>; Fri, 05 Jun 2009 10:49:46 -0700 (PDT)
In-Reply-To: <277E4F10-4228-40C5-85C8-5B365B861DFF@mac.com> (Elvis Dowson's message of "Fri\, 05 Jun 2009 21\:34\:29 +0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Users <linux-omap@vger.kernel.org>

Elvis Dowson <elvis.dowson@mac.com> writes:

> Hi Kevin,
>
> On Jun 5, 2009, at 7:53 PM, Kevin Hilman wrote:
>
>>>
>>
>> It's pretty difficult for me to know what you are actually running by
>> the description above.  You've taken a bunch of stuff, put them
>> together in some unspecified way, and are using an unspecified config.
>
> Sorry about that, I'm working on an android port to the gumstix overo
> earth platform. I'm trying to incorporate patches from the
> android-2.6.29 kernel, tomi's latest dss2 patches and your pm patches,
> to the linux-omap-2.6 master branch.

For initial PM debugging, I highly recommend something closer to what
others are developing and testing against.  Using the PM branch
patches on top of linux-omap master is not yet tested and validated,
so I can't give you any support there.

For example, you might start from the Android OMAP kernel which
is 2.6.29 based and includes the PM branch already.

  http://android.git.kernel.org/?p=kernel/omap.git

Then you'd just have to add your dss2 and Overo stuff there.

Kevin
