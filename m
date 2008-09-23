From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: NULL pointer dereference when using ALSA SOC
Date: Tue, 23 Sep 2008 11:50:53 +0300
Message-ID: <20080923115053.e404f43e.jarkko.nikula@nokia.com>
References: <dfeb90390809222326s44162f94sf42f96fdfc0a0690@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:58019 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbYIWIvR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Sep 2008 04:51:17 -0400
In-Reply-To: <dfeb90390809222326s44162f94sf42f96fdfc0a0690@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Arun KS <getarunks@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 23 Sep 2008 11:56:00 +0530
"ext Arun KS" <getarunks@gmail.com> wrote:

> Hi all,
> 
> I am writing an ASOC driver for tlvaic23 on osk5912 platform.
> When do an aplay, I m getting a  NULL pointer dereference. I added
> some debug prints in the soc/core/pcm_native.c, also in codec and
> platform drivers. The null pointer is comming in IOCTL SNDRV_PCM_IOCTL_SYNC_PTR.
> Log is pasted below.
> 
It's good that you can reproduce this on OSK as well.

I think some configuration difference is revealing this bug out. For instance I can trigger this on Beagle with overo_defconfig + manually adding support for Beagle (CONFIG_MACH_OMAP3_BEAGLE=y) and ASoC Beagle (CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE=y).

But I cannot reproduce this with Beagle defconfig + manually adding support for Overo (CONFIG_MACH_OVERO=y) and ASoC Beagle (CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE=y).

I'm using up-to-date l-o with following patches:

Author: Jarkko Nikula <jarkko.nikula@nokia.com>
Date:   Fri Sep 19 16:36:38 2008 +0300

    ARM: OMAP: Fixes to omap_mcbsp_request function

Author: Jarkko Nikula <jarkko.nikula@nokia.com>
Date:   Tue Sep 16 15:56:53 2008 +0300

    ARM: OMAP: Add RX/TX interrupts for 2430 and 34xx McBSP ports 3-5

Author: ext Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue Sep 16 23:51:35 2008 +0300

    alsa: add Beagleboard SoC configuration.


I don't know is this configuration difference necessarily related to sound since I tried to modify N810 sound configuration similar to Overo defconfig but wasn't able to reproduce. Have to continue hunting.


Jarkko
