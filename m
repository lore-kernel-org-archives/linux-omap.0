From: Felipe Balbi <balbi@ti.com>
Subject: Re: [HELP-OMAP-SERAIL] beagleboard-xM can't boot up after update
 to kernel-2.6.37
Date: Thu, 20 Jan 2011 08:50:29 +0200
Message-ID: <20110120065029.GH2389@legolas.emea.dhcp.ti.com>
References: <AANLkTikFb7WTfCOD_GUnA=RZ22Q5_5QSDRTbcoLMtdYM@mail.gmail.com>
 <20110119110607.GA30211@legolas.emea.dhcp.ti.com>
 <AANLkTimByz+gc8X9uaVfUUGU+V9V-Og2U9xZQhca7P5b@mail.gmail.com>
 <20110120063321.GA10094@m-desktop>
 <AANLkTi=9yAGvOLyBBHkeNL4-HJgVL2FKqKuW1tpqDoMu@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:54643 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752481Ab1ATGuj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Jan 2011 01:50:39 -0500
Received: by yws5 with SMTP id 5so73502yws.30
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 22:50:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=9yAGvOLyBBHkeNL4-HJgVL2FKqKuW1tpqDoMu@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bob Liu <lliubbo@gmail.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, balbi@ti.com, linux-omap@vger.kernel.org, Abdoulaye Walsimou GAYE <awg@embtoolkit.org>

Hi,

On Thu, Jan 20, 2011 at 02:46:47PM +0800, Bob Liu wrote:
> Yeah, I also think it's file system issue. I added major and minor
> number to omap-serial driver, it fix the problem temporary.
> 
> > No need to edit /etc/inittab with above fs since ttyO2 is mapped to
> > console device file under /dev
> 
> Do you know how to do this map during build a fs?
> Thanks.

which FS do you use ? I use a debootstrap generally :-p

-- 
balbi
