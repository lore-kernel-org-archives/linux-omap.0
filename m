From: Kan-Ru Chen <kanru@0xlab.org>
Subject: Re: [PATCH 2/2] USB: musb: omap2430: add mode change from A to B
Date: Fri, 23 Jul 2010 12:38:28 +0800
Message-ID: <87y6d2u81n.fsf@anar.kanru.info>
References: <1268648622-28529-1-git-send-email-Hui.Wang@windriver.com> <1268648622-28529-2-git-send-email-Hui.Wang@windriver.com> <877hknwnrb.fsf@anar.kanru.info> <4C48748C.8040307@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cp20.secserverpros.com ([67.220.217.187]:41016 "EHLO cp20"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751008Ab0GWEjG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Jul 2010 00:39:06 -0400
In-Reply-To: <4C48748C.8040307@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Wang Hui <Hui.Wang@windriver.com>, tony@atomide.com, felipe.balbi@nokia.com, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On Thu, 22 Jul 2010 19:40:44 +0300, Felipe Balbi <me@felipebalbi.com> wrote:
> On 07/22/2010 06:16 PM, Kan-Ru Chen wrote:
> > Just curious about how to do this in a more automatic way.
> > 
> > I think setup a daemon to monitor the musb_hdrc mode and try to alter
> > it's state via sysfs interface will work, but it may be error prone and
> > not always desirable solution.
> > 
> > Can we query the id pin state periodically in the kernel and change to
> > corresponding role?
> 
> the transceiver has an interrupt for id pin changes. You can use that
> instead of polling.

Thanks, I see.

The twl4030_usb transceiver did get the id pin chanegs

    <7>twl4030_usb twl4030_usb: HW_CONDITIONS 0x50/80; link 1
    <7>twl4030_usb twl4030_usb: HW_CONDITIONS 0x54/84; link 3

So the problem is when OTG enter a_host mode then disconnected, it
becomes idle. Plug the peripheral device back would not trigger new
session unless I do "echo otg > /sys/devices/platform/musb_hdrc/mode"
