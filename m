From: "Koyamangalath, Abhilash" <abhilash.kv@ti.com>
Subject: RE: watchdog pdev id set to -1
Date: Fri, 18 Feb 2011 16:39:48 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703700616CE@dbde02.ent.ti.com>
References: <FCCFB4CDC6E5564B9182F639FC3560870370061699@dbde02.ent.ti.com>
 <20110218105635.GB10489@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60099 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699Ab1BRLJ5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Feb 2011 06:09:57 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1IB9sjZ008824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 05:09:56 -0600
In-Reply-To: <20110218105635.GB10489@legolas.emea.dhcp.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I understand, but is there a subtle reason why are starting from
an erroneous-looking -1 rather than a more natural 0 (or 1 ?).


> -----Original Message-----
> From: Balbi, Felipe
> Sent: Friday, February 18, 2011 4:27 PM
> To: Koyamangalath, Abhilash
> Cc: linux-omap@vger.kernel.org
> Subject: Re: watchdog pdev id set to -1
> 
> Hi,
> 
> (your lines are over 80-characters, fix it)
> 
> On Fri, Feb 18, 2011 at 04:11:11PM +0530, Koyamangalath, Abhilash wrote:
> > There this boot-time message (on both omap3 and am3517 evms atleast):
> > [    1.904418] omap_device: omap_wdt.-1: new worst case activate
> > latency 0: 6105
> >
> > omap_init_wdt() initializes the id to -1 and then omap_device_build()
> > is called with this value; this eventually calls
> > platform_device_register() with a pdev having id as -1. I don't see
> > any code that checks for this -1 and changes it to a non-erroneous
> > value.
> >
> > Perhaps there is a reason I've failed to notice?  Please comment.
> > Else I'm planning to submit a patch which fixes this.
> 
> That's not an error value. If you have a -1 ID, you're only telling the
> kernel "this is only omap_wdt platform_device I have", which means that
> it will look in sysfs as:
> 
> /sys/devices/platform/omap_wdt/
> 
> if you have an ID >= 0, it will look as:
> 
> /sys/devices/platform/omap_wdt.0/
> /sys/devices/platform/omap_wdt.1/
> /sys/devices/platform/omap_wdt.2/
> 
> etc, that's all.
> 
> --
> balbi
