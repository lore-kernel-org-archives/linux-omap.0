From: Guenter Roeck <guenter.roeck@ericsson.com>
Subject: Re: [PATCH 6/6 V4] hwmon: OMAP4: On die temperature sensor driver
Date: Wed, 31 Aug 2011 18:49:39 -0700
Message-ID: <20110901014939.GB21986@ericsson.com>
References: <1314811510-15595-1-git-send-email-j-keerthy@ti.com>
 <1314811510-15595-7-git-send-email-j-keerthy@ti.com>
 <alpine.DEB.2.00.1108311810280.26173@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from imr3.ericy.com ([198.24.6.13]:37736 "EHLO imr3.ericy.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754672Ab1IABul (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Aug 2011 21:50:41 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1108311810280.26173@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Keerthy <j-keerthy@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Wed, Aug 31, 2011 at 08:36:43PM -0400, Paul Walmsley wrote:
> Hi
> 
> Some comments.
> 
> On Wed, 31 Aug 2011, Keerthy wrote:
> 
[ ... ]
> 
> > +}
> > +
> > +/* Sysfs hook functions */
> 
> These should be conditionally compiled out if sysfs isn't compiled in.
> 
The whole point of the hwmon subsystem is to expose hardware monitoring information
to userland using sysfs. hwmon without sysfs doesn't make sense.

So, if anything, it might make sense to disable the entire hwmon tree if sysfs is disabled.
But please no conditionals in the code.

Guenter
