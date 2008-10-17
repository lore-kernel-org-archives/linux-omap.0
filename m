From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 0/4] bq27x00 updates
Date: Sat, 18 Oct 2008 01:40:06 +0400
Message-ID: <20081017214006.GA5455@oksana.dev.rtsoft.ru>
References: <1224277248-17021-1-git-send-email-felipe.balbi@nokia.com>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:12793 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752894AbYJQVkJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Oct 2008 17:40:09 -0400
Content-Disposition: inline
In-Reply-To: <1224277248-17021-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, Anton Vorontsov <cbou@mail.ru>, David Woodhouse <dwmw2@infradead.org>

Hi Felipe,

On Sat, Oct 18, 2008 at 12:00:44AM +0300, Felipe Balbi wrote:
> The previous driver for bq27x00 batteries was a real
> ifdef mess. The following patches separate common code
> and create separate drivers for bq27200 and bq27000.
> 
> The code looks much cleaner, but we had to keep a global
> static pointer to hold the i2c_client (bq27200) or the
> w1 device (bq27000).
> 
> If anyone has a better solution, I'd like to hear since
> keeping that global pointer doesn't look nice.
> 
> I could only test bq27200 final driver, I don't have
> hw for testing bq27000 so I'd like to ask anyone who
> has such hw, please test it.
> 
> I'd say that after the following patches we can already
> send both drivers to mainline since they look quite
> fine now. Improvements might come later, but for now, they
> look fine.
> 
> David and Anton, I'm Ccing you guys for you to take a look
> at the drivers before I send the final version (against mainline)
> to you for integration. It would be nice if you guys could take
> a look at the patches and if something looks wrong we could fix
> it and get the drivers in better shape before asking bugging lkml
> with such drivers.

At first glance, the patches look ideal. I'll try to review them
more carefully tomorrow.

One thing though: we can't delete the old driver now. I'm about
to send a pull request to Linus. Though I think we can hurry up and
merge the new driver for 2.6.28, but delete the old one in 2.6.29.

This means that you might want to redo the patches this way:

> Felipe Balbi (4):
>   power_supply: bq27x00: separate common code

This one should include its own Kconfig/Makefile entries.

>   power_supply: bq27200: separate bq27200-specific driver

Ditto.

>   power_supply: bq27200: separate bq27000-specific driver

Ditto.

>   power_supply: bq27x00: get rid of old code

We delay this patch for 2.6.29.

>  drivers/power/Kconfig           |   25 +--
>  drivers/power/Makefile          |    3 +-
>  drivers/power/bq27000.c         |  173 ++++++++++++
>  drivers/power/bq27200.c         |  202 ++++++++++++++
>  drivers/power/bq27x00.c         |  190 +++++++++++++
>  drivers/power/bq27x00.h         |   54 ++++
>  drivers/power/bq27x00_battery.c |  564 ---------------------------------------
>  7 files changed, 630 insertions(+), 581 deletions(-)
>  create mode 100644 drivers/power/bq27000.c
>  create mode 100644 drivers/power/bq27200.c
>  create mode 100644 drivers/power/bq27x00.c
>  create mode 100644 drivers/power/bq27x00.h
>  delete mode 100644 drivers/power/bq27x00_battery.c
> 

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
