From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 0/4] usb: musb: support for suspend and resume
Date: Tue, 01 Oct 2013 00:27:40 +0200
Message-ID: <5249FADC.9040908@gmail.com>
References: <1380200942-28175-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:43145 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945Ab3I3W1q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Sep 2013 18:27:46 -0400
In-Reply-To: <1380200942-28175-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de, bigeasy@linutronix.de, balbi@ti.com, gregkh@linuxfoundation.org

On 26.09.2013 15:08, Daniel Mack wrote:
> I've been working on some patches that allow suspending and resuming
> the musb-dsps platform. This was tested for host mode only.
> 
> With these patches applied, I can successfully bring an AM335x board
> to suspend with a USB media connected, and access it again after
> resume. Note that this currently only works with CONFIG_MUSB_PIO_ONLY
> set. The cppi41 driver needs some more love to make this work. I'll
> work on that next.

As this series hasn't been applied yet, please consider it outdated. I
have some more patches coming and will include them when publishing a
new round of patches.


Thanks,
Daniel

