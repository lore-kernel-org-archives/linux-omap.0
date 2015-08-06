From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 3/8] rtc: omap: Add external clock enabling support
Date: Thu, 6 Aug 2015 10:44:47 +0200
Message-ID: <20150806084447.GL3486@piout.net>
References: <1438771792-12604-1-git-send-email-j-keerthy@ti.com>
 <1438771792-12604-4-git-send-email-j-keerthy@ti.com>
 <20150805111316.GI16878@atomide.com>
 <20150805114119.GF3486@piout.net>
 <20150805114357.GG3486@piout.net>
 <55C1FB12.1000208@ti.com>
 <20150805123550.GH3486@piout.net>
 <55C2C1F0.9040102@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55C2C1F0.9040102-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 06/08/2015 at 07:39:52 +0530, Keerthy wrote :
> On Wednesday 05 August 2015 06:05 PM, Alexandre Belloni wrote:
> >On 05/08/2015 at 17:31:22 +0530, Keerthy wrote :
> >>This is a special one where in the enable bit is present in the rtc register
> >>space and not in the prcm register space. Since there was a concern on the
> >>external clock not being present i added a board dts flag.
> >>
> >
> >So you mean this external clock is coming internally from the SoC?
> 
> No what i meant is external clock is coming from Oscillator OSC1 @32.768KHz
> but the controlling bits are part of rtc register space.
> 
> TRM: http://www.ti.com/lit/ug/spruhl7c/spruhl7c.pdf
> 
> Section: 19.4.3.2 Clock Source Page 2836
> 
> Also register details:
> 19.4.5.19 RTCSS_OSC_REG Register (offset = 54h) [reset = 10h]
> 
> Page 2865.
> 

This confirms what I'm saying. Your issue here is that the driver is not
properly taking the clocks so when the PRCM is disabling CLK_32KHZ, you
end up without any clock.

You can use the clocks property in the device tree and pass two clocks,
the prcm one and the external crystal/external oscillator.
In the driver, you get both clock, clk_get_rate on the external one will
help you know whether it is populated or not (this will be 0 or 32768).
It is is populated, use it by writing 32KCLK_SEL.

Bonus points if you use the clock-accuracy and decide to switch between
PRCM and the external clock when going to suspend and resuming. I guess
an external RC oscillator is quite bad versus the PRCM.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
