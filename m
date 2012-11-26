From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] gpio: New driver for GPO emulation using PWM generators
Date: Mon, 26 Nov 2012 12:36:35 +0100
Message-ID: <50B35443.2040801@ti.com>
References: <1353591723-25233-1-git-send-email-peter.ujfalusi@ti.com> <20121123075537.A14713E0A91@localhost> <50AF3E21.4000009@ti.com> <50AF4584.7020604@ti.com> <50B344D6.8030608@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <50B344D6.8030608@metafoo.de>
Sender: linux-doc-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>, Rob Landley <rob@landley.net>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

hi,

On 11/26/2012 11:30 AM, Lars-Peter Clausen wrote:
> The difference here is that the LED, backlight, etc are all different
> physical devices begin driven by the pwm pin, so it makes sense to ha=
ve a
> device tree node for them, while using the pwm as gpio is just a diff=
erent
> function of the same physical pin.  So in a sense the pwm controller =
also
> becomes a gpio controller. I like the idea of the pwm core automatica=
lly
> instantiating a pwm-gpo device if it sees a gpio-controller property =
in the
> pwm device devicetree node.

OK, fair enough. I will go with the plan I described in the first mail =
for the
GPIO use of PWM.

--=20
P=E9ter
