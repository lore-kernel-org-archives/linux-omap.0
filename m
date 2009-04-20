From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: 2.6.29 and SDP3430
Date: Mon, 20 Apr 2009 18:39:27 -0500
Message-ID: <A24693684029E5489D1D202277BE89442EEB55E4@dlee02.ent.ti.com>
References: <782515bb0904082345j2a44da65s909a6834bab07330@mail.gmail.com>
 <20090409100343.71d34c16.jarkko.nikula@nokia.com>
 <13B9B4C6EF24D648824FF11BE8967162037BCF18A5@dlee02.ent.ti.com>
 <7A436F7769CA33409C6B44B358BFFF0CFFB1EEE1@dlee02.ent.ti.com>
 <20090409213420.GA7042@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39888 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752269AbZDTXjt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Apr 2009 19:39:49 -0400
In-Reply-To: <20090409213420.GA7042@sirena.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>, "Menon, Nishanth" <nm@ti.com>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, Jarkko Nikula <jarkko.nikula@nokia.com>, linux-omap <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Mark Brown
> Sent: Thursday, April 09, 2009 4:34 PM
> To: Menon, Nishanth
> Cc: Woodruff, Richard; Jarkko Nikula; linux-omap
> Subject: Re: 2.6.29 and SDP3430
> 
> On Thu, Apr 09, 2009 at 01:32:27PM -0500, Menon, Nishanth wrote:
> 
> > implementor 41 architecture 3 part 30 variant c rev 1
> > regulator_init_complete: incomplete constraints, leaving VAUX3 on
> 
> That last message shouldn't be a problem - it means that if the machine
> init code had requested it the regulator core would've powered off the
> VAUX3 regulator since it has no users.

Well, I just disabled TWL4030 regulator support (CONFIG_REGULATOR_TWL4030) and now it boots without problem...

I'm using a SDP3430 VG9.0.0 with an ES3.1 chip.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

