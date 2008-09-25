From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: NULL pointer dereference when using ALSA SOC
Date: Thu, 25 Sep 2008 14:05:31 +0300
Message-ID: <20080925140531.64fd14c9.jarkko.nikula@nokia.com>
References: <dfeb90390809222326s44162f94sf42f96fdfc0a0690@mail.gmail.com>
	<20080923115053.e404f43e.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:33068 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753173AbYIYLGE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 07:06:04 -0400
In-Reply-To: <20080923115053.e404f43e.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Arun KS <getarunks@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, sakoman@gmail.com

On Tue, 23 Sep 2008 11:50:53 +0300
"ext Jarkko Nikula" <jarkko.nikula@nokia.com> wrote:

> On Tue, 23 Sep 2008 11:56:00 +0530
> "ext Arun KS" <getarunks@gmail.com> wrote:
> 
> > Hi all,
> > 
> > I am writing an ASOC driver for tlvaic23 on osk5912 platform.
> > When do an aplay, I m getting a  NULL pointer dereference. I added
> > some debug prints in the soc/core/pcm_native.c, also in codec and
> > platform drivers. The null pointer is comming in IOCTL
> > SNDRV_PCM_IOCTL_SYNC_PTR. Log is pasted below.
> > 
> It's good that you can reproduce this on OSK as well.
> 
> I think some configuration difference is revealing this bug out. For
> instance I can trigger this on Beagle with overo_defconfig + manually
> adding support for Beagle (CONFIG_MACH_OMAP3_BEAGLE=y) and ASoC
> Beagle (CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE=y).
> 
> But I cannot reproduce this with Beagle defconfig + manually adding
> support for Overo (CONFIG_MACH_OVERO=y) and ASoC Beagle
> (CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE=y).
> 
I narrowed this into CONFIG_SLUB. When it's set, I can reproduce the
bug both with N810 and Beagle but not when using CONFIG_SLAB.

Can you try will the problem disappear on your OSK and Overo if you
select slab allocator instead? You find selection under "General
setup" menu.


Jarkko
