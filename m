From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC][PATCH] ARM: OMAP: McBSP: Use register cache
Date: Fri, 4 Sep 2009 12:34:05 +0200
Message-ID: <200909041234.06121.jkrzyszt@tis.icnet.pl>
References: <1252042776.23177.39.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:55533 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753067AbZIDKer (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Sep 2009 06:34:47 -0400
In-Reply-To: <1252042776.23177.39.camel@eenurkka-desktop>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext-eero.nurkkala@nokia.com
Cc: linux-omap@vger.kernel.org, e3-hacking@earth.li

Friday 04 September 2009 07:39:36 Eero Nurkkala wrote:
>
> Register values should not get corrupted. Could you please point out the
> registers that may get corrupted? Do they get corrupted during audio
> play? I haven't seen corrupted register values.
>

Hi Eero,

Please have a look at some debug log lines below. Those were generated on my
Amstrad Delta videophone, using an application (asterisk softpbx with alsa
channel) that can restart a receiver of a prevoiusly requested McBSP by
calling omap_mcbsp_start() on user request. As you can see, corrupted values
can happen to get read from any register that is expected to return
predictable results.

Sep  4 08:21:17 amsdelta user.debug kernel: [309910.170000] omap-mcbsp omap-mcbsp.1: mcbsp: **** McBSP1 regs ****
Sep  4 08:21:17 amsdelta user.debug kernel: [309910.170000] omap-mcbsp omap-mcbsp.1: mcbsp: DRR2:  0x1000
Sep  4 08:21:17 amsdelta user.debug kernel: [309910.170000] omap-mcbsp omap-mcbsp.1: mcbsp: DRR1:  0x009d
Sep  4 08:21:17 amsdelta user.debug kernel: [309910.170000] omap-mcbsp omap-mcbsp.1: mcbsp: DXR2:  0x3000
Sep  4 08:21:17 amsdelta user.debug kernel: [309910.170000] omap-mcbsp omap-mcbsp.1: mcbsp: DXR1:  0x7da1
Sep  4 08:21:17 amsdelta user.debug kernel: [309910.170000] omap-mcbsp omap-mcbsp.1: mcbsp: SPCR2: 0x02f0
Sep  4 08:21:17 amsdelta user.debug kernel: [309910.170000] omap-mcbsp omap-mcbsp.1: mcbsp: SPCR1: 0x7031
Sep  4 08:21:17 amsdelta user.debug kernel: [309910.170000] omap-mcbsp omap-mcbsp.1: mcbsp: RCR2:  0x0045
Sep  4 08:21:17 amsdelta user.debug kernel: [309910.170000] omap-mcbsp omap-mcbsp.1: mcbsp: RCR1:  0x0040
Sep  4 08:21:17 amsdelta user.debug kernel: [309910.170000] omap-mcbsp omap-mcbsp.1: mcbsp: XCR2:  0x1045
Sep  4 08:21:17 amsdelta user.debug kernel: [309910.170000] omap-mcbsp omap-mcbsp.1: mcbsp: XCR1:  0x0040
Sep  4 08:21:17 amsdelta user.debug kernel: [309910.170000] omap-mcbsp omap-mcbsp.1: mcbsp: SRGR2: 0x310f
Sep  4 08:21:17 amsdelta user.debug kernel: [309910.170000] omap-mcbsp omap-mcbsp.1: mcbsp: SRGR1: 0x0000
Sep  4 08:21:17 amsdelta user.debug kernel: [309910.170000] omap-mcbsp omap-mcbsp.1: mcbsp: PCR0:  0x0003
Sep  4 08:21:17 amsdelta user.debug kernel: [309910.170000] omap-mcbsp omap-mcbsp.1: mcbsp: ***********************
Sep  4 08:21:19 amsdelta user.debug kernel: [309912.050000] omap-mcbsp omap-mcbsp.1: mcbsp: **** McBSP1 regs ****
Sep  4 08:21:19 amsdelta user.debug kernel: [309912.050000] omap-mcbsp omap-mcbsp.1: mcbsp: DRR2:  0x0000
Sep  4 08:21:19 amsdelta user.debug kernel: [309912.050000] omap-mcbsp omap-mcbsp.1: mcbsp: DRR1:  0x1086
Sep  4 08:21:19 amsdelta user.debug kernel: [309912.050000] omap-mcbsp omap-mcbsp.1: mcbsp: DXR2:  0x0000
Sep  4 08:21:19 amsdelta user.debug kernel: [309912.050000] omap-mcbsp omap-mcbsp.1: mcbsp: DXR1:  0x7da1
Sep  4 08:21:19 amsdelta user.debug kernel: [309912.050000] omap-mcbsp omap-mcbsp.1: mcbsp: SPCR2: 0x02f0
Sep  4 08:21:19 amsdelta user.debug kernel: [309912.050000] omap-mcbsp omap-mcbsp.1: mcbsp: SPCR1: 0x0031
Sep  4 08:21:19 amsdelta user.debug kernel: [309912.050000] omap-mcbsp omap-mcbsp.1: mcbsp: RCR2:  0x1045
Sep  4 08:21:19 amsdelta user.debug kernel: [309912.050000] omap-mcbsp omap-mcbsp.1: mcbsp: RCR1:  0x1040
Sep  4 08:21:19 amsdelta user.debug kernel: [309912.050000] omap-mcbsp omap-mcbsp.1: mcbsp: XCR2:  0x3045
Sep  4 08:21:19 amsdelta user.debug kernel: [309912.050000] omap-mcbsp omap-mcbsp.1: mcbsp: XCR1:  0x1040
Sep  4 08:21:19 amsdelta user.debug kernel: [309912.050000] omap-mcbsp omap-mcbsp.1: mcbsp: SRGR2: 0x000f
Sep  4 08:21:19 amsdelta user.debug kernel: [309912.050000] omap-mcbsp omap-mcbsp.1: mcbsp: SRGR1: 0x0000
Sep  4 08:21:19 amsdelta user.debug kernel: [309912.050000] omap-mcbsp omap-mcbsp.1: mcbsp: PCR0:  0x1003
Sep  4 08:21:19 amsdelta user.debug kernel: [309912.050000] omap-mcbsp omap-mcbsp.1: mcbsp: ***********************
Sep  4 08:21:21 amsdelta user.debug kernel: [309913.950000] omap-mcbsp omap-mcbsp.1: mcbsp: **** McBSP1 regs ****
Sep  4 08:21:21 amsdelta user.debug kernel: [309913.950000] omap-mcbsp omap-mcbsp.1: mcbsp: DRR2:  0x1000
Sep  4 08:21:21 amsdelta user.debug kernel: [309913.950000] omap-mcbsp omap-mcbsp.1: mcbsp: DRR1:  0x109e
Sep  4 08:21:21 amsdelta user.debug kernel: [309913.950000] omap-mcbsp omap-mcbsp.1: mcbsp: DXR2:  0x1000
Sep  4 08:21:21 amsdelta user.debug kernel: [309913.950000] omap-mcbsp omap-mcbsp.1: mcbsp: DXR1:  0x7da1
Sep  4 08:21:21 amsdelta user.debug kernel: [309913.950000] omap-mcbsp omap-mcbsp.1: mcbsp: SPCR2: 0x02f0
Sep  4 08:21:21 amsdelta user.debug kernel: [309913.950000] omap-mcbsp omap-mcbsp.1: mcbsp: SPCR1: 0x1031
Sep  4 08:21:21 amsdelta user.debug kernel: [309913.950000] omap-mcbsp omap-mcbsp.1: mcbsp: RCR2:  0x1045
Sep  4 08:21:21 amsdelta user.debug kernel: [309913.950000] omap-mcbsp omap-mcbsp.1: mcbsp: RCR1:  0x1040
Sep  4 08:21:21 amsdelta user.debug kernel: [309913.950000] omap-mcbsp omap-mcbsp.1: mcbsp: XCR2:  0x2045
Sep  4 08:21:21 amsdelta user.debug kernel: [309913.950000] omap-mcbsp omap-mcbsp.1: mcbsp: XCR1:  0x1040
Sep  4 08:21:21 amsdelta user.debug kernel: [309913.950000] omap-mcbsp omap-mcbsp.1: mcbsp: SRGR2: 0x100f
Sep  4 08:21:21 amsdelta user.debug kernel: [309913.950000] omap-mcbsp omap-mcbsp.1: mcbsp: SRGR1: 0x1000
Sep  4 08:21:21 amsdelta user.debug kernel: [309913.950000] omap-mcbsp omap-mcbsp.1: mcbsp: PCR0:  0x2003
Sep  4 08:21:21 amsdelta user.debug kernel: [309913.950000] omap-mcbsp omap-mcbsp.1: mcbsp: ***********************

Those corruptions, even if should never happen, were actually caused by a
wireless adapter connected to the machine USB port. Extra piece of hardware,
very usefull in some cases, but obviously not taken into account while the
machine was being designed. While playback seems unaffected, WiFi noise in
capture stream prevents from using the videophone in speakerphone mode, but
in normal (handset) mode, the noise level seems still acceptable. The only
missing piece of a puzzle is my patch, that prevents the kernel driver from
putting corrupted values into the McBSP control registers.

That learned, please reconsider:
1. Can my patch break anything, related or not?
2. How does it affect performance of otherwise unaffected machines?
3. Is correcting a poorly designed machine behaviour worth of the change?

Thanks,
Janusz
