From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/2] Include TPS6235x based Power regulator support
Date: Wed, 14 Jan 2009 10:40:22 -0800
Message-ID: <200901141040.22889.david-b@pacbell.net>
References: <1231832468-7132-1-git-send-email-mani.pillai@ti.com> <200901140955.58616.david-b@pacbell.net> <20090114181035.GC8108@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:34500 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752986AbZANSkZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Jan 2009 13:40:25 -0500
In-Reply-To: <20090114181035.GC8108@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: "Pillai, Manikandan" <mani.pillai@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wednesday 14 January 2009, Mark Brown wrote:
> On Wed, Jan 14, 2009 at 09:55:58AM -0800, David Brownell wrote:
> 
> > problem vanishes.  Only the tps6235x.c driver, and in this case
> > the regulator framework (sigh), care about that platform_data. 
> 
> The regulator framework will be fixed in .30.

That'll be nice, thanks.  Good to be consistent, and
stick to the policy that platform_data is *only* for
use by the device's driver.

- Dave
