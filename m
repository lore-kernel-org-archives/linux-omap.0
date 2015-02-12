From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 0/4] add openpandora device support
Date: Thu, 12 Feb 2015 16:35:14 +0200
Message-ID: <CANOLnOPZ5j-r9APq6WrW65iOyNQPT4M_uRgN+xp9Mrp4zgVn7w@mail.gmail.com>
References: <1423746226-700-1-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423746226-700-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>
Cc: Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, robh+dt@kernel.org, galak@codeaurora.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 12, 2015 at 3:03 PM, Marek Belisko <marek@goldelico.com> wr=
ote:
> This series of patches adds initial device tree support for the
> OpenPandora. The most important parts are working (display, keyboard,
> touch, charging, fuel gauge, musb port, sd/mmc ports, leds, buttons).
> Not yet supported are: usb host port, nubs, wifi, bluetooth, audio.
>
> First patch add common dtsi file which is then used in 600mhz and 1gh=
z
> variants of openpandora which support is added in patches 2 and 3.

Nice, thanks for those patches.
There is also a OMAP3530 variant with 256MB of RAM (otherwise
identical to 512MB OMAP3530) that the legacy board file supports, over
1000 such units were made. Could we also have support for that? I
guess that will make 4 pandora related .dts files...


Gra=C5=BEvydas
