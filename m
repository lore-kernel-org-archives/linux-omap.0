From: Tom Rini <trini-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH POST V2] ARM: dts: Add am57xx-beagle-x15
Date: Fri, 7 Nov 2014 13:37:04 -0500
Message-ID: <545D1150.9000700@ti.com>
References: <1415382433-31772-1-git-send-email-nm@ti.com>
Reply-To: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <beagleboard+bncBCF77LUSWAKRBWNC6SRAKGQEA6F3ZCA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1415382433-31772-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
List-Post: <http://groups.google.com/group/beagleboard/post>, <mailto:beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:beagleboard+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/beagleboard
Sender: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/beagleboard/subscribe>, <mailto:beagleboard+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1035534660134+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/beagleboard/subscribe>
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gerald-xujr6ya/RELK0SuXxyvBAPegYHeGw8Jk@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 11/07/2014 12:47 PM, Nishanth Menon wrote:
> BeagleBoard-X15 is the next generation Open Source Hardware
> BeagleBoard based on TI's AM5728 SoC featuring dual core 1.5GHz A15
> processor. The platform features 2GB DDR3L (w/dual 32bit busses),
> eSATA, 3 USB3.0 ports, integrated HDMI (1920x1080@60), separate LCD
> port, video In port, 4GB eMMC, uSD, Analog audio in/out, dual 1G
> Ethernet.
> 
> For more information, refer to:
> BeagleBoard-X15 Wiki:
> http://www.elinux.org/Beagleboard:BeagleBoard-X15
> 
> AM5728 is part of the Sitara product family whose additional details
> will be available: http://www.ti.com/lsds/ti/arm/overview.page
> 
> Technical Reference Manual for AM5728 is public domain at:
> http://www.ti.com/lit/spruhz6
> 
> Just add basic support for the moment, the following updates are needed:
>   i)	Ethernet - depends on SoC dts fixes
>   ii)	USB Client (USB2) - depends on GPIO extcon
>   ii)	HDMI - additional driver fixes pending
>   iii)	Audio - additional driver fixes pending
> 
> NOTE:
> AM5728 Data Manual (SPRS915L - August 2014) section 4.1.1 states: "All
> unused power supply balls must be supplied with the voltages specified
> in the Section 5.2, Recommended Operating Conditions". This implies
> that all unused voltage rails for AM5728 can never be switched off even
> if the hardware blocks inside that voltage domain is unused. Switching
> off these unused rails may result in stability issues on other domains
> and increased leakage and power-on-hour impacts.
> 
> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>

Reviewed-by: Tom Rini <trini-l0cyMroinI0@public.gmane.org>


-- 
Tom

-- 
For more options, visit http://beagleboard.org/discuss
--- 
You received this message because you are subscribed to the Google Groups "BeagleBoard" group.
To unsubscribe from this group and stop receiving emails from it, send an email to beagleboard+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
