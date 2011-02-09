From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/5 v5] OMAP2430: hwmod data: Add USBOTG
Date: Tue, 08 Feb 2011 16:55:00 -0800
Message-ID: <87y65qf2mz.fsf@ti.com>
References: <1291991739-21705-1-git-send-email-hemahk@ti.com>
	<1291991739-21705-2-git-send-email-hemahk@ti.com>
	<3b6a23e346e75947e09f70dae78f2d88@mail.gmail.com>
	<20110203092507.GD23561@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:34467 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755128Ab1BIAzE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Feb 2011 19:55:04 -0500
In-Reply-To: <20110203092507.GD23561@legolas.emea.dhcp.ti.com> (Felipe Balbi's
	message of "Thu, 3 Feb 2011 11:25:07 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Hema Kalliguddi <hemahk@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Felipe Balbi <balbi@ti.com> writes:

> Hi,
>
> On Thu, Feb 03, 2011 at 11:24:48AM +0530, Hema Kalliguddi wrote:
>> Any comments?
>
> For me these are ok, Tony/Kevin, do you want me to prepare a pull
> request when we're closer to .39 merge window for one of you guys to
> pull from and get this part in mainline ? pm_runtime parts (which only
> touch drivers/usb/musb/omap2430.c) I can get in mainline through Greg,
> but not this.

I did not see a cover letter on this series to see on what platforms it
was tested.  Based on all the other omap_device/omap_hwmod conversions,
I recommend you ensure this has been tested on all relevant platforms
before merging.

That being said, you're the maintainer, so you can decide when you're OK
with it.

When you're OK with the driver/common code, Benoit will queue the hwmod
data changes.

Kevin



