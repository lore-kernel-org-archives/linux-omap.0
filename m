From: Felipe Balbi <me@felipebalbi.com>
Subject: RE: [PATCH] Separate out 3430 LCD panel support from 2430 file
Date: Thu, 12 Jun 2008 07:39:48 -0500
Message-ID: <75388c8bcebd54adbdd87d1f042118eb@felipebalbi.com>
References: <1213266272-8585-1-git-send-email-iqbal@ti.com> <afafe9c73f500ada378e662ea92fd1e5@felipebalbi.com> <5A47E75E594F054BAF48C5E4FC4B92AB022BD380AD@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:44237 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754581AbYFLMjv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Jun 2008 08:39:51 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB022BD380AD@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Iqbal <iqbal@ti.com>, linux-omap@vger.kernel.org



On Thu, 12 Jun 2008 17:24:49 +0530, "Gadiyar, Anand" <gadiyar@ti.com>
wrote:
>> > Separate out 3430 LCD panel support from 2430 SDP.
>> >
>> > Currently the support for the LCD on 3430SDP is added in the
> lcd_2430sdp.c
>> > file. This patch separates it out to a new file.
>>
>> You're at least missing 3430sdp defconfig updates, Kconfig changes
>> in drivers/media/video/omap and the removal of conditional code in
>> lcd_2430sdp.c
> 
> Er... Why Kconfig in drivers/media/video/omap?

brainfart :-p
It uses CONFIG_MACH_OMAP_XXX :-)

forget about the Kconfig :-)

-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

