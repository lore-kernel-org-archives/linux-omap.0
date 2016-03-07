From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [Patch v4 6/6] ARM: dts: DRA7: Add dt nodes for PWMSS
Date: Mon, 7 Mar 2016 23:53:34 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1603072352510.27387@utopia.booyaka.com>
References: <1457383187-17166-1-git-send-email-fcooper@ti.com> <1457383187-17166-7-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <1457383187-17166-7-git-send-email-fcooper@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: vigneshr@ti.com, thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, bcousson@baylibre.com, tony@atomide.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, 7 Mar 2016, Franklin S Cooper Jr wrote:

> From: Vignesh R <vigneshr@ti.com>
> 
> Add PWMSS device tree nodes for DRA7 SoC family and add documentation
> for dt bindings.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> [fcooper@ti.com: Use updated bindings for PWMSS and ePWM]
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
> Version 4 changes:
> Remove hwmod entries.
> Add clocks/clock-names to pwm nodes.

Hmm, what about moving the eqep, ecap DT nodes under the epwmss nodes?


- Paul
