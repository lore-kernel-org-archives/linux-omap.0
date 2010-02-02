From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] omap: Disable GAIA I2C1/I2C4 internal pull-ups
Date: Mon, 1 Feb 2010 20:37:01 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002012031360.19652@utopia.booyaka.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94026B4CBDEA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35042 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753925Ab0BBDhD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Feb 2010 22:37:03 -0500
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94026B4CBDEA@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pais, Allen" <allen.pais@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, m-sonasath@ti.com, tony@atomide.com

Hi Allen,

On Thu, 21 Jan 2010, Pais, Allen wrote:

> This patch disables GAIA I2C1 adn I2C4(SR) internal pull-up, to
> use only the external HW resistor >=470 Ohm for the assured
> functionality in HS mode.
> 
> While testing the I2C in High Speed mode, it was discovered that
> without a proper pull-up resistor, there is data corruption during
> multi-byte transfer. RTC(time_set) test case was used for testing.
> 
> >From the analysis done, it was concluded that ideally we need a
> pull-up of 1.6k Ohm(recomended) or atleast 470 Ohm or greater for
> assured performance in HS mode.

A few more questions.

1. Does this patch also apply to other TI PMICs, e.g., Triton2, Reno, etc?

2. It sounds like, from the patch description, that HS I2C mode is not 
reliable on boards without external pullups.  Shouldn't this patch (or one 
in the same series) provide some way for mach-omap2/board-*.c files to 
indicate this to the I2C code, such that HS I2C can be disallowed on those 
boards?  Similarly, for SmartReflex, which has an internal I2C controller 
but does not use the OMAP I2C driver code, shouldn't there be a similar 
mechanism for that code?


- Paul
