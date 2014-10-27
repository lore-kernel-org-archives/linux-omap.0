From: "Griffis, Brad" <bgriffis@ti.com>
Subject: RE: [PATCH 0/4] Touchscreen performance related fixes
Date: Mon, 27 Oct 2014 19:02:47 +0000
Message-ID: <912A29987EAE174BA6CF187D7CDFA9CE26F46B2B@DLEE08.ent.ti.com>
References: <1414408111-2631-1-git-send-email-vigneshr@ti.com>
 <544E821D.5040004@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <544E821D.5040004@linutronix.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "R, Vignesh" <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Benoit
 Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Jonathan Cameron <jic23@kernel.org>, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Samuel Ortiz <sameo@linux.intel.com>, Jan Kardell <jan.kardell@telliq.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Balbi,
 Felipe" <balbi@ti.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Meerwald <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 10/27/2014 12:34 PM, Sebastian Andrzej Siewior wrote:
> Do we really need #3 (and then #4)? Given the complexity we have already, is there any benefit by decreasing this value? 

I specifically requested we add ti,charge-delay to the device tree because it is THE critical value to tune for a given design.  Although I think the current value of 0xB000 will be suitable for a great many designs, I expect that many users will need to adjust this value for their hardware.  Details such as which touchscreen vendor is being used and how the touchscreen is connected (header vs cable) have an effect on what's appropriate here.

> Would  someone want to increase it? Can we safely determine a value which works for everyone?

This value represents a hardware delay before checking for the pen-up event.  So in the scenario where someone is seeing excessive false pen-up events they will want to increase this parameter.  The downsize of making this larger is that it decreases the overall sampling speed of both the touchscreen as well as the standalone ADC samples.  At one point I tried making it huge, but that made the touchscreen overly sluggish because the sampling became too slow.  So there is a definite trade-off that if you make it too large the touchscreen becomes sluggish, and if you make it too small then you may see false pen-up events.  The optimal value will need to be tuned for a given design.
