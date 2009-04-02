From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH 3/4] ARM: OMAP3: Add support for 3430 SDP, v3
Date: Thu, 2 Apr 2009 10:03:45 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702EA9669B3@dbde02.ent.ti.com>
References: <20090331184802.GA27745@n2100.arm.linux.org.uk>
	<5A47E75E594F054BAF48C5E4FC4B92AB02FB086086@dbde02.ent.ti.com>
	<0680EC522D0CC943BC586913CF3768C0036E7EF891@dbde02.ent.ti.com>
	<alpine.DEB.2.00.0904011301320.9879@utopia.booyaka.com>
	<20090401220745.GJ32530@atomide.com> <87ocvghsk7.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41685 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751010AbZDBEeH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Apr 2009 00:34:07 -0400
In-Reply-To: <87ocvghsk7.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin
>Hilman
>> > >
>>> > Anand,
>>> >
>>> > It looks like the timers are not configured properly or the timer selection has gone wrong. Can
>you just compare your previous working defconfig with this and correct the GPTIMER selection?
>>>
>>> As an aside, I'm seeing the same thing with mainline and Beagle.  It does
>>> not seem to matter whether the 32k timer or sys_clk is used as the GPTIMER
>>> source.  Also it does not seem to matter whether GPTIMER1 or GPTIMER12 is
>>> configured.  Looks like some kind of GPTIMER or GPTIMER-related interrupt
>>> problem.  Have not had the chance to isolate the exact problem yet, so,
>>> other comments welcome.
>>
>> Not seeing this on overo at least.
>>
>
>And my Beagle is booting fine with mainline and attached .config.

Got many choices to choose for .config if I use SDP or LDP defconfigs - 
omap_3430sdp_defconfig
omap_ldp_defconfig

Looks like these have not been up-to-date. Not sure which options to choose for these boards.

Eg:
System V IPC (SYSVIPC) [Y/n/?] y
POSIX Message Queues (POSIX_MQUEUE) [N/y/?] (NEW) ???

OMAP PM layer selection
  1. No PM layer (OMAP_PM_NONE) (NEW)
> 2. No-op/debug PM layer (OMAP_PM_NOOP) (NEW)
  3. PM layer implemented using SRF (OMAP_PM_SRF) (NEW)
choice[1-3]:


>
>Kevin

