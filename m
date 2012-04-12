From: Kevin Hilman <khilman@ti.com>
Subject: Re: PM related performance degradation on OMAP3
Date: Thu, 12 Apr 2012 09:57:32 -0700
Message-ID: <87aa2ganwj.fsf@ti.com>
References: <CANOLnOP5gq4Vtt00SgRNW-3GZDWk0sukBgJx4V6rkMLL+b6G-w@mail.gmail.com>
	<4F859C5D.3090400@mlbassoc.com> <87hawqt6vt.fsf@ti.com>
	<4F86B227.90802@mlbassoc.com> <87aa2hjavi.fsf@ti.com>
	<4F86F4B2.3080101@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:39185 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755371Ab2DLQ5f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Apr 2012 12:57:35 -0400
Received: by dadz8 with SMTP id z8so3444117dad.38
        for <linux-omap@vger.kernel.org>; Thu, 12 Apr 2012 09:57:34 -0700 (PDT)
In-Reply-To: <4F86F4B2.3080101@mlbassoc.com> (Gary Thomas's message of "Thu,
	12 Apr 2012 09:28:50 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>

+Felipe for EHCI question

Gary Thomas <gary@mlbassoc.com> writes:

[...]

> This worked a treat, thanks.  My network performance is better
> now, but still not what it was.  The same TFTP transfer now takes
> 71 seconds, so about 50% slower than on the 3.0 kernel.  Applying the
> second [unnamed] patch (arch/arm/mach-omap2/cpuidle34xx.c) made no difference.

And does a CONFIG_PM=n kernel get you back to your v3.0 performance?

> I am interested in having PM working as I'm designing a battery powered
> portable unit, so I need to keep pursuing this.

So do I. :)

> Note: I noticed that when I built with CONFIG_PM off and no other
> changes, my EHCI USB didn't work properly.  Should this be the case?

Probably not, but haven't tested EHCI USB.  I've Cc'd Felipe to see if
he has any ideas why EHCI wouldn't work with CONFIG_PM=n.

Kevin
