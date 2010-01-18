From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 2/3] DSPBRIDGE: change to cpufreq_register_notifier for
 OPP changes
Date: Mon, 18 Jan 2010 12:09:14 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A53042DE50CC5@dlee03.ent.ti.com>
References: <1263607307-21693-1-git-send-email-omar.ramirez@ti.com>
	 <1263607307-21693-2-git-send-email-omar.ramirez@ti.com>
	 <1263607307-21693-3-git-send-email-omar.ramirez@ti.com>
 <1263810019.1968.7.camel@sanganak>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34288 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752973Ab0ARSJ2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jan 2010 13:09:28 -0500
In-Reply-To: <1263810019.1968.7.camel@sanganak>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>

>From: Ameya Palande on Monday, January 18, 2010 4:20 AM
>
>On Sat, 2010-01-16 at 03:01 +0100, ext Omar Ramirez Luna wrote:
>> From: Fernando Guzman Lugo <x0095840@ti.com>
>>
>> This patch changes clk_notifier_unregister with
>> cpufreq_unregister_notifier, which is used for OPP change
>> notifications
>>
>> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
>> ---
>>  drivers/dsp/bridge/Kconfig              |    2 +-
>>  drivers/dsp/bridge/rmgr/drv_interface.c |   25 +++++++++++++++----------
>>  2 files changed, 16 insertions(+), 11 deletions(-)
>>

[snip]

>Acked-by: Ameya Palande <ameya.palande@nokia.com>

Pushed to dspbridge-pm

- omar
