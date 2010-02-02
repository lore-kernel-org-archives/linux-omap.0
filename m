From: "Sonasath, Moiz" <m-sonasath@ti.com>
Subject: RE: [PATCH 1/2] omap: Disable GAIA I2C1/I2C4 internal pull-ups
Date: Tue, 2 Feb 2010 15:50:14 -0600
Message-ID: <CD8CC2B65FEE304DA95744A5472698F202AA321E3B@dlee06.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94026B4CBDEA@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1002012031360.19652@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58415 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756824Ab0BBVuU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Feb 2010 16:50:20 -0500
In-Reply-To: <alpine.DEB.2.00.1002012031360.19652@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Pais, Allen" <allen.pais@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>


Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Monday, February 01, 2010 9:37 PM
> To: Pais, Allen
> Cc: linux-omap@vger.kernel.org; Sonasath, Moiz; tony@atomide.com
> Subject: Re: [PATCH 1/2] omap: Disable GAIA I2C1/I2C4 internal pull-ups
> 
> Hi Allen,
> 
> On Thu, 21 Jan 2010, Pais, Allen wrote:
> 
> > This patch disables GAIA I2C1 adn I2C4(SR) internal pull-up, to
> > use only the external HW resistor >=470 Ohm for the assured
> > functionality in HS mode.
> >
> > While testing the I2C in High Speed mode, it was discovered that
> > without a proper pull-up resistor, there is data corruption during
> > multi-byte transfer. RTC(time_set) test case was used for testing.
> >
> > >From the analysis done, it was concluded that ideally we need a
> > pull-up of 1.6k Ohm(recomended) or atleast 470 Ohm or greater for
> > assured performance in HS mode.
> 
> A few more questions.
> 
> 1. Does this patch also apply to other TI PMICs, e.g., Triton2, Reno, etc?

Thanks for raising this important question.

This patch does hold true for the following PM IC's:
Triton(TWL4030)/GAIA(TWL5030)/Phoenix(TWL6030)

I did verify, the register 'REG_GPPUPDCTR1' holds true for Triton(TWL4030)/GAIA(TWL5030), hence for OMAP34XX/36XX.
But there is a register change for this PU/PD control on Phoenix(TWL6030) which is used with OMAP44XX. So I might have to modify this patch a little as this code will apply for TWL4030/5030 and have to introduce new code to achieve the intended fix for TWL6030.

I don't think so it applies to Reno though, AFAIK its not included in the Triton family and not used with OMAP on any boards.

> 
> 2. It sounds like, from the patch description, that HS I2C mode is not
> reliable on boards without external pullups.  Shouldn't this patch (or one
> in the same series) provide some way for mach-omap2/board-*.c files to
> indicate this to the I2C code, such that HS I2C can be disallowed on those
> boards?  Similarly, for SmartReflex, which has an internal I2C controller
> but does not use the OMAP I2C driver code, shouldn't there be a similar
> mechanism for that code?

Its not that HS I2C mode is not reliable without external pull-ups but what was observed is that, for reliable operation a HW resitor >= 470 Ohm is needed as pull-up. Now if we keep the internal pull-ups on PIC's enabled they come in parallel to the external pull-up and might lead to lower equivalent resistor value (< required 470 Ohm). That was the reason we decided to just rely on the external resistor on OMAP SOM, and disable any internal pull-ups on Power IC as well as on OMAP (36XX/44XX).
 
> 
> 
> - Paul
