From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mfd: Add TWL4030 PWM driver
Date: Wed, 21 Mar 2012 08:39:06 +0000
Message-ID: <201203210839.06258.arnd@arndb.de>
References: <1332262083-9375-1-git-send-email-walle@corscience.de> <201203202202.12060.arnd@arndb.de> <4F697201.1090206@bwalle.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:57337 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755640Ab2CUIjN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 04:39:13 -0400
In-Reply-To: <4F697201.1090206@bwalle.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bernhard Walle <bernhard@bwalle.de>
Cc: Bernhard Walle <walle@corscience.de>, sameo@linux.intel.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Thierry Reding <thierry.reding@avionic-design.de>

On Wednesday 21 March 2012, Bernhard Walle wrote:
> Am 20.03.12 23:02, schrieb Arnd Bergmann:
> > On Tuesday 20 March 2012, Bernhard Walle wrote:
> >>
> >> This PWM driver uses the PWM of the TWL4030. The driver for the TWL6030
> >> PWM has been used as mode, but the PWM registers are different.
> >>
> >> The driver can be used and has been tested in conjunction with
> >> pwm-backlight to control a backlight LED of a LCD touch screen.
> >>
> >> Signed-off-by: Bernhard Walle <walle@corscience.de>
> > 
> > Since it's too late for v3.4 now and we will get a new pwm
> > subsystem in v3.5, I suggest you change the driver to work
> > register with that subsystem instead of just using the old
> > header file. Note that drivers/mfd is not really the right
> > place anyway, because this is not a multifunction driver but
> > just one device driver that happens to be a slave of an mfd.
> 
> Does that new subsystem already exist in some tree?
 
Thierry Reding has been busily posting patches, so he probably has
one that you can use, but I couldn't find it now.

	Arnd
