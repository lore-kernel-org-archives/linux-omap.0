From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [CBUS PATCH 1/1] CBUS: Fix broken compilation
Date: Wed, 5 May 2010 22:00:15 +0300
Message-ID: <20100505190015.GB4960@nokia.com>
References: <1272736870-5216-1-git-send-email-felipe.balbi@nokia.com>
 <1273071929-17708-1-git-send-email-carlos.chinea@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:51099 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757717Ab0EETBE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 15:01:04 -0400
Content-Disposition: inline
In-Reply-To: <1273071929-17708-1-git-send-email-carlos.chinea@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Chinea Carlos (Nokia-D/Helsinki)" <Carlos.Chinea@nokia.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

hi again,


On Wed, May 05, 2010 at 05:05:29PM +0200, Chinea Carlos (Nokia-D/Helsinki) wrote:
>Include explicitly slab.h in:
>	drivers/cbus/cbus.c
>	drivers/cbus/retu-headset.c
>	drivers/cbus/retu-user.c
>	drivers/cbus/retu-wdt.c
>	drivers/cbus/tahvo-user.c
>
>Compile tested with n8x0_defconfig
>
>Signed-off-by: Carlos Chinea <carlos.chinea@nokia.com>

I see now the problem.

>---
> drivers/cbus/cbus.c         |    1 +
> drivers/cbus/retu-headset.c |    1 +
> drivers/cbus/retu-user.c    |    1 +
> drivers/cbus/retu-wdt.c     |    1 +
> drivers/cbus/tahvo-user.c   |    1 +
> 5 files changed, 5 insertions(+), 0 deletions(-)
>
>diff --git a/drivers/cbus/cbus.c b/drivers/cbus/cbus.c
>index 00c3c32..2c74d6e 100644
>--- a/drivers/cbus/cbus.c
>+++ b/drivers/cbus/cbus.c
>@@ -30,6 +30,7 @@
> #include <linux/spinlock.h>
> #include <linux/gpio.h>
> #include <linux/platform_device.h>
>+#include <linux/slab.h>

this is already included in line 32 of that file.

>diff --git a/drivers/cbus/retu-headset.c b/drivers/cbus/retu-headset.c
>index e798bc2..645679c 100644
>--- a/drivers/cbus/retu-headset.c
>+++ b/drivers/cbus/retu-headset.c
>@@ -25,6 +25,7 @@
> #include <linux/delay.h>
> #include <linux/input.h>
> #include <linux/platform_device.h>
>+#include <linux/slab.h>

already on line 25, right above #include <linux/delay.h>

>diff --git a/drivers/cbus/retu-user.c b/drivers/cbus/retu-user.c
>index 0f35dc5..7bc97d4 100644
>--- a/drivers/cbus/retu-user.c
>+++ b/drivers/cbus/retu-user.c
>@@ -33,6 +33,7 @@
> #include <linux/spinlock.h>
> #include <linux/sched.h>
> #include <linux/mutex.h>
>+#include <linux/slab.h>

already on line 26

>diff --git a/drivers/cbus/retu-wdt.c b/drivers/cbus/retu-wdt.c
>index 35932dd..fda8b35 100644
>--- a/drivers/cbus/retu-wdt.c
>+++ b/drivers/cbus/retu-wdt.c
>@@ -35,6 +35,7 @@
> #include <linux/platform_device.h>
> #include <linux/miscdevice.h>
> #include <linux/watchdog.h>
>+#include <linux/slab.h>

already on line 25

>diff --git a/drivers/cbus/tahvo-user.c b/drivers/cbus/tahvo-user.c
>index c0e8daf..b28b015 100644
>--- a/drivers/cbus/tahvo-user.c
>+++ b/drivers/cbus/tahvo-user.c
>@@ -33,6 +33,7 @@
> #include <linux/spinlock.h>
> #include <linux/sched.h>
> #include <linux/mutex.h>
>+#include <linux/slab.h>

already on line 26.

NAK to this patch.

-- 
balbi

DefectiveByDesign.org
