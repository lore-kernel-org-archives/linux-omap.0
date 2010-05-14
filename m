From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [RFC] [PATCH v2 3/4] OMAP4: Keyboard board support
Date: Fri, 14 May 2010 08:25:19 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703050DEF02@dbde02.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A53043E113BFB@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53043E113BFB@dlee03.ent.ti.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: "Arce, Abraham" <x0066660@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of Arce, Abraham
>Sent: Thursday, May 13, 2010 3:51 PM
>To: linux-input@vger.kernel.org; linux-omap@vger.kernel.org
>Subject: [RFC] [PATCH v2 3/4] OMAP4: Keyboard board support
>
>Keyboard support for SDP OMAP4430
>
>Signed-off-by: Abraham Arce <x0066660@ti.com>
>---
> arch/arm/mach-omap2/board-4430sdp.c |  157
>+++++++++++++++++++++++++++++++++++
> 1 files changed, 157 insertions(+), 0 deletions(-)
>
>diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-
>omap2/board-4430sdp.c
>index 6cce6f2..19742c5 100644
>--- a/arch/arm/mach-omap2/board-4430sdp.c
>+++ b/arch/arm/mach-omap2/board-4430sdp.c
>@@ -19,6 +19,8 @@
> #include <linux/gpio.h>
> #include <linux/usb/otg.h>
> #include <linux/spi/spi.h>
>+#include <linux/input.h>
>+#include <linux/input/matrix_keypad.h>
...
>+
>+struct omap_device *od;

Any reason to have this global?

>+
>+static int __init sdp4430_keypad_init(void)
>+{
>+	struct omap_hwmod *oh;
>+	struct matrix_keypad_platform_data *pdata;
>+
...
