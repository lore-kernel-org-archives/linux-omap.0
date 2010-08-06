From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PM-SR][PATCH 11/12] omap3: sr: sr_exit should be static
Date: Fri, 6 Aug 2010 10:27:02 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032401CD2A@dbde02.ent.ti.com>
References: <1281047052-21346-1-git-send-email-nm@ti.com>
 <1281047052-21346-12-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52522 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751623Ab0HFE5I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 00:57:08 -0400
In-Reply-To: <1281047052-21346-12-git-send-email-nm@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>



>>-----Original Message-----
>>From: Menon, Nishanth
>>Sent: Friday, August 06, 2010 3:54 AM
>>To: linux-omap
>>Cc: Menon, Nishanth; Kevin Hilman; Gopinath, Thara
>>Subject: [PM-SR][PATCH 11/12] omap3: sr: sr_exit should be static
>>
>>sr_exit has no business being a public function.
>>fixes sparse:
>>arch/arm/mach-omap2/smartreflex.c:959:13: warning: symbol 'sr_exit' was not declared. Should it be
>>static?
>>
>>Cc: Kevin Hilman <khilman@deeprootsystems.com>
>>Cc: Thara Gopinath <thara@ti.com>
>>
>>Signed-off-by: Nishanth Menon <nm@ti.com>
>>---
>> arch/arm/mach-omap2/smartreflex.c |    2 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>
>>diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
>>index 9b5a10e..a723ac7 100644
>>--- a/arch/arm/mach-omap2/smartreflex.c
>>+++ b/arch/arm/mach-omap2/smartreflex.c
>>@@ -968,7 +968,7 @@ static int __init sr_init(void)
>> 	return 0;
>> }
>>
>>-void __exit sr_exit(void)
>>+static void __exit sr_exit(void)

Will collate this.
>> {
>> 	platform_driver_unregister(&smartreflex_driver);
>> }
>>--
>>1.6.3.3

