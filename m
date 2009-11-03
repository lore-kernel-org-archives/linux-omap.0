From: xl6@rice.edu
Subject: Re: n8x0 idle power problem
Date: Tue, 03 Nov 2009 11:30:47 -0600
Message-ID: <20091103113047.145860vqqf9ez5kw@webmail.rice.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mh1.mail.rice.edu ([128.42.201.20]:40056 "EHLO
	mh1.mail.rice.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbZKCRhT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 12:37:19 -0500
Received: from mh1.mail.rice.edu (localhost.localdomain [127.0.0.1])
	by mh1.mail.rice.edu (Postfix) with ESMTP id F1F0FCC091
	for <linux-omap@vger.kernel.org>; Tue,  3 Nov 2009 11:30:50 -0600 (CST)
Received: from mh1.mail.rice.edu ([127.0.0.1])
	by mh1.mail.rice.edu (mh1.mail.rice.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZLqP1Nj3ffPT for <linux-omap@vger.kernel.org>;
	Tue,  3 Nov 2009 11:30:50 -0600 (CST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: xl6)
	by mh1.mail.rice.edu (Postfix) with ESMTPSA id DAEC5CC0AE
	for <linux-omap@vger.kernel.org>; Tue,  3 Nov 2009 11:30:49 -0600 (CST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


By 'deeper-sleep state', you mean the full retention mode? I am sure  
that pm24xx.c:omap2_enter_full_retention() is called and the assembly  
code in sleep24xx.S is executed, by printing some debug info.

Thanks.

Best Regards,
--
Felix

On Tue, Nov 3, 2009 at 11:19 AM, Tony Lindgren <tony@atomide.com> wrote:

     * Felix Xiaozhu Lin <xzl@rice.edu> [091023 16:41]:
     > I am trying to compile a linux-omap kernel for n810 that can do good
     > idle power management.
     >
     > However, this seems to be harder than I expected. I've done all
     > following measurements with /sys/power/sleep_while_idle set to 1.
     > Compiler is arm-linux-gnueabi-gcc 4.2. I use n8x0_defconfig.
     >
     >   * Maemo kernel (2.6.21) consumes ~0mA@3.8V when idle. This seems to
     > be perfect. However, it has no pm regarding serial port. Whenever
     > serial port is enabled, idle power is ~50mA@3.8V.
     >
     >   * I've compiled 2.6.28/2.6.29 from l-o git. Serial port pm works
     > fine. However the idle power is ~20mA@3.8V. That is quite strange.
     >
     >   * For kernel >= 2.6.30 I didn't manage to boot my N810.
     >
     > I also dig out a thread discussing about N8x0 idle power:
     >
     > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg11954.html
     >
     > where Kalle mentioned 2.6.29 idle power is OK. But I never get  
the same result.
     >
     > I'm wondering if I did something wrong in the measurement. Anybody did
     > the same thing? You suggestion is highly appreciated.

     It sounds like something is blocking the deeper idle states.
     The way to debug is to see what clocks and domains are on
     before entering idle.

     Maybe do a register dump on a working system and compare that
     to the current system?

     Regards,

     Tony

