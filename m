From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 0/4] Touchscreen performance related fixes
Date: Mon, 27 Oct 2014 18:34:21 +0100
Message-ID: <544E821D.5040004@linutronix.de>
References: <1414408111-2631-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1414408111-2631-1-git-send-email-vigneshr@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Felipe Balbi <balbi@ti.com>, Jan Kardell <jan.kardell@telliq.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Brad Griffis <bgriffis@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 10/27/2014 12:08 PM, Vignesh R wrote:
> This series of patches fix TSC defects related to lag in touchscreen

I will try to look this in the next few days. Do we really need #3 (and
then #4)? Given the complexity we have already, is there any benefit by
decreasing this value? Would  someone want to increase it? Can we safely
determine a value which works for everyone?

Sebastian

