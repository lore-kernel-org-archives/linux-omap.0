From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/2] mfd: twl4030-power: use 'ti,system-power-controller'
 as alternative way to support system power off
Date: Wed, 17 Sep 2014 07:17:06 -0500
Message-ID: <20140917121705.GA2939@splat>
References: <1409771208-21867-1-git-send-email-nm@ti.com>
 <1409771208-21867-3-git-send-email-nm@ti.com>
 <20140909000126.GU3238@atomide.com>
 <20140916230537.GU25162@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140916230537.GU25162@lee--X1>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Samuel Ortiz <sameo@linux.intel.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 16:05-20140916, Lee Jones wrote:
> On Mon, 08 Sep 2014, Tony Lindgren wrote:
> 
> > * Nishanth Menon <nm@ti.com> [140903 12:07]:
> > > ti,system-power-controller is more or less the standard way of
> > > indicating that the PMIC is the system wide power controller and hence
> > > may be used to switch off the system. Almost ALL TI PMIC drivers and
> > > many Maxim PMIC drivers follow the same style.
> > > 
> > > So support 'ti,system-power-controller' in addition to the usual
> > > 'ti,use_poweroff' to indicate that the PMIC instance has control for
> > > switching off the system.
> > > 
> > > Signed-off-by: Nishanth Menon <nm@ti.com>
> > 
> > Acked-by: Tony Lindgren <tony@atomide.com>
> 
> I assume you're going to resend this with the document modifications?
> When you do, don't forget to apply Tony's Ack, as it will ensure a
> faster merge.
> 

Thanks for the reminder, This did indeed slip through the cracks.
Posting updated rev in a few mins..
-- 
Regards,
Nishanth Menon
