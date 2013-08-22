From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v4] extcon: palmas: Added a new compatible type *ti,palmas-usb-vid*
Date: Thu, 22 Aug 2013 14:50:22 -0600
Message-ID: <5216798E.8070900@wwwdotorg.org>
References: <1377160283-26934-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1377160283-26934-1-git-send-email-kishon@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: bcousson@baylibre.com, tony@atomide.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob@landley.net, george.cherian@ti.com, gregkh@linuxfoundation.org, linux-doc@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

On 08/22/2013 02:31 AM, Kishon Vijay Abraham I wrote:
> The Palmas device contains only a USB VBUS-ID detector, so added a
> compatible type *ti,palmas-usb-vid*. Didn't remove the existing compatible
> types for backward compatibility.

> diff --git a/Documentation/devicetree/bindings/extcon/extcon-palmas.txt b/Documentation/devicetree/bindings/extcon/extcon-palmas.txt

>  PALMAS USB COMPARATOR
>  Required Properties:
> - - compatible : Should be "ti,palmas-usb" or "ti,twl6035-usb"
> + - compatible : Should be "ti,palmas-usb-vid". "ti,twl6035-usb" and
> +   "ti,palmas-usb" is deprecated and is kept for backward compatibility.

So this defines one new value and deprecates the two old values.

Why isn't a new "ti,twl6035-usb-vid" entry useful? Don't you still need
SoC-specific compatible values so the driver can enable any SoC-specific
bug-fixes/workarounds later if needed?
