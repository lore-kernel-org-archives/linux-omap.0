From: Tony Lindgren <tony@atomide.com>
Subject: Re: Open issues after 2.6.38 merge window
Date: Fri, 14 Jan 2011 12:54:24 -0800
Message-ID: <20110114205424.GQ4957@atomide.com>
References: <20110114194758.GM4957@atomide.com>
 <20110114223701.11e0f7d1.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57086 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138Ab1ANUyd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jan 2011 15:54:33 -0500
Content-Disposition: inline
In-Reply-To: <20110114223701.11e0f7d1.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>

* Jarkko Nikula <jhnikula@gmail.com> [110114 12:34]:
> On Fri, 14 Jan 2011 11:47:58 -0800
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > - omap4 panda powers down after boot (watchdog?)
> > 
> > - omap3 ldp board powers down after boot?
> > 
> my 2c to Panda power down problem:
> 
> Nishanth helped me recently to debug why my board does this power down
> and it seems to be caused by a broken hw. I.e. we were using exactly
> same bootloader and kernel and only my board was not working.

Hmm, mine was working just fine until about a week ago.
I did update the bootloader also though. What's the recommended
x-loader + u-boot combo for panda?

Tony
