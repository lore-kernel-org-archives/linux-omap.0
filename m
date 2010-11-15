From: "Nilofer, Samreen" <samreen@ti.com>
Subject: RE: [PATCH v2 0/2] OMAP3: Display Support
Date: Mon, 15 Nov 2010 09:24:43 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087034C012B05@dbde02.ent.ti.com>
References: <1288067315-30492-1-git-send-email-samreen@ti.com>
 <1289569109.3297.280.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45985 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754294Ab0KODyx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 14 Nov 2010 22:54:53 -0500
In-Reply-To: <1289569109.3297.280.camel@tubuntu>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "Mittal, Mukund" <mmittal@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tomi Valkeinen wrote:
> Hi,
> 
> On Tue, 2010-10-26 at 06:28 +0200, ext Samreen wrote:
>> This patch series adds the Display Support for OMAP3 platforms and the
>> corresponding changes in the board files.
>> 
>> Version2:
>>    - Optimised to configure INTBR from gpio to PWM1 mode setting and
>>    enabling of the PWM1 mode only when its not in PWM1 mode.
> 
> This patch set doesn't seem to apply to the latest kernel,
> conflicts in arch/arm/mach-omap2/board-zoom-peripherals.c and
> arch/arm/mach-omap2/include/mach/board-zoom.h. Can you rebase and resend?
> 
>  Tomi
Sure,
  Will rebase and post it out soon.
Warm Regards,
Samreen