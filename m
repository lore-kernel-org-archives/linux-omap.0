From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: 2.6.38 not booting on sbc8100 (aka devkit8000)
Date: Fri, 25 Mar 2011 10:27:20 +0200
Message-ID: <20110325102720.d2940de3.jhnikula@gmail.com>
References: <AANLkTikAO+FA+0fCNiVj=9wVZ3t+vfx9tJX_SnJ7FGSd@mail.gmail.com>
	<20110324151844.GT2811@atomide.com>
	<AANLkTik8PW4ad2_4=UxzvL-V7HcpH0=dg-Un5NLkj6Yi@mail.gmail.com>
	<20110324190030.GW2811@atomide.com>
	<AANLkTimdQKo40r9FzhHe94uAF28qGLcf5_5ZzcOrJuTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47106 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754883Ab1CYI0v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 04:26:51 -0400
Received: by eyx24 with SMTP id 24so404378eyx.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 01:26:49 -0700 (PDT)
In-Reply-To: <AANLkTimdQKo40r9FzhHe94uAF28qGLcf5_5ZzcOrJuTA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Belisko Marek <marek.belisko@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Fri, 25 Mar 2011 08:57:04 +0100
Belisko Marek <marek.belisko@gmail.com> wrote:

> >> > Can you enable DEBUG_LL and EARLY_PRINTK in your .config
> >> > and add earlyprintk to your cmdline? Then you should see
> >> > what goes wrong.
> >> >
> >> Forgot to mention. I already test this options but result is same like I
> >> report in
> >> first email.
> >
> > Maybe add some printk statements to start_kernel function in
> > init/main.c and see if you get any output?
> Add some printk to function you propose bu no output.

Do you get any output if you don't compile support for your board but
for something else like for Beagle only so that machine id from
bootloader and machine(s) supported by the kernel doesn't match?

-- 
Jarkko
