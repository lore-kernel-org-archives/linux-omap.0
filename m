From: Matthias Kaehlcke <matthias@kaehlcke.net>
Subject: Re: [PATCH v3] backlight: Add TPS65217 WLED driver
Date: Thu, 23 Aug 2012 12:25:36 +0200
Message-ID: <20120823102536.GA27787@darwin>
References: <20120822210419.GA6235@darwin>
 <331ABD5ECB02734CA317220B2BBEABC13EA1E90E@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:43172 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932718Ab2HWK0t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Aug 2012 06:26:49 -0400
Content-Disposition: inline
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA1E90E@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi AnilKumar,

thanks for your comments

El Thu, Aug 23, 2012 at 07:53:49AM +0000 AnilKumar, Chimata ha dit:

> This patch should divide into 2 patches, one patch meant for
> MFD changes other for backlight.

will do

> > +struct tps65217_bl {
> > +	struct tps65217 *tps;
> > +	struct device *dev;
> > +	struct backlight_device *bl;
> > +	int on;
> 
> Can you use Boolean here? Change the name as well, something
> like bool is_enabled?

ok

> > +	pdata->fdim = TPS65217_BL_FDIM_200HZ;
> 
> Why 200 by default?

it's the default value in the register after reset

best regards

-- 
Matthias Kaehlcke
Embedded Linux Developer
Amsterdam

                If you don't know where you are going,
               you will probably end up somewhere else
                         (Laurence J. Peter)
                                                                 .''`.
    using free software / Debian GNU/Linux | http://debian.org  : :'  :
                                                                `. `'`
gpg --keyserver pgp.mit.edu --recv-keys 47D8E5D4                  `-
