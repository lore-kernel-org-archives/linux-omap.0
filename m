From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 5/6] ARM: dts: DRA7: Add TBCLK for PWMSS
Date: Mon, 11 Apr 2016 13:27:14 -0700
Message-ID: <20160411202714.GG5995@atomide.com>
References: <1457400224-24797-1-git-send-email-fcooper@ti.com>
 <1457400224-24797-6-git-send-email-fcooper@ti.com>
 <20160411202159.GF5995@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160411202159.GF5995@atomide.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, paul@pwsan.com, linux@arm.linux.org.uk, vigneshr@ti.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux-kernel@vger.kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org, thierry.reding@gmail.com, bcousson@baylibre.com, galak@codeaurora.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [160411 13:24]:
> * Franklin S Cooper Jr <fcooper@ti.com> [160307 17:24]:
> > From: Vignesh R <vigneshr@ti.com>
> > 
> > tbclk is used by ehrpwm to generate PWM waveform on DRA7 SoC. Add Linux
> > clock to control ehrpwm tbclk.
> > The TRM says, tbclk is derived from SYSCLKOUT. SYSCLKOUT is nothing but
> > ehrpwm functional clock derived from the gateable interface and
> > functional clock of PWMSS(l4_root_clk_div).
> > Refer AM57x TRM SPRUHZ6E[1], Janurary 2016, Table 29-4 and
> > Section 29.2.2.1, Table 29-19 and the NOTE at the end of the table.
> 
> Applying this one into omap-for-v4.7/dt thanks.

Never mind, we already have these with commit c60f9e29805e ("ARM: dts:
DRA7: Add TBCLK for PWMSS").

Tony
