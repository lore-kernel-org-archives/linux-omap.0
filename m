From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] MUSB: Remove usb_musb_pm_init() call
Date: Mon, 24 Aug 2009 15:34:33 +0300
Message-ID: <874orxqtk6.fsf@deeprootsystems.com>
References: <1251115597-23096-1-git-send-email-gadiyar@ti.com>
	<87d46lqu2w.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0309E9CF4A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:59408 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380AbZHXMef (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Aug 2009 08:34:35 -0400
Received: by fg-out-1718.google.com with SMTP id e21so487787fga.17
        for <linux-omap@vger.kernel.org>; Mon, 24 Aug 2009 05:34:36 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0309E9CF4A@dbde02.ent.ti.com> (Anand Gadiyar's message of "Mon\, 24 Aug 2009 17\:56\:01 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Gadiyar, Anand" <gadiyar@ti.com> writes:

>> > MUSB: Remove usb_musb_pm_init() call
>> >
>> > In usb_musb_pm_init, we attempt to access an MUSB register
>> > when the i-clock may not be on, or the module is otherwise
>> > not accessible.
>> >
>> > We need to either:
>> > - enable the clock before this access, or
>> > - remove this code and move it to the bootloader, or
>> > - enable the clock in the bootloader
>> >
>> > If we enable the clock in the bootloader, we might as well
>> > add the workaround in the bootloader itself. This code will
>> > anyway be changed once hwmod is in place, so remove it for now
>> >
>> > This allows us to boot the kernel on certain OMAP3 boards with
>> > a bootloader that doesn't enable this clock. Without this, we
>> > will need to upgrade the bootloaders on these boards.
>> >
>> > Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
>> 
>> NAK.
>> 
>> The PM branch already has a fix from Jon Hunter[1] for this which enables
>> the clock, and in the thread where we discussed this I mentioned I would
>> carry it in the PM branch until the hwmod for OTG is ready.
>
> Right, but at least merge this into master and mainline for now,
> so that boards that used to boot up okay before can continue to do so now.
>
> Not everybody is working on the pm branch.

ok, I understand now.  Was thinking you meant this for the PM branch.
Sorry for the confusion.

I'll pull this into my fixes queue for the next merge window.

Thanks,

Kevin

