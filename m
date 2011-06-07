From: Kevin Hilman <khilman@ti.com>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Tue, 07 Jun 2011 15:34:50 -0700
Message-ID: <87pqmpl185.fsf@ti.com>
References: <Pine.LNX.4.44L0.1106021010360.1913-100000@iolanthe.rowland.org>
	<201106062029.36389.rjw@sisk.pl> <87zkluwqab.fsf@ti.com>
	<201106072332.30464.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:50737 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756995Ab1FGWey (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Jun 2011 18:34:54 -0400
Received: by pxi10 with SMTP id 10so3235266pxi.22
        for <linux-omap@vger.kernel.org>; Tue, 07 Jun 2011 15:34:53 -0700 (PDT)
In-Reply-To: <201106072332.30464.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Tue, 7 Jun 2011 23:32:30 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul@pwsan.com>

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Tuesday, June 07, 2011, Kevin Hilman wrote:
>> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
>> 
>> [..]
>> 
>> > While it is tempting to try to get away with only two PM callbacks per
>> > driver instead of four (or even more), it generally is not doable, simply
>> > because driver callbacks are not executed directly by the core.
>> >
>> > The only way to address the problem of code duplication between .suspend()
>> > and .runtime_suspend() callbacks (and analogously for resume) I see at the
>> > moment is to make those callbacks execute common routines.
>> 
>> Makes sense if the "common routines" are in the driver.  The problem
>> arises when the common routines are not actually in the driver, but are
>> instead at the subsystem (or in this case, device power domain) level.
>
> As Alan said, I'm not sure why that is a problem, because device power
> domain can (and most likely should) provide system suspend callbacks as well
> as runtime PM callbacks.  Those callbacks can be designed to do whatever is
> needed.

Yes, I see now.

For some reason, my runtime PM focus caused me to not consider the
system PM callbacks in the device power domains.  Taking care of things
there should solve my problems.

Sorry for being a bit blind,

Kevin
