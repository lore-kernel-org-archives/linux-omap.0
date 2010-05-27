From: "Arce, Abraham" <x0066660@ti.com>
Subject: RE: [UPDATE] [RFC] [PATCH 0/4] OMAP4 Keyboard Controller Support
Date: Thu, 27 May 2010 11:24:17 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043E46DB3F@dlee03.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A53043E22D52D@dlee03.ent.ti.com>
 <20100525081414.GA31751@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20100525081414.GA31751@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Dmitry,

> On Tue, May 18, 2010 at 06:13:48PM -0500, Arce, Abraham wrote:
> > Hi,
> >
> > Here you have the list of changes done so far for OMAP4 Keyboard
> > Controller Support v2. I'll appreciate if someone else has more comments
> > to share.
> >
> 
> I finally had a chance to review the patches and I do not think that we
> shoudl be adding new hooks, especially omap-specific platform methods,
> into matrix_keypad_platform_data structure. Also, the structre does not
> really match the device since it does nto use GPIOs. Why don't we
> define a driver-specific platform structure based on matrix_keypad_data
> and use it instead?

Agree, looks clean now...

> 
> Please try the patch below and let me know if it works for you.

Yes, it works... I am putting it in a TI internal tree...

> Btw, you should not be allocating platform data in the platform code -
> it meant to be statically allocated and preferrably constant.

I'll take a look at this...

> +
> +#include <plat/omap4_keypad.h>

One fix to your patch...

#include <plat/omap4-keypad.h>

[snip]

Best Regards
Abraham
