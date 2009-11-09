From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: Re: Driver Merge Questions
Date: Mon, 9 Nov 2009 11:26:21 +0200
Message-ID: <20091109092621.GY1773@smtp.gmail.com>
References: <4AF040D1.7020109@kionix.com>
 <20091103165821.GG8981@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:54485 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754780AbZKIJ0c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Nov 2009 04:26:32 -0500
Received: by bwz27 with SMTP id 27so3208711bwz.21
        for <linux-omap@vger.kernel.org>; Mon, 09 Nov 2009 01:26:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091103165821.GG8981@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Chris Hudson <chudson@kionix.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 09 Nov 03, Tony Lindgren wrote:
> * Chris Hudson <chudson@kionix.com> [091103 06:48]:
> > Hello all,
> > 
> > I've never submitted any software to Linux before, but I've been
> > working on some new accelerometer drivers that should be ready for
> > review soon (pending company approval).  I've read lots of
> > documentation on patch and driver submissions, but I still have some
> > questions that I was hoping someone could help me find the answers
> > to.
> > 
> > 1- My drivers use i2c for hardware communications, miscdevice for
> > IOCTLs, and input_dev for data and interrupt status outputs.  Most
> > of the other accelerometer drivers that I've looked at use similar
> > designs and are located in drivers/hwmon, but I just wanted to
> > confirm that this is the correct location currently.
> 
> Sounds correct.

Unfortunately it will probably get rejected in drivers/hwmon. The maintainer,
Jean Delavare wants them out of hwmon[1]. It seems that everyone (for the
moment) is leaning towards a new subsystem called industrial IO
(drivers/staging/iio) for such drivers.

Please ask Jean before you do the work to make your driver behave like a hwmon
driver.

Regards,
Amit


[1] http://lkml.org/lkml/2009/7/2/153
-- 
-------------------------------------------------------------------------
Amit Kucheria,				 Kernel Developer, Verdurent
-------------------------------------------------------------------------
