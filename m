From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 4/6] HSI: omap_ssi: fix removal of port platform device
Date: Sun, 1 May 2016 11:41:30 +0200
Message-ID: <20160501094130.GD14243@amd>
References: <1461982153-19139-1-git-send-email-sre@kernel.org>
 <1461982153-19139-5-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461982153-19139-5-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Sat 2016-04-30 04:09:11, Sebastian Reichel wrote:
> This avoids removal of the HSI port device when
> only the platform port device should be removed
> and clears the POPULATED bit in the DT node, so
> that a new platform device is created when the
> driver is probed again.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

3,4: Acked-by: Pavel Machek <pavel@ucw.cz>


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
