From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP3 & USB NFS root
Date: Wed, 16 Feb 2011 10:02:27 +0200
Message-ID: <20110216080227.GB2497@legolas.emea.dhcp.ti.com>
References: <1297691206.2951.8.camel@deskari>
 <20110214134842.GH2549@legolas.emea.dhcp.ti.com>
 <1297692039.2951.10.camel@deskari>
 <20110214140216.GJ2549@legolas.emea.dhcp.ti.com>
 <1297838666.2031.8.camel@deskari>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:33906 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751532Ab1BPICc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 03:02:32 -0500
Received: by mail-bw0-f49.google.com with SMTP id 5so1223735bwz.8
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 00:02:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1297838666.2031.8.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Wed, Feb 16, 2011 at 08:44:26AM +0200, Tomi Valkeinen wrote:
> > ah, ok. So it's another problem. I don't have beagle, but I have an old
> > overo here. Will try tomorrow to see what's going on. Thanks for the
> > report.
> 
> Did you get a chance to try this? Or any suggestions what I could try? I
> could of course try to bisect it, but that's quite laborious as I have
> to store the kernel into an mmc to be able to use it.

I'm trying to get my overo to work. MMC doesn't seem to be working on
u-boot again:

Overo # mmc rescan 0
Overo # fatload mmc 0 82000000 uImage
reading uImage
mmc_send_cmd: timedout waiting for cmddis!
mmc fail to send stop cmd
mmc_send_cmd: timedout waiting for cmddis!
Invalid FAT entry

952320 bytes read
Overo # 

u-boot's HEAD is efb063390d2d1e712c2c8110911616244d562c4b

-- 
balbi
