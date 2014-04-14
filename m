From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] pwm: use PWM_LOOKUP to set the period and polarity
Date: Mon, 14 Apr 2014 11:03:15 +0900
Message-ID: <20140414020315.GF22411@verge.net.au>
References: <1397066649-3767-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1397066649-3767-3-git-send-email-alexandre.belloni@free-electrons.com>
 <20140409231549.GD2187@verge.net.au>
 <20140410073702.GF2879@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140410073702.GF2879@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Tony Lindgren <tony@atomide.com>, Philipp Zabel <philipp.zabel@gmail.com>, Paul Parsons <lost.distance@yahoo.com>, Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Apr 10, 2014 at 09:37:03AM +0200, Alexandre Belloni wrote:
> On 10/04/2014 at 08:15:49 +0900, Simon Horman wrote :
> > On Wed, Apr 09, 2014 at 08:04:09PM +0200, Alexandre Belloni wrote:
> > > Now that the PWM core is able to set the period and polarity based on
> > > the lookup table, add those to PWM_LOOKUP to ease their usage.
> > 
> > I would prefer if this change was made in a non-atomic manner.
> > 
> > 1. Add new infrastructure
> > 2. Update users individually
> > 3. Remove old infrastructure
> > 
> 
> I agree this would be better but I'm not sure how you can modify a macro
> without renaming it or changing it everywhere at once. Like said, I'm
> open to creating a new macro.

I for one would prefer the new macro approach.
