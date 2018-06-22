From: Tony Lindgren <tony@atomide.com>
Subject: Re: v4.18-rc1 on droid 4: very bad CPU performance
Date: Fri, 22 Jun 2018 00:20:05 -0700
Message-ID: <20180622072005.GF112168@atomide.com>
References: <20180621121542.GA4836@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180621121542.GA4836@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180621 12:18]:
> Hi!
> 
> V4.18 is slower than it should be.
> 
> user@devuan:~$ time cat /dev/urandom | head -c 10000000 |  bzip2 -9 -
> | wc -c
> 10044291
> 52.73user 2.40system 61.53 (1m1.534s) elapsed 89.60%CPU
> user@devuan:~$ uname -a
> Linux devuan 4.18.0-rc1-87964-gfa19934-dirty #743 SMP Sun Jun 17
> 19:26:37 CEST 2018 armv7l GNU/Linux
> 
> That bzip should take 12 seconds, not minute.
> 
> Any ideas? Do you see it, too?

I've noticed firefox is super slow.. Git bisect time?

Regards,

Tony
