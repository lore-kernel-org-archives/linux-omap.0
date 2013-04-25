From: Kevin Hilman <khilman@linaro.org>
Subject: Re: Multiple issues with omap4 panda es in linux next
Date: Thu, 25 Apr 2013 06:58:19 -0700
Message-ID: <87obd21zlw.fsf@linaro.org>
References: <20130419171318.GK10155@atomide.com> <517181B2.9070302@ti.com>
	<20130419174454.GM10155@atomide.com> <517184A2.9020908@ti.com>
	<20130419181825.GN10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:34979 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758712Ab3DYN6X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Apr 2013 09:58:23 -0400
Received: by mail-pd0-f179.google.com with SMTP id x11so1821981pdj.38
        for <linux-omap@vger.kernel.org>; Thu, 25 Apr 2013 06:58:22 -0700 (PDT)
In-Reply-To: <20130419181825.GN10155@atomide.com> (Tony Lindgren's message of
	"Fri, 19 Apr 2013 11:18:26 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Luciano Coelho <coelho@ti.com>, Roger Quadros <rogerq@ti.com>, linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>, Ravi Babu <ravibabu@ti.com>, Ruslan Bilovol <ruslan.bilovol@ti.com>

Tony Lindgren <tony@atomide.com> writes:

> * Santosh Shilimkar <santosh.shilimkar@ti.com> [130419 10:56]:
>> On Friday 19 April 2013 11:14 PM, Tony Lindgren wrote:
>> > * Santosh Shilimkar <santosh.shilimkar@ti.com> [130419 10:43]:
>> >> On Friday 19 April 2013 10:43 PM, Tony Lindgren wrote:
>> >>> Hi all,
>> >>>
>> >>> Here's a list of breakage I've noticed so far while trying to
>> >>> use linux next on my pandaboard es. Probably similar issues exist
>> >>> on other boards as well.
>> >>>
>> >>> Ideally we would not have any breakage by the merge window, so
>> >>> let's try to get these fixed ASAP:
>> >>>
>> >>> 1. Serial console broken on panda es booting with DT
>> >>>
>> >>> The symptoms are dmesg output stopping after few lines
>> >>> and only continuing after pressing a key. Does not seem to
>> >>> happen on blaze with DT for some reason. And does not happen
>> >>> on panda es with legacy booting.
>> >>>
>> >> This one is known and reported on list along with fix patches and
>> >> later pull request [1].
>> >>
>> >> Unfortunately with all the testing and everything and patches have
>> >> been on the list for quite some time, feedback on one of the patch
>> >> received was after pull request and then there was no further
>> >> clarification. That series address the same exact issue you have
>> >> mentioned above.
>> > 
>> > OK thanks. I think Paul picked some of those and the plan was
>> > to update the branch? Which one(s) should go into v3.10 as fixes?
>> > 
>> Main in that series was to handle driver sysc handling withing hwmod
>> layer and that is where the series got stuck [2]. Without that support
>> other patches won't fix the issue.
>
> OK it seems that that is still ongoing discussion. For v3.10 we should
> probably just disable PM for omap4 for DT booting so people can use
> it for DT related development.

Disabling PM (and even avoiding WFI using 'nohlt') will not fix this
problem, since it's related to the idle-mode of the IP block itself.

What fixes the problem is the series from Santosh for the SYSC removal.

Santosh, it seems that series combined a fix for this problem with some
cleanup of the hwmod code that Paul had some concerns with.  Is there
any chance you can split up that series into a fix targetted at the
DT-boot UART problem and a feature cleanup for hwmod?

Then we hopefully get this fix into v3.10-rc and work on the hwmod
changes/cleanup for the following merge window.

Kevin

