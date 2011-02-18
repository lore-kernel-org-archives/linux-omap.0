From: Felipe Balbi <balbi@ti.com>
Subject: Re: [patch-v2.6.39 6/7] OMAP4430: hwmod data: Adding USBOTG
Date: Fri, 18 Feb 2011 17:41:35 +0200
Message-ID: <20110218154135.GF11151@legolas.emea.dhcp.ti.com>
References: <20110217162000.GP20795@atomide.com>
 <20110217162209.GA13425@legolas.emea.dhcp.ti.com>
 <20110217165953.GR20795@atomide.com>
 <4D5D5770.9020501@ti.com>
 <20110217171747.GC14574@legolas.emea.dhcp.ti.com>
 <4D5D59E5.6020307@ti.com>
 <20110217173711.GF14574@legolas.emea.dhcp.ti.com>
 <4D5D5F13.2010602@ti.com>
 <20110217181849.GV20795@atomide.com>
 <4D5E7DFF.7020609@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:40167 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752528Ab1BRPlk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Feb 2011 10:41:40 -0500
Received: by mail-bw0-f45.google.com with SMTP id 16so3916697bwz.18
        for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 07:41:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D5E7DFF.7020609@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "Balbi, Felipe" <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, "Kalliguddi, Hema" <hemahk@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, "Raja, Govindraj" <govindraj.raja@ti.com>

Hi all,

On Fri, Feb 18, 2011 at 03:11:11PM +0100, Cousson, Benoit wrote:
> On 2/17/2011 7:18 PM, Tony Lindgren wrote:
> > * Cousson, Benoit<b-cousson@ti.com>  [110217 09:45]:
> >>
> >> Done, boot tested, and that does remove the warning about the
> >> missing opt clock you had with the previous data.
> >>
> >> git://gitorious.org/omap-pm/linux.git for_2.6.39/omap4_hwmod_data
> >>
> >> Just let me know if it does break anything else.
> > 
> > Pulled into omap-for-linus. Also now merged are the devel-hwspinlock
> > and devel-mcspi branches.
> 
> McSPI OMAP4 hwmod data are missing a couple of flags that break the boot for the moment.
> 
> Govindraj should rebase on the omap4_hwmod_data branch and add the missing rev and dev_attr for the McSPI.
> 
> Unfortunately, even with that patch omap-for-linus boot hangs after the following trace:
> 
> [    0.875091] omap_device: omap2_mcspi.1: new worst case activate latency 0: 30517
> [    0.886657] usbcore: registered new interface driver usbfs
> [    0.892822] usbcore: registered new interface driver hub
> [    0.898681] usbcore: registered new device driver usb
> [    0.904815] omap_i2c omap_i2c.1: bus 1 rev4.0 at 400 kHz

I tested your branch merged with mine and it was working fine. What else
is on omap-for-linus ? There are only 28 patches on that branch, a
bisect would be quick ?

-- 
balbi
