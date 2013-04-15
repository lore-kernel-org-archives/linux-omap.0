From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH 1/5] gpio/omap: free irq domain in probe() failure paths
Date: Mon, 15 Apr 2013 15:06:33 -0700
Message-ID: <87a9ozbg9i.fsf@linaro.org>
References: <1365106576-31816-1-git-send-email-jon-hunter@ti.com>
	<1365106576-31816-2-git-send-email-jon-hunter@ti.com>
	<CACRpkdbGw8_eL2KbXU2FxSrDof=O_5tA+siZDLvTqERqa650wA@mail.gmail.com>
	<5165C201.8010500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:46529 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933777Ab3DOWGh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Apr 2013 18:06:37 -0400
Received: by mail-pa0-f54.google.com with SMTP id fa11so2784989pad.27
        for <linux-omap@vger.kernel.org>; Mon, 15 Apr 2013 15:06:36 -0700 (PDT)
In-Reply-To: <5165C201.8010500@ti.com> (Jon Hunter's message of "Wed, 10 Apr
	2013 14:48:17 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Santosh Shilimkar <santosh.shilimkar@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Jon Hunter <jon-hunter@ti.com> writes:

> On 04/10/2013 02:33 PM, Linus Walleij wrote:
>> On Thu, Apr 4, 2013 at 10:16 PM, Jon Hunter <jon-hunter@ti.com> wrote:
>> 
>>> Currently the IRQ domain is not freed once allocated, in the case where
>>> omap_gpio_probe() fails. Therefore, ensure we free the domain if the
>>> probe does fail. Furthermore, the local variable "ret" is not needed
>>> and so remove this.
>>>
>>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>> 
>> Hm Kevin is still listed as maintainer on this driver but on a mail
>> address that bounces, can you send a patch replacing him in MAINTAINERS
>> with yourself if you're willing to pick it up?
>> 
>> Anyway, patch applied.
>
> Thanks. There is a patch to fix this queued for v3.10 [1].

Yeah, but you've already been doing the heavly lifting here and should
be the maintainer going forward, IMO.  Patch below.

Linus, do you want to queue this up?

Kevin

>From 00d19c10c02c3a3aa99ca7ae75bc88a932437abd Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@linaro.org>
Date: Mon, 15 Apr 2013 15:02:26 -0700
Subject: [PATCH] MAINTAINERS: update OMAP GPIO driver: Jon Hunter taking over

Jon has already been doing most of maintenance of this driver, so
make it official.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
Applies on v3.9-rc7

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8bdd7a7..a18cacb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5789,7 +5789,7 @@ F:	arch/arm/*omap*/usb*
 
 OMAP GPIO DRIVER
 M:	Santosh Shilimkar <santosh.shilimkar@ti.com>
-M:	Kevin Hilman <khilman@deeprootsystems.com>
+M:	Jon Hunter <jon-hunter@ti.com>
 L:	linux-omap@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-omap.c
-- 
1.8.2

