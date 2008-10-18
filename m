From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 0/4] bq27x00 updates
Date: Sun, 19 Oct 2008 01:16:43 +0400
Message-ID: <20081018211643.GA1272@oksana.dev.rtsoft.ru>
References: <1224277248-17021-1-git-send-email-felipe.balbi@nokia.com>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:18134 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751040AbYJRVQp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 18 Oct 2008 17:16:45 -0400
Content-Disposition: inline
In-Reply-To: <1224277248-17021-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, Anton Vorontsov <cbou@mail.ru>, David Woodhouse <dwmw2@infradead.org>

On Sat, Oct 18, 2008 at 12:00:44AM +0300, Felipe Balbi wrote:
> The previous driver for bq27x00 batteries was a real
> ifdef mess. The following patches separate common code
> and create separate drivers for bq27200 and bq27000.

FYI (if you don't know already): Rodolfo Giometti already
cleaned up bq27200 part of that driver and submitted it few
months ago.

http://lkml.org/lkml/2008/6/18/154

It will appear in the 2.6.28 kernel. For now it lives here:

http://git.infradead.org/battery-2.6.git?a=commitdiff;h=b996ad0e9fb15ca4acc60bcd0380912117a45d13

So I'd be happy if you could just rework it to support
bq27000 (w1) interface as well.

> The code looks much cleaner, but we had to keep a global
> static pointer to hold the i2c_client (bq27200) or the
> w1 device (bq27000).

Yeah, this is not great...

> If anyone has a better solution, I'd like to hear since
> keeping that global pointer doesn't look nice.

Can you consider this idea
http://kerneltrap.org/mailarchive/linux-kernel/2008/6/23/2198444
?

It shows only i2c part, but the idea should be clear:
there should be w1 and i2c drivers, both would create bq27x00
platform devices, then the platform driver would not depend on
any hw interface.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
