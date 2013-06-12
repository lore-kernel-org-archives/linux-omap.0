From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm/omap: use const char properly
Date: Wed, 12 Jun 2013 07:17:11 -0700
Message-ID: <20130612141711.GV8164@atomide.com>
References: <1370525079-22195-1-git-send-email-bigeasy@linutronix.de>
 <CAB=otbRkdAxWoQq0wsUNdgdWg-TUs0wY58AXhfxAQ24JCj_80Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:11481 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483Ab3FLORV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Jun 2013 10:17:21 -0400
Content-Disposition: inline
In-Reply-To: <CAB=otbRkdAxWoQq0wsUNdgdWg-TUs0wY58AXhfxAQ24JCj_80Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ruslan Bilovol <ruslan.bilovol@ti.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-omap@vger.kernel.org

* Ruslan Bilovol <ruslan.bilovol@ti.com> [130606 06:48]:
> Hi Sebastian,
> 
> On Thu, Jun 6, 2013 at 4:24 PM, Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> > The itention was probably to make both pointers const but as it is now,
> > it is just const used twice.
> 
> Yes, it's a typo I did accidentally. Good catch!

Thanks applying into omap-for-v3.11/fixes-non-critical.

Regards,

Tony
