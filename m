From: Bob Liu <lliubbo@gmail.com>
Subject: Re: [PATCH] arm: omap3beagle: init musb default role by Kconfig
Date: Wed, 16 Feb 2011 10:07:26 +0800
Message-ID: <AANLkTik-tZKZ-0G1RBXD0rz1O4=wLXtHd2wTD-61dLm0@mail.gmail.com>
References: <1297760100-7200-1-git-send-email-lliubbo@gmail.com>
	<20110215112350.GM2570@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:47201 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932963Ab1BPCH0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Feb 2011 21:07:26 -0500
Received: by qwa26 with SMTP id 26so733896qwa.19
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 18:07:26 -0800 (PST)
In-Reply-To: <20110215112350.GM2570@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, archit@ti.com, tony@atomide.com, adrian.hunter@nokia.com

On Tue, Feb 15, 2011 at 7:23 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Tue, Feb 15, 2011 at 04:55:00PM +0800, Bob Liu wrote:
>> Currently musb is initialized to OTG mode by default in musb_board_data, it's
>> better to init it depending on Kconfig.
>
> what's the problem in always keeping OTG ? that board is wired for OTG
> anyway.
>

Yeah, but it's better if user can make their choices by themselves.
Or mask the other choices in Kconfig if keeping OTG.
Currently user can select HOST-only mode in Kconfig, but will receive
compiler error.
In my opinion, this should be consist.

Another problem is if keeping in OTG mode, my board can't recognize usb device.
HOST-only mode works fine, I am still debugging on it.
But I think it's not related with current topic.

Thanks
-- 
Regards,
--Bob
