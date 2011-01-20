From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [HELP-OMAP-SERAIL] beagleboard-xM can't boot up after update
 to kernel-2.6.37
Date: Thu, 20 Jan 2011 12:03:21 +0530
Message-ID: <20110120063321.GA10094@m-desktop>
References: <AANLkTikFb7WTfCOD_GUnA=RZ22Q5_5QSDRTbcoLMtdYM@mail.gmail.com>
 <20110119110607.GA30211@legolas.emea.dhcp.ti.com>
 <AANLkTimByz+gc8X9uaVfUUGU+V9V-Og2U9xZQhca7P5b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:41903 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751053Ab1ATGfE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Jan 2011 01:35:04 -0500
Received: by mail-yx0-f175.google.com with SMTP id 5so84582yxd.6
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 22:35:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTimByz+gc8X9uaVfUUGU+V9V-Og2U9xZQhca7P5b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bob Liu <lliubbo@gmail.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, "G, Manjunath Kondaiah" <manjugk@ti.com>, Abdoulaye Walsimou GAYE <awg@embtoolkit.org>

On Thu, Jan 20, 2011 at 01:32:24PM +0800, Bob Liu wrote:
> On Wed, Jan 19, 2011 at 7:06 PM, Felipe Balbi <balbi@ti.com> wrote:
> > Hi,
> >
> > On Wed, Jan 19, 2011 at 06:57:33PM +0800, Bob Liu wrote:
> >> Any ideas?
> >
> > s/console=ttyS2,115200n8/console=ttyO2,115200n8/
> >
> > on your CMDLINE.
> >
> 
> Yeah, that work! Thanks!
> 
> But my system still can't enter shell, I have changed /etc/inittab
> from "tty0::respawn:/sbin/getty -L ttyS2 115200 vt102" to
> "tty0::respawn:/sbin/getty -L ttyO2 115200 vt102", and also have added
> ttyO2 to /etc/securetty.
Looks like file system issue. You can try with below fs:
http://code.google.com/p/beagleboard/downloads/detail?name=ALSA-FS.tar.gz&can=2&q=

No need to edit /etc/inittab with above fs since ttyO2 is mapped to
console device file under /dev

-Manjunath
