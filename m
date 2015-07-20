From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: touchscreen: pixcir_i2c_ts: Add support for
 optional wakeup interrupt
Date: Sun, 19 Jul 2015 23:33:23 -0700
Message-ID: <20150720063323.GC13092@dtor-ws>
References: <1437115241-17859-1-git-send-email-vigneshr@ti.com>
 <1437115241-17859-2-git-send-email-vigneshr@ti.com>
 <20150717215122.GC39282@dtor-ws> <55AC7DA1.9050002@ti.com>
 <20150720060506.GV17550@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20150720060506.GV17550@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Frodo Lai <frodo.lai@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Russell King <linux@arm.linux.org.uk>, Vignesh R <vigneshr@ti.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Henrik Rydberg <rydberg@bitmath.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Kumar Gala <galak@codeaurora.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Quadros, Roger" <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On Sun, Jul 19, 2015 at 11:05:07PM -0700, Tony Lindgren wrote:
> * Vignesh R <vigneshr@ti.com> [150719 21:51]:
> > On 7/18/2015 3:21 AM, Dmitry Torokhov wrote:
> > > 
> > > I wonder if driver core should be responsible for clearing wake irq and
> > > also for clearing wakeup flag.
> > > 
> > 
> > AFAICU, wakeup flag is deleted when struct device is deleted, hence,
> > device_init_wakeup() call may not be required in .remove(). But,
> > dev_pm_clear_wake_irq() can be moved to driver core.
> 
> Currently the lifecycle of struct wakeup_source is not necessarily
> the same as the lifecycle struct device. I believe net and usb drivers
> at least allocate it dynamically.

I am not sure if I follow. I was wondering if we should clear the wakeup
IRQ setting on the driver unbinding. It does not mean that we'd be
deleting wakeup_source, just that we'll clear wakeup irq setting from
it.

-- 
Dmitry
