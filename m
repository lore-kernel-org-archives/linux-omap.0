From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: Re: [PATCH 1/1] TWL: USB: disable VUSB regulators when cable
	unplugged
Date: Tue, 27 Jan 2009 11:50:03 +0200
Message-ID: <1233049803.6515.475.camel@ubuntu>
References: <1232543718-18199-1-git-send-email-kalle.jokiniemi@digia.com>
	 <1232543718-18199-2-git-send-email-kalle.jokiniemi@digia.com>
	 <200901220955.51986.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gate.edelkey.net ([213.138.147.140]:49139 "EHLO
	gate.edelkey.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbZA0JuT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jan 2009 04:50:19 -0500
In-Reply-To: <200901220955.51986.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com

On Thu, 2009-01-22 at 09:55 -0800, David Brownell wrote:
> On Wednesday 21 January 2009, Kalle Jokiniemi wrote:
> > This patch disables USB regulators VUSB1V5, VUSB1V8, and VUSB3V1
> > when the USB cable is unplugged to reduce power consumption.
> 
> Worked fine on a Beagle, now I'm trying to find out
> what's borked on an Overo ...

Did you manage to get it working on Overo? 

BTW. Should I post this patch to linux-usb as well?

- Kalle

> 
> - Dave
> 
