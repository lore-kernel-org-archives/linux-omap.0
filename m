From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.6-rc5
Date: Mon, 10 Sep 2012 16:46:29 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209101510270.23042@utopia.booyaka.com>
References: <alpine.DEB.2.00.1209091743430.28047@utopia.booyaka.com> <alpine.DEB.2.00.1209091814380.28047@utopia.booyaka.com> <20120910055118.GA19264@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:34933 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753005Ab2IJQqa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Sep 2012 12:46:30 -0400
In-Reply-To: <20120910055118.GA19264@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?ISO-8859-15?Q?Andreas_M=FCller?= <schnitzeltony@googlemail.com>, grinberg@compulab.co.il, Sourav Poddar <sourav.poddar@ti.com>

Hi Felipe,

On Mon, 10 Sep 2012, Felipe Balbi wrote:

> On Sun, Sep 09, 2012 at 06:15:04PM +0000, Paul Walmsley wrote:
> > > * 4430ES2 Panda: UART corruption during long transmit buffers
> > >   - Presumably due to either a missing hardware workaround or a bug in
> > >     the OMAP serial driver
> > > 
> > * 3730 Beagle XM: does not serial wake from off-idle suspend when console
> >   UART doesn't clock gate ("debug ignore_loglevel")
> >   - Not shown in the current test logs; cause unknown
> 
> How do you trigger these two ? Can you share whatever script you wrote
> for this to fail ?

The 4430ES2 Panda issue can be seen here:

  http://www.pwsan.com/omap/testlogs/test_v3.6-rc5/20120908202511/pm/4430es2panda/4430es2panda_log.txt

That shows the kernel command line, commit ID, sequence of 
commands executed, and output.  (The transmit buffer corruption can be 
found in the section "%% Start retention dynamic idle UART wakeup test" 
when it runs "cat /debug/pm_debug/count")

Similarly, the 3730 Beagle XM issue should be reproducible via the same 
means as in:

  http://www.pwsan.com/omap/testlogs/test_v3.6-rc5/20120908202511/pm/3730beaglexm/3730beaglexm_log.txt

but "debug ignore_loglevel" should be added to the kernel command line 
when booting.  Will try to add a specific PM test for this case.

Will try to do a few test runs on your series that was merged in tty-next 
to see if anything has changed.

> I'm assuming the bugs are only triggered on those two
> particular platforms, so it could just be missing workaround on both
> cases (?)

Hard to say...


- Paul
