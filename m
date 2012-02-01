From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Adding remoteproc/rpmsg to linux-next
Date: Wed, 1 Feb 2012 16:57:36 +0000
Message-ID: <201202011657.36998.arnd@arndb.de>
References: <CAK=WgbaU6vpiBGSgogYPjQNmrF-U0wk1rSXMX83DdgQa9hw5Mw@mail.gmail.com> <201112221522.21146.arnd@arndb.de> <CAK=WgbZK_fS_rPWZ9pNARia3sp4+jL5GmR0UmyE59WZSObfWEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <CAK=WgbZK_fS_rPWZ9pNARia3sp4+jL5GmR0UmyE59WZSObfWEQ@mail.gmail.com>
Sender: linux-next-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-next@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Brian Swetland <swetland@google.com>, akpm@linux-foundation.org, Greg KH <greg@kroah.com>, Stephen Boyd <sboyd@codeaurora.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Rusty Russell <rusty@rustcorp.com.au>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Saravana Kannan <skannan@codeaurora.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday 01 February 2012, Ohad Ben-Cohen wrote:
> On Thu, Dec 22, 2011 at 5:22 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > If you think you need more Acks or if there are other
> > reasons to have it go through arm-soc, please tell me and I'll try harder
> > to find the time for a proper review.
> 
> Any chance you could carve out some time for reviewing remoteproc and
> rpmsg [1] ?

I will.
 
> I hope we could either get your Acks on the patches or even have it go
> through arm-soc for 3.4.

Yes, I think it's best to have it merged through arm-soc, in case Linus
is more likely to take it from there than pull from your tree.

	Arnd
