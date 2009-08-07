From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 2/8] Regulator: Adding header file for TPS65023
Date: Fri, 7 Aug 2009 23:25:37 +0300
Message-ID: <20090807202537.GD9780@nokia.com>
References: <1249658736-10811-1-git-send-email-anuj.aggarwal@ti.com>
 <20090807155558.GJ639@sirena.org.uk>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62408 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933701AbZHGUYd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 16:24:33 -0400
Content-Disposition: inline
In-Reply-To: <20090807155558.GJ639@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Anuj Aggarwal <anuj.aggarwal@ti.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org

On Fri, Aug 07, 2009 at 05:55:58PM +0200, ext Mark Brown wrote:
> On Fri, Aug 07, 2009 at 08:55:36PM +0530, Anuj Aggarwal wrote:
> 
> This is OK but since you'll need to resubmit anyway it might be nice to
> consider moving the register & bitfield definitions into the driver file
> since they can't be used by any other code.
> 
> > +/* DCDC's */
> 
> Extra ' here :)

I agree, there shouldn't be need for this file.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
