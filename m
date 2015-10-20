From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: dts: am437x-gp-evm: Add wakeup interrupt source
 for pixcir_i2c_ts
Date: Tue, 20 Oct 2015 09:21:42 -0700
Message-ID: <20151020162141.GG3078@atomide.com>
References: <1444830865-30899-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1444830865-30899-1-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Roger Quadros <rogerq@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Benoit Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Vignesh R <vigneshr@ti.com> [151014 06:59]:
> On am437x-gp-evm, pixcir_i2c_ts can wakeup the system from low power
> state via pinctrl and IO daisy chain using generic wakeirq framework.
> With commit 3fffd1283927 ("i2c: allow specifying separate wakeup
> interrupt in device tree") i2c core allows optional wakeirq to be
> specified via device tree. Add wakeup irq entry to enable pixcir_i2c_ts
> to wake the system from low power state.

Applying into omap-for-v4.4/dt thanks.

Tony
