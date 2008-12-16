From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: N810 suspend
Date: Tue, 16 Dec 2008 09:17:50 +0200
Message-ID: <20081216091750.91cc50a8.jarkko.nikula@nokia.com>
References: <20081215210823.GD5334@swansys>
	<20081215211430.GJ10664@atomide.com>
	<87prjt9jwy.fsf@deeprootsystems.com>
	<20081215235116.GC25056@swansys>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:33946 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbYLPHSM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Dec 2008 02:18:12 -0500
In-Reply-To: <20081215235116.GC25056@swansys>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext green <greenfreedom10@gmail.com>
Cc: Linux-OMAP List <linux-omap@vger.kernel.org>

On Mon, 15 Dec 2008 16:51:16 -0700
"ext green" <greenfreedom10@gmail.com> wrote:

> > Suspend/resume on n810 is currently broken in linux-omap.  I submitted
> > a patch a week or so ago to fix an assembly bug which was crashing the
> > suspend, but it is still not resuming.
> > 
> > Most likely a simple fix needed to init the proper wakeup sources, but
> > I haven't tested further.
> 
> I'll be looking for any progress ;) and will test it when I can.
> 
Hold your horses, suspend is not very useful on N8x0 due watchdog kick
after ~30 seconds or so :-)

Of course, generally suspend should work on OMAP & device drivers even
though if it's broken currently.

What you might be interested instead is to get sleep_while_idle
working. Then the system is running but should consume just few
milliamps.


Jarkko
