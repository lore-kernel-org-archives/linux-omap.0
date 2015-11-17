From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 01/39] pinctrl: Move am4372 and dra7 macros to the the SoC
 header files
Date: Tue, 17 Nov 2015 14:47:10 +0100
Message-ID: <CACRpkdZt2NXD-WzLRcxNuvu9fM6j9GPRjnAungv1jxJvipKYAQ@mail.gmail.com>
References: <1447390457-1158-1-git-send-email-javier@osg.samsung.com>
	<1447390457-1158-2-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1447390457-1158-2-git-send-email-javier@osg.samsung.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 13, 2015 at 5:53 AM, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:

> The <dt-bindings/pinctrl/omap.h> header file defines a set of macros
> for different SoCs families that falls under the OMAP sub-arch, that
> allow to define the padconf register physical address instead of the
> register offset from the padconf base.
>
> But the am43xx and dra7xx SoCs families have their own pinctrl header
> file so the DTS using these SoCs aren't able to use the AM4372_IOPAD()
> and DRA7XX_CORE_IOPAD() macros since <dt-bindings/pinctrl/omap.h> is
> not included.
>
> Move the macros to the correct header files so can be used by the DTS.
>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

I need Tony's ACK on this.

Yours,
Linus Walleij
