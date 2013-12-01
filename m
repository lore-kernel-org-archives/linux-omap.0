From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH v2 2/3] bq2415x_charger: Use power_supply notifier for
 automode
Date: Sun, 1 Dec 2013 14:37:30 -0800
Message-ID: <20131201223730.GD6271@lizard>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <1384856285-19593-3-git-send-email-pali.rohar@gmail.com>
 <CAOf5uwkrep0PhOn67+9PHmP2A2Jxrp9DNK3BRp9D_sYu_PYvvw@mail.gmail.com>
 <201311242001.23126@pali>
 <CAOf5uw=-cy2QoDxjecxYTYsrQRD=LtN0N7DcYJHZ6HSbexzPRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOf5uw=-cy2QoDxjecxYTYsrQRD=LtN0N7DcYJHZ6HSbexzPRw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, freemangordon@abv.bg, aaro.koskinen@iki.fi, pavel@ucw.cz
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 25, 2013 at 08:16:34PM +0100, Michael Trimarchi wrote:
...
> >> So you can read this value without any type of synchronization
> >> with the power_supply_core
> >> and sysfs implementation?
...
> https://lists.ubuntu.com/archives/kernel-team/2013-January/025206.html
> 
> I found and equivalent scenario that I was trying to said

That's a good question, actually. Even though in Pali's case the notifier
is atomic (so that we are pretty confident that the object won't be
unregistered), there is still a possiblity of a dead lock, for example. So
notifiers should be careful to not hold any locks, because the other
driver might call get_property(), which might acquire locks.

Thanks,

Anton
