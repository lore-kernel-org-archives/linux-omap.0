From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND PATCH v2 0/5] ir-rx51 driver fixes
Date: Wed, 22 Jun 2016 21:44:36 -0700
Message-ID: <20160623044436.GK22406@atomide.com>
References: <1466623341-30130-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1466623341-30130-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, thierry.reding@gmail.com, bcousson@baylibre.com, linux@arm.linux.org.uk, mchehab@osg.samsung.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, sre@kernel.org, pali.rohar@gmail.com, pavel@ucw.cz
List-Id: linux-omap@vger.kernel.org

* Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [160622 12:25]:
> ir-rx51 is a driver for Nokia N900 IR transmitter. The current series
> fixes the remaining problems in the driver:

Thanks for updating these.

Trierry, care to ack the PWM patch?

Mauro, do you want me to set up an immutable branch with all
these against v4.7-rc1 that we can all merge as needed?

If you want to set up the branch instead, please feel free
to add my ack.

Regards,

Tony
