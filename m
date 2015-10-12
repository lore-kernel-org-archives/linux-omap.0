From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/11] ARM: OMAP/DTS: dra7/72-evm/beagle-x15: Audio
 support
Date: Mon, 12 Oct 2015 13:57:32 -0700
Message-ID: <20151012205732.GW23801@atomide.com>
References: <1440400807-32274-1-git-send-email-peter.ujfalusi@ti.com>
 <55F68A60.6050900@ti.com>
 <20150914162851.GM4215@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150914162851.GM4215@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [150914 09:32]:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [150914 01:54]:
> > Hi Tony,
> > 
> > On 08/24/2015 10:19 AM, Peter Ujfalusi wrote:
> > > Hi,
> > > 
> > > this series will enable analog audio (via onboard aic310x codec) for dra7-evm,
> > > dra72-evm and am57xx-beagle-x15 boards.
> > > In these board McASP3 is connected to the codec and for the McASP3 we needed to
> > > have the DMA crossbar in place since the request lines are not mapped by
> > > default.
> > 
> > Did you had a chance to look at this series?
> 
> Looks OK to me, will look at it more once we have the fixes merged.
> 
> Paul may have comments on the hwmod chage, looks like you forgot
> to Cc him on it. Can you please resend that one with Paul in Cc?

Applying all the dts changes into omap-for-v4.3/dt thanks. Paul
can pick up the hwmod change then after reviewing it.

Regards,

Tony
