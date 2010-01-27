From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v5] OMAP UART: Add omap-serial driver support.
Date: Wed, 27 Jan 2010 11:10:56 -0800
Message-ID: <87aavzuzwf.fsf@deeprootsystems.com>
References: <63111.192.168.10.88.1264586216.squirrel@dbdmail.itg.ti.com>
	<20100127172526.GB23505@atomide.com>
	<87y6jjwi9e.fsf@deeprootsystems.com>
	<20100127175737.GD23505@atomide.com>
	<87iqanwhe4.fsf@deeprootsystems.com>
	<20100127181850.GE23505@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f215.google.com ([209.85.220.215]:58990 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932163Ab0A0TLC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jan 2010 14:11:02 -0500
Received: by fxm7 with SMTP id 7so3006925fxm.28
        for <linux-omap@vger.kernel.org>; Wed, 27 Jan 2010 11:11:01 -0800 (PST)
In-Reply-To: <20100127181850.GE23505@atomide.com> (Tony Lindgren's message of "Wed\, 27 Jan 2010 10\:18\:50 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@deeprootsystems.com> [100127 10:05]:
>> Tony Lindgren <tony@atomide.com> writes:
>> 
>> > * Kevin Hilman <khilman@deeprootsystems.com> [100127 09:46]:
>> >> Tony Lindgren <tony@atomide.com> writes:
>> >> 
>> >> [...]
>> >> 
>> >> >
>> >> > Do you have the board related patches somewhere so people can
>> >> > actually test this driver?
>> >> >
>> >> 
>> >> Tony, the board/platform related patches are in my pm-wip/uart branch
>> >> as part of the conversion of that code to hwmod/omap_device.
>> >> 
>> >> This patch on top of that branch is working fine, at least for
>> >> basic console.
>> >
>> > OK. What's the dependency to the PM branch with these UART
>> > patches?
>> 
>> The driver itself has no dependencies.
>> 
>> But the platform changes and conversion to hwmod/omap_device have all
>> been done on top of the PM branch + various ongoing hwmod/omap_device
>> patches.
>
> Sounds like we should do all the hwmod conversion patches against the
> mainline nowadays to cut down the dependencies. If there are some
> dependencies still to PM branch, those should be patched away ASAP.

Agreed, and already done.  I'm collecting the various hwmod,
omap_device conversion patches floating around and have them in a
branch of my PM tree based on mainline.

However, so far I have only been testing them when combined with the
rest of the PM branch.

> Adding new device drivers should not have any dependencies except
> the mainline kernel :)

In general that's true.  But for all new drivers, I think we need to
require that they use hwmod + omap_device so we don't have to do that
part twice.  Since the hwmod + omap_device stuff has a little ways to
go, there will be some out-of-tree dependencies.

Kevin

