From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/7] pwm: omap-dmtimer: Allow for setting dmtimer clock
 source
Date: Mon, 9 May 2016 15:01:48 -0500
Message-ID: <20160509200148.GA19811@rob-hp-laptop>
References: <1462634508-24961-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1462634508-24961-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462634508-24961-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, thierry.reding@gmail.com, bcousson@baylibre.com, tony@atomide.com, linux@arm.linux.org.uk, mchehab@osg.samsung.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, sre@kernel.org, pali.rohar@gmail.com
List-Id: linux-omap@vger.kernel.org

On Sat, May 07, 2016 at 06:21:43PM +0300, Ivaylo Dimitrov wrote:
> OMAP GP timers can have different input clocks that allow different PWM
> frequencies. However, there is no other way of setting the clock source but
> through clocks or clock-names properties of the timer itself. This limits
> PWM functionality to only the frequencies allowed by the particular clock
> source. Allowing setting the clock source by PWM rather than by timer
> allows different PWMs to have different ranges by not hard-wiring the clock
> source to the timer.
> 
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.txt |  4 ++++
>  drivers/pwm/pwm-omap-dmtimer.c                             | 12 +++++++-----
>  2 files changed, 11 insertions(+), 5 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
