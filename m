From: Tony Lindgren <tony@atomide.com>
Subject: Re: ARM: dts: omap3: NAND support - how?
Date: Fri, 19 Apr 2013 09:15:22 -0700
Message-ID: <20130419161522.GJ10155@atomide.com>
References: <1366325282.4232.6.camel@lovely>
 <51708097.6070102@ti.com>
 <51708131.2040208@ti.com>
 <1366362081.3928.18.camel@mars>
 <1366372957.3928.104.camel@mars>
 <51714E0D.7020304@ti.com>
 <1366383208.3928.144.camel@mars>
 <5171647B.9070108@ti.com>
 <20130419154804.GH10155@atomide.com>
 <5171692C.1080407@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19590 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756945Ab3DSQP2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Apr 2013 12:15:28 -0400
Content-Disposition: inline
In-Reply-To: <5171692C.1080407@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Christoph Fritz <chf.fritz@googlemail.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Daniel Mack <daniel@zonque.org>, linux-omap@vger.kernel.org

* Jon Hunter <jon-hunter@ti.com> [130419 09:01]:
> On 04/19/2013 10:48 AM, Tony Lindgren wrote:
> > 
> > What about DVFS though? The L3 clock can get rescaled with DVFS,
> > and after that the retime function needs to get called. We are
> > not doing it in the mainline tree, but at least n8x0 - n900 vendor
> > trees were doing it.
> 
> I wondered if you would mention that ;-)
> 
> If you look at the implementation of the omap2_nand_gpmc_retime(), it
> does not actually perform any retiming base upon frequency whatsoever
> (unlike smc91c96_gpmc_retime). So right now omap2_nand_gpmc_retime is a
> basic wrapper around gpmc_cs_set_timings() really adding no value.
> Hence, I agree with Christoph's patch to remove it.

OK thanks fine with me then.

Tony
