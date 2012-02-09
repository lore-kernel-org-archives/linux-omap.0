From: Kevin Hilman <khilman@ti.com>
Subject: Re: OMAP34xx
Date: Thu, 09 Feb 2012 15:13:00 -0800
Message-ID: <87hayzzjlv.fsf@ti.com>
References: <20120208231551.GA9009@kroah.com>
	<alpine.DEB.2.00.1202081648510.9540@utopia.booyaka.com>
	<20120209004731.GA11343@kroah.com> <4F3374F0.3080002@bitmer.com>
	<20120209133739.GB2590@sirena.org.uk>
	<20120209183624.GJ1426@atomide.com>
	<20120209193442.GA1767@rexfeany.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:59439 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758351Ab2BIXNF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 18:13:05 -0500
Received: by mail-pz0-f48.google.com with SMTP id p13so2081122dad.21
        for <linux-omap@vger.kernel.org>; Thu, 09 Feb 2012 15:13:03 -0800 (PST)
In-Reply-To: <20120209193442.GA1767@rexfeany.com> (Rex Feany's message of
	"Thu, 9 Feb 2012 11:34:42 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rex Feany <rfeany@laeos.net>
Cc: Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Greg KH <gregkh@linuxfoundation.org>, Paul Walmsley <paul@pwsan.com>, Grazvydas Ignotas <notasas@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

Rex Feany <rfeany@laeos.net> writes:

> Thus spake Tony Lindgren (tony@atomide.com):
>
>> Please everybody using omaps with mainline give a test for the
>> merge of the various fixes planned. I've done a branch with
>> v3.3-rc3 + Russell's fixes + Paul's serial port fixes + fixes
>> that I've queued up.
>> 
>> If you still see problems with compiling, booting, or slow serial
>> port, please post the issues to linux-omap and LAKML lists
>> immediately.
>
> With the testing branch, my serial port is still very slow. 
> The console is set to 115200, dmesg takes almost a minute to print out.
> I'm testing on a beagleboard-xm, which has the DM3730.
> (if I change omap2_pm_idle() to never call omap_sram_idle() things improve *a lot*).
>
> config: http://tonya.fnordsoft.com/omap-testing/config
> dmesg: http://tonya.fnordsoft.com/omap-testing/testing-dmesg

Looking at your config, I see quite a few changes from the default
omap2plus_defconfig.

Also, based on your config and your dmesg output, you're booting a
3.3-rc1 kernel.

Tony's branch is based on -rc3, so I'm a bit confused about what you're
testing.

Can you double check that you're building and booting using Tony's -rc3
based branch?

Also, can you do a test using omap2plus_defconfig?

If it works with omap2plus_defconfig, it would be a great help if you
can slowly enable/diable the config options you care about until it
breaks so we can isolate the problem you're seeing.

Thanks,

Kevin

