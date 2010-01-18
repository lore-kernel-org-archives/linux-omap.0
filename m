From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 3/3] DSPBRIDGE: Use dspbridge to initialize platform data
Date: Mon, 18 Jan 2010 12:09:30 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A53042DE50CC7@dlee03.ent.ti.com>
References: <1263607307-21693-1-git-send-email-omar.ramirez@ti.com>
	 <1263607307-21693-2-git-send-email-omar.ramirez@ti.com>
	 <1263607307-21693-3-git-send-email-omar.ramirez@ti.com>
	 <1263607307-21693-4-git-send-email-omar.ramirez@ti.com>
 <1263810723.1968.8.camel@sanganak>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51244 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755829Ab0ARSJe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jan 2010 13:09:34 -0500
In-Reply-To: <1263810723.1968.8.camel@sanganak>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@Nokia.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@Nokia.com>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@Nokia.com>, "Menon, Nishanth" <nm@ti.com>

>From: Ameya Palande on Monday, January 18, 2010 4:32 AM
>
>On Sat, 2010-01-16 at 03:01 +0100, ext Omar Ramirez Luna wrote:
>> Include dspbridge compilation whenever bridge driver is selected to
>> be compiled, either as a module or part of the kernel. This will
>> initialize platform data specific PM functions.
>>
>> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>> ---
>>  arch/arm/mach-omap2/Makefile |    4 +++-
>>  1 files changed, 3 insertions(+), 1 deletions(-)
>>

[snip]

>
>Acked-by: Ameya Palande <ameya.palande@nokia.com>

Pushed to dspbridge-pm

- omar
