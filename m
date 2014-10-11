From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/12] rtc: omap: fixes and power-off feature
Date: Sat, 11 Oct 2014 12:08:18 -0700
Message-ID: <20141011190817.GA20644@atomide.com>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <20141010175409.GL31348@saruman>
 <20141011093819.GA18988@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141011093819.GA18988@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Felipe Balbi <balbi@ti.com>, Alessandro Zummo <a.zummo@towertech.it>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Andrew Morton <akpm@linux-foundation.org>, Lokesh Vutla <lokeshvutla@ti.com>, Guenter Roeck <linux@roeck-us.net>, Colin Foe-Parker <colin.foeparker@logicpd.com>, nsekhar@ti.com, t-kristo@ti.com, j-keerthy@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Johan Hovold <johan@kernel.org> [141011 02:42]:
> On Fri, Oct 10, 2014 at 12:54:22PM -0500, Felipe Balbi wrote:
> > 
> > is this power-off feature "RTC-only mode" ?
> 
> Yes, I believe so, at least as long as RTC power is maintained. The
> pmic_power_en pin can otherwise still be used to power off. 
> 
> On the BeagleBone the PMIC can be configured to enter OFF or SLEEP mode
> on power off, where the latter (and default) mode keeps the RTC power
> supply enabled.
> 
> Thanks for the fast review, Felipe.

Great :) I assume adding the regulator support to this driver should
also help in the 35xx case?

That is assuming that RTC power can be configured as a Linux
regulator on 35xx.

Regards,

Tony
