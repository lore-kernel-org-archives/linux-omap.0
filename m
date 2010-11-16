From: "Nilofer, Samreen" <samreen@ti.com>
Subject: RE: [PATCH v3 0/2] OMAP3: Display Support
Date: Tue, 16 Nov 2010 09:02:41 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087034C101DD7@dbde02.ent.ti.com>
References: <1289801344-3100-1-git-send-email-samreen@ti.com>
 <1289832102.2668.22.camel@tubuntu> <20101115202047.GL9264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58565 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759254Ab0KPDcy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Nov 2010 22:32:54 -0500
In-Reply-To: <20101115202047.GL9264@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Mittal, Mukund" <mmittal@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>

Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@nokia.com> [101115 06:32]:
>> On Mon, 2010-11-15 at 07:09 +0100, ext Samreen wrote:
>>> This patch series adds the Display Support for OMAP3 platforms and
>>> the corresponding changes in the board files.
>>> 
>>> Version3:
>>>    - Rebase to the latest LO
>>> Version2:
>>>    - Optimised to configure INTBR from gpio to PWM1 mode setting and
>>>    enabling of the PWM1 mode only when its not in PWM1 mode.
>>> 
>>> Kishore Y (2):
>>>   OMAP3: ZOOM2/3/3630SDP: Add display board file for OMAP3
>>>   OMAP3: Enable display on ZOOM2/3/3630SDP
>>> 
>>>  arch/arm/mach-omap2/Makefile                  |    3 +
>>>  arch/arm/mach-omap2/board-3630sdp.c           |    1 +
>>>  arch/arm/mach-omap2/board-zoom-display.c      |  168
>>>  +++++++++++++++++++++++++ arch/arm/mach-omap2/board-zoom-peripherals.c  | 
>>>  49 +++++++- arch/arm/mach-omap2/board-zoom2.c             |    1 +
>>>  arch/arm/mach-omap2/board-zoom3.c             |    1 +
>>>  arch/arm/mach-omap2/include/mach/board-zoom.h |    3 +
>>>  7 files changed, 224 insertions(+), 2 deletions(-)  create mode
>>> 100644 arch/arm/mach-omap2/board-zoom-display.c
>> 
>> Thanks, applied.
> 
> This series needs to be posted to linux-arm-kernel list also
> for review. Samreen, can you please repost?
> 
> Tony
[Samreen]
Sure Tony,
  Will post it right away.

Warm Regards,
Samreen