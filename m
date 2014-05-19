From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] ARM: dts: AM43xx: Touchscreen support
Date: Mon, 19 May 2014 09:44:21 -0700
Message-ID: <20140519164420.GH4849@atomide.com>
References: <1398861805-9229-1-git-send-email-rogerq@ti.com>
 <20140506163943.GL18474@atomide.com>
 <5379C4DC.8050004@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:60848 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932493AbaESQoZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2014 12:44:25 -0400
Content-Disposition: inline
In-Reply-To: <5379C4DC.8050004@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: bcousson@baylibre.com, mugunthanvnm@ti.com, nsekhar@ti.com, balbi@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [140519 01:47]:
> Hi Tony,
> 
> On 05/06/2014 07:39 PM, Tony Lindgren wrote:
> > * Roger Quadros <rogerq@ti.com> [140430 05:43]:
> >> Hi Benoit & Tony,
> >>
> >> These patches add I2C touch screen support for am43x-epos-evm
> >> and am437x-gp-evm.
> >>
> >> Relevant driver side changes are here.
> >> http://thread.gmane.org/gmane.linux.kernel.input/35803
> >>
> >> Please queue this for -next (3.16). Thanks.
> > 
> > Applying both into omap-for-v3.16/dt thanks.
> 
> There has been a change in the DT bindings [1]. i.e. x-size, y-size now become touchscreen-size-x and touchscreen-size-y. I will send a v2 for this series. Please drop these patches and take the v2 instead. Thanks.

Sorry already pushed out, please send a fix instead
against omap-for-v3.16/dt branch.

Thanks,

Tony
