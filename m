From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/1] ARM: dts: omap3:  Adapt USB OTG to generic PHY framework
Date: Mon, 07 Oct 2013 15:40:23 +0200
Message-ID: <5252B9C7.5040109@linutronix.de>
References: <1381152493-28055-1-git-send-email-rogerq@ti.com> <1381152493-28055-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1381152493-28055-2-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: bcousson@baylibre.com, pavel@ucw.cz, aaro.koskinen@iki.fi, marek@goldelico.com, balbi@ti.com, tony@atomide.com, kishon@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 10/07/2013 03:28 PM, Roger Quadros wrote:
> The generic PHY framewrok expects different properties than the
> old USB PHY framework. Supply those properties.
> 
> Fixes USB OTG port on GAT04 and N900 after the Generic PHY framework was
> merged in greg/usb-next. [1]

Would it be much pain (and do we want this at all) to add a fallback
into the kernel or at least a printk pointing out to update the .dts
for two releases or so? So the user does not need to spent hours to
figure out why it suddenly stopped working.

Sebastian
