From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 2/5] ARM: OMAP2+: DRA7: Add hwmod entries for PWMSS
Date: Thu, 18 Feb 2016 17:21:28 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1602181718560.4792@utopia.booyaka.com>
References: <1433332284-10766-1-git-send-email-vigneshr@ti.com> <1433332284-10766-3-git-send-email-vigneshr@ti.com> <alpine.DEB.2.02.1507152029460.32764@utopia.booyaka.com> <55A7CE59.6010600@ti.com> <alpine.DEB.2.02.1508121700500.7154@utopia.booyaka.com>
 <56C4DB37.9090802@ti.com> <alpine.DEB.2.02.1602180652380.4792@utopia.booyaka.com> <56C5E466.2030002@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <56C5E466.2030002@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: "Franklin S Cooper Jr." <fcooper@ti.com>
Cc: "R, Vignesh" <vigneshr@ti.com>, Tero Kristo <t-kristo@ti.com>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Franklin, 

On Thu, 18 Feb 2016, Franklin S Cooper Jr. wrote:

> On 02/18/2016 12:58 AM, Paul Walmsley wrote:
>
> > OK I'm not sure I understand what's going on, particularly the part about 
> > locking and unlocking.  Are you saying that the pwm_bl driver calls into 
> > the pwm_tiecap module to write to the PWMSS_CLKCONFIG registers to ungate 
> > the ECAP clock, and then the hardware silently ignores the write?  If 
> > that's the case, shouldn't we be seeing some warning messages from a 
> > failure to ungate the clock from a subsequent PWMSS_CLKSTATUS poll?  Or am 
> > I misunderstanding what's going on here?
> Pwm-tipwmss.c exports a function
> pwmss_submodule_state_change which interacts with
> PWMSS_CLKCONFIG and PWMSS_CLKSTATUS registers. Both
> pwm-tiehrpwm.c and pwm-tiecap.c calls this exported function
> to unlock the gate at probe time and lock the gate when the
> driver is removed.
> 
> So when the gate fails to be unlocked after it previously is
> locked there isn't a way to know this via the
> PWMSS_CLKSTATUS registers.

OK I understand now.  Sounds like the gating -> ungating transition is 
effectively a one-time operation, and once the ungating -> gating 
transition is done, there's no way to reverse it.  Please correct me if 
I've got it wrong.

>  So the driver "believes" that the gate is unlocked and when pwm_bl runs 
> it calls the set_polarity function. Set_polarity in the case of AM437x 
> gp evm maps to the ecap's ecap_pwm_set_polarity function call. This call 
> then attempts to write to the ecap registers which results in the 
> external abort since the clock to the ecap is still gated.
>
> When the ecap and tihrpwm driver request to unlock the clock
> gate it already checks the XXX_CLK_EN_ACK bitfields within
> CLKSTATUS and it shows that the clocks "should" be unlocked.
> So there is an issue with the IP.

OK

> Yes, I plan on addressing the change Vignesh acknowledged
> regarding changing RESETSTATUS to SOFTRESET. For your other
> comments I believe he already explained why it has to be set
> in that particular way. If there is anything that I missed
> or something that isn't clear please let me know.

Perfect, thanks for the good description and the followup.


- Paul
