From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: BeagleBoard not resuming from uart with latest pm-core ?
Date: Thu, 11 Nov 2010 08:00:33 -0800
Message-ID: <87oc9vx332.fsf@deeprootsystems.com>
References: <20101110164414.4529cbda@surf>
	<AANLkTi=Dzv2XE-X_z6yiCaRjgWrST5QGDE9dFDnDy9pT@mail.gmail.com>
	<87pqudaxtm.fsf@deeprootsystems.com>
	<20101111114153.GP16966@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:44086 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753370Ab0KKQAh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Nov 2010 11:00:37 -0500
Received: by pxi15 with SMTP id 15so417132pxi.19
        for <linux-omap@vger.kernel.org>; Thu, 11 Nov 2010 08:00:36 -0800 (PST)
In-Reply-To: <20101111114153.GP16966@nokia.com> (Peter De Schrijver's message
	of "Thu, 11 Nov 2010 13:41:53 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com> writes:

> On Wed, Nov 10, 2010 at 06:32:53PM +0100, ext Kevin Hilman wrote:
>> Jean Pihet <jean.pihet@newoldbits.com> writes:
>> 
>> > l-o is currently broken wrt to suspend and idle.
>> > Solutions are being worked on for the moment.
>> >
>> > Kevin, are there solutions available yet?
>> 
>> The solution to your previous problem (ensuring runtime PM transitions
>> work during system PM) is included in my pm-core branch, but is not yet
>> the final solution.  I've been disussing this issue with the runtime PM
>> maintainers for a final solution.  Until then, I will carry this in
>> pm-core.
>> 
>> The other problem that I'm aware of so far I've only seen on boards with
>> UART2 console (beagle, Overo, n900.)  The printk messages that warn of
>
> N900 uses UART3 as its console... UART2 is bluetooth iirc.

You're right, beagle and Overo are also UART3, so s/UART2/UART3/ in my
above comment.

Kevin
