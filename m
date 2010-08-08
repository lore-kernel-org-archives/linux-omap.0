From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH 4/5] [omap1] Bluetooth device code common to HTC smartphones
Date: Sun, 8 Aug 2010 10:28:53 -0700
Message-ID: <AANLkTikGA9-TCM7v+_yivBYtxiX3ByJ7_ub1FOP0LgBO@mail.gmail.com>
References: <1280762976-17284-1-git-send-email-darkstar6262@gmail.com>
 <1280762976-17284-5-git-send-email-darkstar6262@gmail.com> <20100804101507.GG9881@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54893 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786Ab0HHR3O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Aug 2010 13:29:14 -0400
Received: by wwj40 with SMTP id 40so10824958wwj.1
        for <linux-omap@vger.kernel.org>; Sun, 08 Aug 2010 10:29:13 -0700 (PDT)
In-Reply-To: <20100804101507.GG9881@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Aug 4, 2010 at 3:15 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Cory Maccarrone <darkstar6262@gmail.com> [100802 18:23]:
>> This change adds in a bluetooth controld driver/rfkill
>> interface to the serial bluetooth controller found on many
>> HTC smartphones such as the HTC Herald and HTC Wizard.
>
> To me it looks like most of this should be in drivers/bluetooth/omap7xx.c
> or something like that. Then you can just pass it the gpio numbers in
> the platform_data.
>

Not sure I agree that it fits there.  The driver isn't really a
bluetooth driver -- it's really just an RFKILL interface, and some
code to toggle UART clocks on and off, plus GPIO work on a
board-specific level.  In principle, the gpios could be set and the
clocks enabled in the board files, and this driver wouldn't be
necessary to get working bluetooth (as we'd use hciattach on
/dev/ttyS*).  But then, we can't toggle it off for power saving.
Maybe a better place would be plat-omap/?  But it really is more
specific to these HTC boards, not the architecture itself.

So really, the only point of this driver is to be able to power on and
off the external bluetooth chip, which is why I submitted it as helper
code to the board files.

- Cory
