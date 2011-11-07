From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/1] OMAP: TWL: set clk32kg regulator on
Date: Mon, 07 Nov 2011 14:49:23 -0800
Message-ID: <87d3d3sg3w.fsf@ti.com>
References: <1320162052-32276-1-git-send-email-vishalm@ti.com>
	<1320162052-32276-2-git-send-email-vishalm@ti.com>
	<87zkgb1nta.fsf@ti.com>
	<59CD7F2B651AD44A9EFE2AFA6166395D083879@DFLE34.ent.ti.com>
	<871utju42t.fsf@ti.com>
	<59CD7F2B651AD44A9EFE2AFA6166395D0845AA@DFLE34.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:42801 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750918Ab1KGWt2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 17:49:28 -0500
Received: by mail-qy0-f172.google.com with SMTP id 16so2916539qyl.10
        for <linux-omap@vger.kernel.org>; Mon, 07 Nov 2011 14:49:27 -0800 (PST)
In-Reply-To: <59CD7F2B651AD44A9EFE2AFA6166395D0845AA@DFLE34.ent.ti.com>
	(Vishal Mahaveer's message of "Mon, 7 Nov 2011 21:03:06 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mahaveer, Vishal" <vishalm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Mahaveer, Vishal" <vishalm@ti.com> writes:

> Hilman, Kevin wrote:
>> 
>> No.
>> 
>> You want it on only
>> 
>> 1) if the connectivity chip is present, *and*
>> 2) BT, WLAN, FM or GPS are being used.
>> 
>> The current patch assumes that a connectivity chip is present
>> whenever the TWL is present, which may be true on the platform you're
>> currently working on, but is not true in general.  
>> 
>> And, even if it were present, for power reasons the regulator should
>> be enabled only when it's needed, not because it might be needed. 
>> That means that the device-specific (or board specific) code should
>> be configuring the regulators used for the various modules so the
>> drivers can request the regulators when they're needed.    
>> 
>
> Will it make more sense to move clk32 regulator initialization to
> board-xxx files of platforms which has the connectivity chip?

Yes, initialization should be done only when connectivity chip is
present.

But more importantly, it's the usage of the regulator API that is
important.  My primary objection to this patch is the use of 'always
on', where the drivers/devices that depend on this regulator are the
ones that should be requesting it to be on using the regulator API.

Kevin

