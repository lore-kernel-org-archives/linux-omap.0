From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: runtime check for omap-aes bus access permission (was: Re:
 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot)
Date: Fri, 29 May 2015 02:58:29 +0200
Message-ID: <CAALWOA9qJHUST0JQxA6MBohMfbTYAP9+NbSXGYHZY4Xa3nSFvw@mail.gmail.com>
References: <20131206213613.GA19648@earth.universe> <201502111339.54480@pali>
 <CAALWOA_ngoSKjB=ZQ264Va37bBK7v41Ei45SyoYLiMdanTKnxQ@mail.gmail.com>
 <201502112128.44852@pali> <CAGo_u6oZxi7O6re30L2-wVyxTeahhyMb4qVcrE3tSCV9sBvrnw@mail.gmail.com>
 <20150528073740.GD16509@pali> <20150528160113.GH30984@atomide.com>
 <CAALWOA8Pfc_zbN9MoHwR=njPBpFU56WObYMbGv9N7ktzy+RSeQ@mail.gmail.com> <20150528222412.GM30984@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38697 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754959AbbE2A6v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 May 2015 20:58:51 -0400
In-Reply-To: <20150528222412.GM30984@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sebastian Reichel <sre@ring0.de>, linux-omap <linux-omap@vger.kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, lkml <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>

On 29 May 2015 at 00:24, Tony Lindgren <tony@atomide.com> wrote:
> Hmm I believe the interrupt happens immediately trying to access an
> invalid device. But maybe I'm thinking about just errors if a device
> is not powered or clocked.

It is only guaranteed to happen immediately (before the next
instruction is executed) if the error occurs before the posting-point
of the write. However, in that case the error is reported in-band to
the cpu, resulting in a (synchronous) bus error which takes precedence
over the out-of-band error irq (if any is signalled). Once the write
is posted however, the cpu will receive an ack on the write and
continue execution, and there's no reason to assume that an error irq
will happen *immediately* after the write.

Of course it typically will happen soon afterwards, possibly even
before the next instruction is executed, depending a bit on how soon
after the posting-point the error occurs versus how long it takes for
the write-ack to reach the cpu. On the other hand, it's also possible
the write, after becoming posted, gets stuck for a while due to a
burst of higher-priority traffic. (I also recall reading about some
situation where a request needs to wait for something to be
dynamically powered up before an error response could be generated,
but I think that was on the OMAP 4.)

So that's the icky part: it will very likely happen almost
immediately. There's however no *guarantee* that it will, and in fact
it's quite tricky to absolutely make sure a write is no longer in
transit. The usual solution is an "OCP barrier": a read that is known
to follow the same path as the write. Normally that means a read from
the same peripheral, but that would defeat the purpose in this case.
Fortunately, the L4 interconnects (unlike the L3) detect firewall
violations in the initiator agent rather than the target agents, hence
a read from any peripheral on the same L4 interconnect suffices.
