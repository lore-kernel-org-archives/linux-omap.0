From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v4] video: fbdev: omapfb: lcd_ams_delta: use GPIO lookup
 table
Date: Mon, 8 Oct 2018 12:50:21 +0200
Message-ID: <20181008105022eucas1p1b747f75b0dbe07f781e5cfee83829773~bnIwD11nn2266022660eucas1p1o@eucas1p1.samsung.com>
References: <20180909225605.16463-2-jmkrzyszt@gmail.com>
        <CGME20181003130232epcas2p4eba2a06d977e2f23014c2a5d5256630f@epcas2p4.samsung.com>
        <20181003130326.10283-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181003130326.10283-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: linux-fbdev@lists.infradead.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


On 10/03/2018 03:03 PM, Janusz Krzysztofik wrote:
> Now as Amstrad Delta board - the only user of this driver - provides
> GPIO lookup tables, switch from GPIO numbers to GPIO descriptors and
> use the table to locate required GPIO pins.
> 
> Declare static variables for storing GPIO descriptors and replace
> gpio_ function calls with their gpiod_ equivalents. Move GPIO lookup
> to the driver probe function so device initialization can be deferred
> instead of aborted if a GPIO pin is not yet available.
> 
> Pin naming used by the driver should be followed while respective GPIO
> lookup table is initialized by a board init code.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Patch queued for 4.20, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
