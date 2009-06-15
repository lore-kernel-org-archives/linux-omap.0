From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/3] OMAP3:WDT:Enable support for IVA and SECURE
Date: Mon, 15 Jun 2009 09:26:17 -0700
Message-ID: <8763exa2fq.fsf@deeprootsystems.com>
References: <1244495293-17244-1-git-send-email-ubh@ti.com>
	<1244495293-17244-2-git-send-email-ubh@ti.com>
	<1244495293-17244-3-git-send-email-ubh@ti.com>
	<87prddzcp5.fsf@deeprootsystems.com>
	<00695C9C8F8B4448856F48142B4AA201BD76FE9E@dnce02.ent.ti.com>
	<87ljo1w1u7.fsf@deeprootsystems.com>
	<00695C9C8F8B4448856F48142B4AA201BD868426@dnce02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:53509 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760976AbZFOQ0R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Jun 2009 12:26:17 -0400
Received: by pxi27 with SMTP id 27so325908pxi.33
        for <linux-omap@vger.kernel.org>; Mon, 15 Jun 2009 09:26:19 -0700 (PDT)
In-Reply-To: <00695C9C8F8B4448856F48142B4AA201BD868426@dnce02.ent.ti.com> (Ulrik Bech Hald's message of "Mon\, 15 Jun 2009 18\:19\:11 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hald, Ulrik Bech" <ubh@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Hald, Ulrik Bech" <ubh@ti.com> writes:

[...]

>> >>
>> >> Again, red flag: cpu_is_*
>> >>
>> >> It might be more consistent to use pdev->dev->name which is already of
>> >> the form "watchdog.%d".
>> >
>> > Not sure I follow. I don't see a "name" field in struct device, only
>> init_name.
>> 
>> Sorry, I meant dev->bus_id.  Look at dev_set_name() which creates
>> a bus_id of the form ("%s.%d", pdev->name, pdev->id)
>
> As far as I can see, dev->bus_id has been removed from the device
> struct as per 1fa5ae857bb14f6046205171d98506d8112dd74e.
> Furthermore, the pdev->name is "omap_wdt", which should be presented
> as "watchdog" in wdev->omap_wdt_miscdev.name anyway, so I think I'll
> just go with the sprintf() approach below, keeping your wdt_name
> comments in mind.

OK

Kevin
