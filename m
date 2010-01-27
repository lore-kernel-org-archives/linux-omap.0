From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v5] OMAP UART: Add omap-serial driver support.
Date: Wed, 27 Jan 2010 10:07:47 -0800
Message-ID: <87iqanwhe4.fsf@deeprootsystems.com>
References: <63111.192.168.10.88.1264586216.squirrel@dbdmail.itg.ti.com>
	<20100127172526.GB23505@atomide.com>
	<87y6jjwi9e.fsf@deeprootsystems.com>
	<20100127175737.GD23505@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f182.google.com ([209.85.216.182]:36139 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755296Ab0A0SHu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jan 2010 13:07:50 -0500
Received: by pxi12 with SMTP id 12so4585844pxi.33
        for <linux-omap@vger.kernel.org>; Wed, 27 Jan 2010 10:07:49 -0800 (PST)
In-Reply-To: <20100127175737.GD23505@atomide.com> (Tony Lindgren's message of "Wed\, 27 Jan 2010 09\:57\:37 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@deeprootsystems.com> [100127 09:46]:
>> Tony Lindgren <tony@atomide.com> writes:
>> 
>> [...]
>> 
>> >
>> > Do you have the board related patches somewhere so people can
>> > actually test this driver?
>> >
>> 
>> Tony, the board/platform related patches are in my pm-wip/uart branch
>> as part of the conversion of that code to hwmod/omap_device.
>> 
>> This patch on top of that branch is working fine, at least for
>> basic console.
>
> OK. What's the dependency to the PM branch with these UART
> patches?

The driver itself has no dependencies.

But the platform changes and conversion to hwmod/omap_device have all
been done on top of the PM branch + various ongoing hwmod/omap_device
patches.

Kevin
