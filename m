From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 07/14] USB: ohci-omap3: Add device tree support and
 binding information
Date: Mon, 11 Feb 2013 15:32:17 +0000
Message-ID: <20130211153217.GB15013@e106331-lin.cambridge.arm.com>
References: <1360252974-7912-1-git-send-email-rogerq@ti.com>
 <1360252974-7912-8-git-send-email-rogerq@ti.com>
 <20130211114611.GB2726@e106331-lin.cambridge.arm.com>
 <51190CA7.7010705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51190CA7.7010705@ti.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "b-cousson@ti.com" <b-cousson@ti.com>, "balbi@ti.com" <balbi@ti.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "kishon@ti.com" <kishon@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

> >> +Required properties:
> >> +
> >> +- compatible: should be "ti,ohci-omap3"
> >> +- reg: should contain one register range i.e. start and length
> >> +- interrupt-parent: phandle to the interrupt controller
> > 
> > I'm not sure that needs to be documented as a required property. It's a
> > standard property, and if it's defined for the parent node, you won't need it
> > here.
> 
> The last time I tried without 'interrupt-parent' it complained. Doesn't do it anymore.
> Maybe I did something wrong the last time. I'll remove it.
> 
> > 
> > Otherwise, this looks fine to me.
> 
> Thanks. I'll add your reviewed-by tag after addressing the above comment.

Sure.

Thanks,
Mark.
