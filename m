From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: runtime check for omap-aes bus access permission (was: Re:
 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot)
Date: Thu, 28 May 2015 22:26:52 +0200
Message-ID: <CAALWOA8Pfc_zbN9MoHwR=njPBpFU56WObYMbGv9N7ktzy+RSeQ@mail.gmail.com>
References: <20131206213613.GA19648@earth.universe> <201502111339.54480@pali>
 <CAALWOA_ngoSKjB=ZQ264Va37bBK7v41Ei45SyoYLiMdanTKnxQ@mail.gmail.com>
 <201502112128.44852@pali> <CAGo_u6oZxi7O6re30L2-wVyxTeahhyMb4qVcrE3tSCV9sBvrnw@mail.gmail.com>
 <20150528073740.GD16509@pali> <20150528160113.GH30984@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150528160113.GH30984@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sebastian Reichel <sre@ring0.de>, linux-omap <linux-omap@vger.kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, lkml <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

On 28 May 2015 at 18:01, Tony Lindgren <tony@atomide.com> wrote:
> For failed device access you get an interrupt

Well for failed reads you get a bus error, and "catching" those (e.g.
using the existing exception mechanism used to catch MMU faults) is
the whole issue.

Though now that you mention it, it is true that for writes you won't
get any fault (at least on the DM814x and AM335x the posting point
appears to be the async bridge from MPUSS to the L3 interconnect) but
an interconnect error irq instead. It may be easier to make some kind
of harmless write (e.g. to the version register), wait a bit, and
check if the write triggered an interconnect error.

Feels hackish though: you'd need to be sure you waited long enough
(though using a read from another device on the same L4 interconnect
should be a reliable barrier in this case), and drivers for
receiving/interpreting interconnect errors are not implemented yet on
all SoCs (for some, like the AM335x, TI didn't even bother publishing
the relevant data in its TRM). Interconnect errors can also be lost in
some cases (multiple errors involving the same target in a short time
window) though that problem shouldn't arise in this particular case.

Also, presumably interconnect error reporting is unavailable on HS
devices given the fact that all interconnect registers seemed to be
inaccessible?

Matthijs
