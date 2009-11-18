From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 5/8] OMAP: omap_device: add usecounting
Date: Wed, 18 Nov 2009 06:33:04 -0800
Message-ID: <87tywrewdb.fsf@deeprootsystems.com>
References: <1258506313-17115-1-git-send-email-khilman@deeprootsystems.com>
	<1258506313-17115-2-git-send-email-khilman@deeprootsystems.com>
	<1258506313-17115-3-git-send-email-khilman@deeprootsystems.com>
	<1258506313-17115-4-git-send-email-khilman@deeprootsystems.com>
	<1258506313-17115-5-git-send-email-khilman@deeprootsystems.com>
	<1258506313-17115-6-git-send-email-khilman@deeprootsystems.com>
	<alpine.DEB.2.00.0911180349590.25515@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:53182 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757242AbZKROdB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 09:33:01 -0500
Received: by pzk1 with SMTP id 1so829831pzk.33
        for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2009 06:33:07 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0911180349590.25515@utopia.booyaka.com> (Paul Walmsley's message of "Wed\, 18 Nov 2009 03\:51\:10 -0700 \(MST\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> Hello Kevin,
>
> On Tue, 17 Nov 2009, Kevin Hilman wrote:
>
>> Add use counters to omap_device to enable multiple potential users of
>> an omap_device.  This is needed if ever there are multiple users or
>> multiple instances of a driver with a single omap_device.
>> 
>> Without usecounting, with multiple users, the first one to call idle
>> may forcibly idle the device while other users are still active.
>
> Could you please send along an example of the use case for this?  

The current use case is the serial driver (not yet ready for posting.)

While there is only a single driver bound to the omap_device, there
are effectivily multiple instances of the driver.  One for initial
init/probe requriring and early _enable, followed by _idle in the
late_init hook.  Another when the actual serial driver gets started
and the inactivity timers etc. start firing.  These usages overlap
slightly and the easiest way I saw to handle this was with
usecounting.

> I would prefer not to add usecounting at this layer unless it is
> absolutely necessary, since only one driver should be bound to a
> device at a time.

What about mulitple instances of the same driver?

Or, what about drivers like i2c which might do _enable/_idle on a
per-transfer basis and there might be multiple transfers pending at
any given time.

We already have use-counting in the clock framework for this same
purpose.  I'm essentially proposing the usecounting for the same reason,
but it also need to protect enable/idle parts of hwmod as well.

Maybe usecounting at the hwmod level is more appropriate since that's
where the problem lies.  I'm fine with that.

Kevin
