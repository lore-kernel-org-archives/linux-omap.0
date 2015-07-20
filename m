From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] input: touchscreen: pixcir_i2c_ts: Add support for
 optional wakeup interrupt
Date: Sun, 19 Jul 2015 23:05:07 -0700
Message-ID: <20150720060506.GV17550@atomide.com>
References: <1437115241-17859-1-git-send-email-vigneshr@ti.com>
 <1437115241-17859-2-git-send-email-vigneshr@ti.com>
 <20150717215122.GC39282@dtor-ws>
 <55AC7DA1.9050002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55AC7DA1.9050002@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, "Quadros, Roger" <rogerq@ti.com>, Henrik Rydberg <rydberg@bitmath.org>, Frodo Lai <frodo.lai@gmail.com>, Jingoo Han <jg1.han@samsung.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Vignesh R <vigneshr@ti.com> [150719 21:51]:
> On 7/18/2015 3:21 AM, Dmitry Torokhov wrote:
> > 
> > I wonder if driver core should be responsible for clearing wake irq and
> > also for clearing wakeup flag.
> > 
> 
> AFAICU, wakeup flag is deleted when struct device is deleted, hence,
> device_init_wakeup() call may not be required in .remove(). But,
> dev_pm_clear_wake_irq() can be moved to driver core.

Currently the lifecycle of struct wakeup_source is not necessarily
the same as the lifecycle struct device. I believe net and usb drivers
at least allocate it dynamically.

Regards,

Tony
