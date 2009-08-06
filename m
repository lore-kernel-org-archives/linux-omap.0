From: Kalle Valo <kalle.valo@iki.fi>
Subject: Re: N8x0 to mainline patches
Date: Thu, 06 Aug 2009 19:21:50 +0300
Message-ID: <87y6pwnc9t.fsf@litku.valot.fi>
References: <87zlb95dwx.fsf@litku.valot.fi> <20090713060354.GJ6589@nokia.com>
	<87vdlx5b3y.fsf@litku.valot.fi> <20090713065341.GC16778@nokia.com>
	<20090806071038.GE7374@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f228.google.com ([209.85.220.228]:46592 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756178AbZHFQVy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 12:21:54 -0400
Received: by fxm28 with SMTP id 28so846256fxm.17
        for <linux-omap@vger.kernel.org>; Thu, 06 Aug 2009 09:21:53 -0700 (PDT)
In-Reply-To: <20090806071038.GE7374@atomide.com> (Tony Lindgren's message of "Thu\, 6 Aug 2009 10\:10\:38 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, Max Filippov <jcmvbkbc@gmail.com>, Jarkko Nikula <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony Lindgren <tony@atomide.com> writes:

> Hey, nice job cleaning up the n8x0 board support! Let's get those into
> l-o master and queued up for the next merge window. (Except for the
> hacks that is).

What did you think of the file layout? I decided to go with one file
approach (against your advice, sorry) because I didn't see any benefit
from having separate files.

My plan is this:

1. first finish OMAP_TAG_UART removal patch and send it for review

2. finins and send tusb6010 patch

+ omap2-add-usb-tusb6010-c

2. fold these n8x0 board file patches into one and send it for review:

+ n8x0-add-board-file
+ n8x0-onenand-support
+ n8x0-add-spi-support
+ n8x0-add-usb-support

Because the merge window is getting close, I'll do this ASAP.

There's a lot of to do still, but it's to get basic support to mainline
already now, makes it easier for us to implement the missing pieces.

-- 
Kalle Valo
