From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/5] HSI: ssi-protocol: export modem info via sysfs
Date: Sun, 31 Jan 2016 18:36:05 +0100
Message-ID: <20160131173605.GD3721@amd>
References: <1454203187-688-1-git-send-email-sre@kernel.org>
 <1454203187-688-4-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454203187-688-4-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sun 2016-01-31 02:19:45, Sebastian Reichel wrote:
> Currently userspace knows about the rapuyama version by
> checking, which gpios have been exported. This does no
> longer work with kernel based power management, so export
> a sysfs file, which provides the rapuyama generation. Also

Umm. So patches 1-2 make it impossible for existing userspace to
detect modem version?

Even if we re-add the capability with this patch, that makes it bad
idea, no?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
