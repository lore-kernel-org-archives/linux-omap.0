From: Kevin Hilman <khilman@ti.com>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Wed, 15 Jun 2011 18:17:46 -0700
Message-ID: <87boxytw05.fsf@ti.com>
References: <Pine.LNX.4.44L0.1106111227580.3439-100000@netrider.rowland.org>
	<201106120046.36618.rjw@sisk.pl> <87fwna3gnb.fsf@ti.com>
	<201106160201.47123.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:44025 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752908Ab1FPBRu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Jun 2011 21:17:50 -0400
Received: by mail-iw0-f169.google.com with SMTP id 8so814282iwg.28
        for <linux-omap@vger.kernel.org>; Wed, 15 Jun 2011 18:17:49 -0700 (PDT)
In-Reply-To: <201106160201.47123.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Thu, 16 Jun 2011 02:01:46 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul@pwsan.com>

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Wednesday, June 15, 2011, Kevin Hilman wrote:

[...]

>>
>> From a device driver perspective, system PM is just runtime
>> PM where the "idleness" was forced and only a subset of possible wakeup
>> sources are enabled.
>
> Oh well, I wonder how much of a difference would make you think those things
> are really different. ;-)

Seeing a description of the differences would help.  So far the list is
rather short: wakeups and forcibly quieting the hardware.

I guess I still don't see why system PM cannot be viewed as a special
case of runtime PM, so how about a specific question: From a device
driver perspective, how is system PM anything other than
manually/forcibly creating the right conditions for a runtime PM
transition to happen?

[...]

>> The development effort is primarily
>> focused on implementing efficient runtime PM for an _active_ system.
>> When this is working, implementing system PM is easy: all that is needed
>> is to enable/disable relevant wakeups and force the device to idle.
>> This allows runtime PM to trigger, and the device is suspended.
>
> No, it doesn't.  What you're trying to do is to "maunally" trigger runtime PM

No.  

What I'm trying to do in .suspend() is create the conditions necessary
such that a runtime PM transition will occur *by itself*.  If the right
conditions exist (namely, idle HW, no pending activity, etc.) a runtime
PM transition will happen *on its own*, and will not need to be manually
triggered.  IOW, a runtime PM transition is a side effect of creating
the right idle conditions.

> when _you_ think is suitable.

No, only when a system suspend is requested by the user.

Kevin
