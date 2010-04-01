From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/2] [STAGING] Synaptic Touchscreen Driver
Date: Thu, 1 Apr 2010 18:34:50 +0200
Message-ID: <20100401163450.GC1520@ucw.cz>
References: <37368.10.24.255.17.1270127772.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <37368.10.24.255.17.1270127772.squirrel@dbdmail.itg.ti.com>
Sender: linux-input-owner@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: gregkh@suse.de, devel@driverdev.osuosl.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu 2010-04-01 18:46:12, Hemanth V wrote:
> This series of 2 patches are for the synaptic
> touchscreen driver in staging. This adds
> support for threaded irq and some cleanup.

Thanks!

You probably want to post full source of syn*_i2c_rmi.c here, so that
it gets review, and may be moved to drivers/input in 2.6.35...

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
