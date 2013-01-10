From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3] gpio: twl4030: Cache the direction and output states
 in private data
Date: Thu, 10 Jan 2013 11:41:15 +0100
Message-ID: <CACRpkdZK8AA-osijVpbp7U-Wv0XUAVxDPQ3zxfCqWYb6WKjmwQ@mail.gmail.com>
References: <1355996651-17805-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1355996651-17805-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Michael Trimarchi <michael@amarulasolutions.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 20, 2012 at 10:44 AM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:

> Use more coherent locking in the driver. Use bitfield to store the GPIO
> direction and if the pin is configured as output store the status also in a
> bitfiled.
> In this way we can just look at these bitfields when we need information
> about the pin status and only reach out to the chip when it is needed.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Hi Grant,
>
> Changes sicne v2:
> - Fixed the mutex_unlock found by Michael.
> - Removed the debug prints addedd by v2 patch (remains from debugging)
> - Removed one blank line between includes and the first comment section.

Sorry Peter this must have been missed somehow.

This does not apply to the current v3.8-rc3, could you respin
this on top of Torvalds' tree?

Yours,
Linus Walleij
