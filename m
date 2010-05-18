From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: dss2 for-next BUG at drivers/video/omap2/dss/core.c:323!
Date: Tue, 18 May 2010 10:55:34 +0300
Message-ID: <1274169334.2307.74.camel@tubuntu.research.nokia.com>
References: <AANLkTinS0irEdEzttaHd0n_w5Cs3h6Q44e9sXgcbDmNH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:25140 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754101Ab0ERHzr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 03:55:47 -0400
In-Reply-To: <AANLkTinS0irEdEzttaHd0n_w5Cs3h6Q44e9sXgcbDmNH@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Robert Nelson <robertcnelson@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 2010-05-17 at 16:30 +0200, ext Robert Nelson wrote:
> Hi Tomi,
> 
> I've been using your dss2 branch with much success.
> 
> http://gitorious.org/linux-omap-dss2/linux/commits/for-next
> 
> I've just ran into a weird BUG that occurs on reboot on my headless
> beagles and wondering if you've ran into it too...
> 
> The kernel I'm currently testing is 2.6.34-rc7 plus the 2.6.35 dss2
> for-next commits..
> 
> I was assuming http://gitorious.org/linux-omap-dss2/linux/commit/89627989c6b4408c4578a41bcd5f9d04545797ad
> would fix it, but it hasn't fixed the Opps'ing...
> 
> log on attempt to reboot:
> 
> http://pastebin.com/iqAHMVD4

It looks like there's a mismatch with clock enables and disables
somewhere... I haven't seen that.

Can you tell me more details of your beagle? Does "headless" mean that
it's standard beagle board, but no display is connected to it?

 Tomi

Ps. Added linux-omap to cc, somebody there may have encountered this.


