From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/5] HSI: nokia-modem: kernel based PM
Date: Sun, 31 Jan 2016 18:29:48 +0100
Message-ID: <20160131172948.GC3721@amd>
References: <1454203187-688-1-git-send-email-sre@kernel.org>
 <1454203187-688-3-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454203187-688-3-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi!

> So far power management had to be done in uerspace using exported

"userspace"

> This patch adds kernel based power management, which will bind the
> modem's power state to the state of the phonet network interface.

Ok, so I have ofonod that already does power management in
userspace. What happens when power management is done twice?

Best regards,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
