From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/5] gpiolib: introduce set_debounce method
Date: Thu, 20 May 2010 21:52:50 +0300
Message-ID: <20100520185249.GB25089@gandalf>
References: <1274090554-19420-1-git-send-email-felipe.balbi@nokia.com>
 <1274090554-19420-2-git-send-email-felipe.balbi@nokia.com>
 <20100520110600.be702f58.akpm@linux-foundation.org>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100520110600.be702f58.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, May 20, 2010 at 11:06:00AM -0700, Andrew Morton wrote:
> nitlet: I suspect this function is taking gpio_lock sooner than it
> strictly needs to.  Find-tuning that would decrease contention by an
> insignificant amount ;)

heh, I can post another version if you like, but this is pretty much
what other functions are doing, just following the 'standard'.

-- 
balbi
