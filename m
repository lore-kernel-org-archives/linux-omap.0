From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap3evm does not boot after 2.6.38-rc1
Date: Wed, 16 Feb 2011 17:54:54 -0800
Message-ID: <20110217015454.GN20795@atomide.com>
References: <AANLkTi=GHh-UTfTHgDJKW8HfCbTbe6zqitAL0FeyXtW8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63765 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755497Ab1BQBzJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 20:55:09 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=GHh-UTfTHgDJKW8HfCbTbe6zqitAL0FeyXtW8@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sung Hee Park <shpark7@stanford.edu>
Cc: linux-omap@vger.kernel.org

* Sung Hee Park <shpark7@stanford.edu> [110216 14:18]:
> Hi all,
> 
> I'm having a problem with booting the linux kernel on my omap3evm. It
> halts after saying "Uncompressing Linux... done, booting the kernel."
> on boot. I had a similar problem with 2.6.37, but after changing the
> name of the serial port devices from /dev/ttyS* to /dev/ttyO*, it
> worked. Does anyone experiencing this problem again with 2.6.38
> kernels? Please let me know if you have any idea what might have gone
> wrong.

If you have 2.6.38-rc1 booting, maybe try running git bisect on it
to find out where it breaks?

Tony
