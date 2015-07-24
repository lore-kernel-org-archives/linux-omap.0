From: Dave Young <dyoung@redhat.com>
Subject: Re: linux 4.2-rc1 broken Nokia N900
Date: Fri, 24 Jul 2015 18:28:44 +0800
Message-ID: <20150724102844.GB8405@localhost.localdomain>
References: <201507111405.06048@pali>
 <20150724081809.GB22852@dhcp-128-11.nay.redhat.com>
 <55B1F7BB.9020102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55B1F7BB.9020102@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 07/24/15 at 11:30am, Ivaylo Dimitrov wrote:
> 
> 
> On 24.07.2015 11:18, Dave Young wrote:
> 
> >Pali, could you tell how do you test mainline kernel on n900?
> >
> >I used to use n900 as a usb dbgp gadget with a backport patch to
> >2.6.28 so that I can get early debug kernel message from my laptop.
> >
> >I tried mainline previously with Fedora arm, text mode works but
> >no graphics. Is there a way to use maemo UI with mainline kernel?
> >
> >Thanks
> >Dave
> >
> 
> http://talk.maemo.org/showpost.php?p=1459970&postcount=142
> 
> This is the last (almost) upstream kernel I tried, unfortunately recently I
> am very short on spare time, so cannot confirm for 4.x kernels, but in
> theory those should work as well.
> 
> The kernel tree was on gitorious, but it is down now(I have a local copy).
> However, all of the needed patches should be on
> https://github.com/pali/linux-n900.

Ivaylo, thanks for your info. I know pali's kernel tree, but the problem is
I do not know much about the userspace fixes.

According to another reply from Pali, I should fix HAL and sgx start script.

Thanks
Dave
