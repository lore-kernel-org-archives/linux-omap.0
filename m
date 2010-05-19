From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] touchscreen: ads7846: please don't touch free'd memory
Date: Tue, 18 May 2010 17:00:20 -0700
Message-ID: <20100519000019.GA17475@core.coreip.homeip.net>
References: <1274226413-8520-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1274226413-8520-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-input-owner@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org, Michael Roth <mroth@nessie.de>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Mike Frysinger <vapier@gentoo.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, May 18, 2010 at 04:46:53PM -0700, Kevin Hilman wrote:
> If the _probe() method fails, the 'ts' struct is freed, yet it is
> still used as the drvdata passed to suspend/resume/remove methods.
> Even though the input device does not get registerd, the driver's
> suspend/resume methods still get called as it's a registered SPI
> device.  This patch adds sanity checks to these methods to ensure that
> drvdata is valid before using it.
> 

This is a load of crap. If probe() fails that means that driver does not
manage the device and thus ads7846_suspend() and ads7846_resume() should
not be called _at all_. If SPI core manages to call random methods from
the drivers that failed to bind to a device that should be fixed in SPI
core.

Thanks.

-- 
Dmitry
