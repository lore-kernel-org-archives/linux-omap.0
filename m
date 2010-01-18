From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 1/3] DSPBRIDGE: Fix header locations mach to plat
Date: Mon, 18 Jan 2010 12:08:55 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A53042DE50CC4@dlee03.ent.ti.com>
References: <1263607307-21693-1-git-send-email-omar.ramirez@ti.com>
	 <1263607307-21693-2-git-send-email-omar.ramirez@ti.com>
 <1263808512.1968.6.camel@sanganak>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34268 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752573Ab0ARSJJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jan 2010 13:09:09 -0500
In-Reply-To: <1263808512.1968.6.camel@sanganak>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>

>From: Ameya Palande on Monday, January 18, 2010 3:55 AM
>
>On Sat, 2010-01-16 at 03:01 +0100, ext Omar Ramirez Luna wrote:
>> Fix header locations, replaced mach to plat
>>
>> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>> ---
>>  arch/arm/mach-omap2/dspbridge.c                |    2 +-
>>  arch/arm/plat-omap/include/dspbridge/host_os.h |    2 +-
>>  drivers/dsp/bridge/wmd/tiomap3430.c            |    2 +-
>>  3 files changed, 3 insertions(+), 3 deletions(-)
>>

[snip]

>Acked-by: Ameya Palande <ameya.palande@nokia.com>

Pushed to dspbridge-pm

- omar
