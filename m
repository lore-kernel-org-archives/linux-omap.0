From: Mitch Bradley <wmb@firmworks.com>
Subject: Re: [PATCHv2] Input: omap4-keypad: Add pinctrl support
Date: Tue, 23 Oct 2012 07:02:09 -1000
Message-ID: <5086CD91.9070101@firmworks.com>
References: <1350911580-20307-1-git-send-email-sourav.poddar@ti.com> <20121022155028.GA13791@core.coreip.homeip.net> <CACRpkdaQ1WfRWrx=RXMVkeFtwdERJsOpVa3DaXBTU2KZdgqhRQ@mail.gmail.com> <508664CA.7000601@ti.com> <CACRpkdbhCS-Vb0DtbTZQ_Zw_8SOh3Bqutme3Y2-QrxNqvMiNNw@mail.gmail.com> <20121023100333.GA24418@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20121023100333.GA24418@arwen.pp.htv.fi>
Sender: linux-input-owner@vger.kernel.org
To: balbi@ti.com
Cc: Linus Walleij <linus.walleij@linaro.org>, devicetree-discuss@lists.ozlabs.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Sourav Poddar <sourav.poddar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 10/23/2012 12:03 AM, Felipe Balbi wrote:
> Hi,
> 
> I much prefer having drivers explicitly manage all their resources,
> which would mean that pinctrl calls need to be done on probe() and, if
> necessary, during suspend()/resume().


Per-driver resource management is certainly convenient when you are
dealing with a single system, but it becomes difficult to maintain for
drivers that are shared among many platforms.

The industry trend for many years has been consolidation around a single
programming model per class of device.  For example, SDHCI, EHCI, ATA.
This trend will only accelerate, as the cost of developing controller IP
and associated drivers increases.  Such drivers need to be as
platform-agnostic as possible.

