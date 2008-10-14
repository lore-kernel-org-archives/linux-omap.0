From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 6/8] tsl2563: move tsl2563 to drivers/hwmon
Date: Tue, 14 Oct 2008 16:52:30 +0300
Message-ID: <20081014135230.GA28019@gandalf.research.nokia.com>
References: <1223989300-27294-1-git-send-email-felipe.balbi@nokia.com> <1223989300-27294-2-git-send-email-felipe.balbi@nokia.com> <1223989300-27294-3-git-send-email-felipe.balbi@nokia.com> <1223989300-27294-4-git-send-email-felipe.balbi@nokia.com> <1223989300-27294-5-git-send-email-felipe.balbi@nokia.com> <1223989300-27294-6-git-send-email-felipe.balbi@nokia.com> <1223989300-27294-7-git-send-email-felipe.balbi@nokia.com> <20081014153824.3722411c@hyperion.delvare>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:49262 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794AbYJNNxn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 09:53:43 -0400
Content-Disposition: inline
In-Reply-To: <20081014153824.3722411c@hyperion.delvare>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jean Delvare <khali@linux-fr.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Tue, Oct 14, 2008 at 03:38:24PM +0200, ext Jean Delvare wrote:
> Hi Felipe,
> 
> On Tue, 14 Oct 2008 16:01:38 +0300, Felipe Balbi wrote:
> > Moving the driver to where it should sit. No functional
> > changes.
> > 
> > Cc: Jean Delvare <khali@linux-fr.org>
> > Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> > ---
> >  drivers/hwmon/Kconfig                  |   10 ++++++++++
> >  drivers/hwmon/Makefile                 |    1 +
> >  drivers/{i2c/chips => hwmon}/tsl2563.c |    2 +-
> >  drivers/i2c/chips/Kconfig              |   10 ----------
> >  drivers/i2c/chips/Makefile             |    1 -
> >  5 files changed, 12 insertions(+), 12 deletions(-)
> >  rename drivers/{i2c/chips => hwmon}/tsl2563.c (99%)
> > 
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 390c6fa..dabc148 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -670,6 +670,16 @@ config SENSORS_THMC50
> >  	  This driver can also be built as a module.  If so, the module
> >  	  will be called thmc50.
> >  
> > +config SENSORS_TSL2563
> > +       tristate "Taos TSL2563 ambient light sensor"
> > +       depends on I2C && HWMON
> > +       help
> > +         If you say yes here you get support for the Taos TSL2563
> > +         ambient light sensor.
> > +
> > +         This driver can also be built as a module.  If so, the module
> > +         will be called tsl2563.
> > +
> >  config SENSORS_VIA686A
> >  	tristate "VIA686A"
> >  	depends on PCI
> 
> Nack. Light sensors have nothing to do with hardware monitoring.
> 
> The only light sensor driver in the kernel tree at the moment
> is drivers/i2c/chips/tsl2550.c. But I'm not very happy with this
> either, as my ultimate goal is to delete the drivers/i2c/chips
> directory completely. So we should find a new home for light sensors.

and that's why I'm moving nokia drivers out of drivers/i2c/chips
directory.

> Maybe they should go into the new "industrial I/O" subsystem. Or if
> not, their own drivers/sensors/light directory.

Well, could be. We might need someone else, like Andrew, to answer that
question.

Andrew, do you have any comments if we should create a directory for
light sensors ? In that case, looks like we're gonna need some
abstraction layer, right ?

-- 
balbi
