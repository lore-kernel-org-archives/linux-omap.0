From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: mmc broken?
Date: Fri, 5 Dec 2008 17:01:32 -0800
Message-ID: <5e088bd90812051701i633bf4f6h887d95ce12014444@mail.gmail.com>
References: <5e088bd90812051631i35d541d7peedcae421bf23bc3@mail.gmail.com>
	 <20081206003432.GR9714@atomide.com>
	 <20081206004942.GS9714@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:42468 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754522AbYLFBBc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Dec 2008 20:01:32 -0500
Received: by rv-out-0506.google.com with SMTP id k40so244888rvb.1
        for <linux-omap@vger.kernel.org>; Fri, 05 Dec 2008 17:01:32 -0800 (PST)
In-Reply-To: <20081206004942.GS9714@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Dec 5, 2008 at 4:49 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Tony Lindgren <tony@atomide.com> [081205 16:34]:
>> * Steve Sakoman <sakoman@gmail.com> [081205 16:31]:
>> > I attempted an Overo build this afternoon with
>> > fb3d15c023ff08c879155db630895f38526b95f6.
>> >
>> > I set bootargs for rootfs on mmc.  The boot progresses normally and
>> > then hangs waiting for the rootfs to mount.
>> >
>> > Where I previously got:
>> >
>> >   Waiting for root device /dev/mmcblk0p2...
>> >   mmc0: host does not support reading read-only switch. assuming write-enable.
>> >   mmc0: new SD card at address ee21
>> >   mmcblk0: mmc0:ee21 SU02G 1.89 GiB
>> >    mmcblk0: p1 p2
>> >
>> > I now get:
>> >
>> >   Waiting for root device /dev/mmcblk0p2...
>> >
>> > Has anyone else seen mmc issues with rc7?
>>
>> I think I did it again while cleaning up.. Can you try this patch?
>> The name was conflicting with the other MMC omap driver.
>
> Actually now it breaks for earlier omaps, it  needs to be like this
> patch instead.

Heh, isn't that how it always goes!  Two steps forward, one step back :-)

I tested your first patch and it did indeed solve the issue.  Looks
like your second patch will also work.  I'll verify this later this
evening.

Steve
