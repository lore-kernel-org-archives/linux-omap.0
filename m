From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/6] HSI: omap_ssi: fix module unloading
Date: Mon, 2 May 2016 09:06:33 +0200
Message-ID: <20160502070633.GF13215@amd>
References: <1461982153-19139-1-git-send-email-sre@kernel.org>
 <1461982153-19139-3-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461982153-19139-3-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Sat 2016-04-30 04:09:09, Sebastian Reichel wrote:
> Removal of ssi controller debugfs directory must
> happen after the clients have been removed from
> it.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
