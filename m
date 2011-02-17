From: Anand Gadiyar <gadiyar@ti.com>
Subject: RE: omap3evm does not boot after 2.6.38-rc1
Date: Thu, 17 Feb 2011 09:42:19 +0530
Message-ID: <0fc7120064d33b37334afa28bf4ee760@mail.gmail.com>
References: <AANLkTi=GHh-UTfTHgDJKW8HfCbTbe6zqitAL0FeyXtW8@mail.gmail.com> <20110217015454.GN20795@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:42311 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750981Ab1BQEMl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 23:12:41 -0500
Received: by mail-fx0-f41.google.com with SMTP id 12so2241913fxm.0
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 20:12:40 -0800 (PST)
In-Reply-To: <20110217015454.GN20795@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Sung Hee Park <shpark7@stanford.edu>
Cc: linux-omap@vger.kernel.org

Tony Lindgren wrote:
> * Sung Hee Park <shpark7@stanford.edu> [110216 14:18]:
> > Hi all,
> >
> > I'm having a problem with booting the linux kernel on my omap3evm. It
> > halts after saying "Uncompressing Linux... done, booting the kernel."
> > on boot. I had a similar problem with 2.6.37, but after changing the
> > name of the serial port devices from /dev/ttyS* to /dev/ttyO*, it
> > worked. Does anyone experiencing this problem again with 2.6.38
> > kernels? Please let me know if you have any idea what might have gone
> > wrong.
>
> If you have 2.6.38-rc1 booting, maybe try running git bisect on it
> to find out where it breaks?
>
> Tony

Enable CONFIG_EARLY_PRINTK, and add the word earlyprintk to your bootargs.
This should help get some prints on the debug UART which might help
debug this.

- Anand
