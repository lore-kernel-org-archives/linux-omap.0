From: Evgeniy Polyakov <zbr@ioremap.net>
Subject: Re: [PATCH] w1-gpio: Simplify & get rid of defines
Date: Mon, 5 Nov 2012 19:47:45 +0400
Message-ID: <20121105154745.GB12922@ioremap.net>
References: <1351699064-4619-1-git-send-email-panto@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1351699064-4619-1-git-send-email-panto@antoniou-consulting.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: linux-kernel@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>, Matt Porter <mporter@ti.com>, Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi

On Wed, Oct 31, 2012 at 05:57:44PM +0200, Pantelis Antoniou (panto@antoniou-consulting.com) wrote:
> There's no reason to have the OF defines; it complicates the driver.
> There's also no need for the funky platform_driver_probe.
> 
> Add a few warnings in case there's a failure; helps us find out
> what went wrong.
> 
> Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>

Looks good to me, but I'm hardly an expert in omap platform.
Feel free to add my ack, but please submit this patch through
appropriate tree.
Thank you.

Acked-by: Evgeniy Polyakov <zbr@ioremap.net>

-- 
	Evgeniy Polyakov
