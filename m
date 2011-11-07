From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/1] OMAP: TWL: set clk32kg regulator on
Date: Mon, 07 Nov 2011 11:26:18 -0800
Message-ID: <871utju42t.fsf@ti.com>
References: <1320162052-32276-1-git-send-email-vishalm@ti.com>
	<1320162052-32276-2-git-send-email-vishalm@ti.com>
	<87zkgb1nta.fsf@ti.com>
	<59CD7F2B651AD44A9EFE2AFA6166395D083879@DFLE34.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:36733 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752186Ab1KGT0W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 14:26:22 -0500
Received: by mail-qy0-f177.google.com with SMTP id 10so6926446qyk.1
        for <linux-omap@vger.kernel.org>; Mon, 07 Nov 2011 11:26:21 -0800 (PST)
In-Reply-To: <59CD7F2B651AD44A9EFE2AFA6166395D083879@DFLE34.ent.ti.com>
	(Vishal Mahaveer's message of "Fri, 4 Nov 2011 23:20:49 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mahaveer, Vishal" <vishalm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Mahaveer, Vishal" <vishalm@ti.com> writes:

>>> omap4_clk32kg regulator is used by connectivity (WLAN/BT/GPS) chip on
>>> omap4 platforms.
>>> Set always_on flag to true for connectivity chip to operate.
>>
>> The driver/init for the connectivity chip should be using the regulator
>> API to enable/disable the regulator as needed.
>
> The connectivity chip is used for BT, WLAN, FM and GPS. So we want it
> on at all times.

No.

You want it on only

1) if the connectivity chip is present, *and*
2) BT, WLAN, FM or GPS are being used.

The current patch assumes that a connectivity chip is present whenever
the TWL is present, which may be true on the platform you're currently
working on, but is not true in general.

And, even if it were present, for power reasons the regulator should be
enabled only when it's needed, not because it might be needed.  That
means that the device-specific (or board specific) code should be
configuring the regulators used for the various modules so the drivers
can request the regulators when they're needed.

Kevin
