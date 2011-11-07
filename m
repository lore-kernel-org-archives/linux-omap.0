From: Jean Delvare <khali@linux-fr.org>
Subject: Re: 10-bit address support in i2c-omap and i2c-davinci
Date: Mon, 7 Nov 2011 17:59:37 +0100
Message-ID: <20111107175937.7099f6e9@endymion.delvare>
References: <20111107094614.0062a3f7@endymion.delvare>
	<87hb2g0y19.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:17379 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755119Ab1KGRAG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 12:00:06 -0500
In-Reply-To: <87hb2g0y19.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Ben Dooks <ben-linux@fluff.org>, Tony Lindgren <tony@atomide.com>, Andy Green <andy.green@linaro.org>, Lucas De Marchi <lucas.demarchi@profusion.mobi>, Linux I2C <linux-i2c@vger.kernel.org>, linux-omap@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com

On Mon, 07 Nov 2011 07:09:38 -0800, Kevin Hilman wrote:
> Adding linux-omap and linux-davinci lists

Good point, sorry for missing that. Maybe the following would help?

List i2c-omap and i2c-davinci in MAINTAINERS.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 MAINTAINERS |    3 +++
 1 file changed, 3 insertions(+)

--- linux-3.2-rc0.orig/MAINTAINERS	2011-11-07 17:55:46.000000000 +0100
+++ linux-3.2-rc0/MAINTAINERS	2011-11-07 17:55:55.000000000 +0100
@@ -4675,6 +4675,8 @@ Q:	http://patchwork.kernel.org/project/l
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
 S:	Maintained
 F:	arch/arm/*omap*/
+F:	drivers/i2c/busses/i2c-omap.c
+F:	include/linux/i2c-omap.h
 
 OMAP CLOCK FRAMEWORK SUPPORT
 M:	Paul Walmsley <paul@pwsan.com>
@@ -5940,6 +5942,7 @@ L:	davinci-linux-open-source@linux.davin
 Q:	http://patchwork.kernel.org/project/linux-davinci/list/
 S:	Supported
 F:	arch/arm/mach-davinci
+F:	drivers/i2c/busses/i2c-davinci.c
 
 SIS 190 ETHERNET DRIVER
 M:	Francois Romieu <romieu@fr.zoreil.com>


-- 
Jean Delvare
