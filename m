From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 0/6] teach gpiolib about gpio debouncing
Date: Thu, 20 May 2010 21:55:05 +0300
Message-ID: <20100520185504.GC25089@gandalf>
References: <1274090554-19420-1-git-send-email-felipe.balbi@nokia.com>
 <20100520110431.58c42ee8.akpm@linux-foundation.org>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100520110431.58c42ee8.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

On Thu, May 20, 2010 at 11:04:31AM -0700, Andrew Morton wrote:
> On Mon, 17 May 2010 13:02:29 +0300
> felipe.balbi@nokia.com wrote:
> 
> > From: Felipe Balbi <felipe.balbi@nokia.com>
> > 
> > Hi all,
> > 
> > I'm resending this series since no-one has had any further
> > comments for quite some time.
> > 
> > Adding Andrew Morton to the loop also since David Brownell
> > didn't pick the patch neither comment to any version of it.
> 
> David's been very quiet lately - please always cc me on gpio patches.
> 
> When were these first sent?  Has there been any feedback or external
> testing?
> 
> I'm not seeing anything in the changelogs which helps me to understand
> how important this feature is and it's rather late to be merging
> 2.6.35 feature work..

I guess we could leave it to 2.6.36 since OMAP is currently the only
user and we have our own omap-specific ways of setting debounce time on
gpios. That would also give people more time to complain if they think
the api should change somehow.

-- 
balbi
