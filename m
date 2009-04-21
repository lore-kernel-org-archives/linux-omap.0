From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: 2.6.29 and SDP3430 <now 2.6.30-rc2, q3-2007 compiler error>
Date: Tue, 21 Apr 2009 10:08:35 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A9985B81@dbde02.ent.ti.com>
References: <782515bb0904082345j2a44da65s909a6834bab07330@mail.gmail.com>
 <20090409100343.71d34c16.jarkko.nikula@nokia.com>
 <13B9B4C6EF24D648824FF11BE8967162037BCF18A5@dlee02.ent.ti.com>
 <7A436F7769CA33409C6B44B358BFFF0CFFB1EEE1@dlee02.ent.ti.com>
 <20090409213420.GA7042@sirena.org.uk>
 <A24693684029E5489D1D202277BE89442EEB55E4@dlee02.ent.ti.com>
 <13B9B4C6EF24D648824FF11BE8967162037BE5B5F4@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60106 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751056AbZDUEjA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Apr 2009 00:39:00 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162037BE5B5F4@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>, "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, Mark Brown <broonie@sirena.org.uk>, "Menon, Nishanth" <nm@ti.com>, Tony Lindgren <ton>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, linux-omap <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>

Thanks Richard for root casing the issue.

Yes I also did observed this. Second time when framework calls "omap2_gp_timer_set_mode" set the periodic mode, R0 contains 0 (CLOCK_EVT_MODE_UNUSED) instead of 2(CLOCK_EVT_MODE_PERIODIC).

The assembly generated looks shocking because it prepares the second function arguments in register R1 as expected and then 'pop' destroys it. A "push" before a function call is reasonable but this not quite understandable.

Can this be taken up with Codesorcery team to check what is triggering compiler to generate such an assembly ?


 
> -----Original Message-----
> From: Woodruff, Richard 
> Sent: Tuesday, April 21, 2009 6:34 AM
> To: Aguirre Rodriguez, Sergio Alberto; Mark Brown; Menon, 
> Nishanth; Tony Lindgren
> Cc: Jarkko Nikula; linux-omap; Shilimkar, Santosh; Pandita, Vikram
> Subject: RE: 2.6.29 and SDP3430 <now 2.6.30-rc2, q3-2007 
> compiler error>
> 
> So using defconfig and float I debugged around a bit and for 
> q3-2007 I see what looks to be compiler error.
> 
> The parameter in R1 which sets PERIODIC mode for call to 
> clockevnet_set_mode()is destroyed.  See PNG.  I did make sure 
> at start_kernel the correct opcode was in place (no overwrite 
> later, no cache flush issue).
> 
> If I apply hacks to reduce optimization scope the code does 
> go past hang.  See attached hack.
> 
> It seems kind of odd this would bite now after a lot of new 
> use.  Perhaps the new mix of functions and layout triggered it.
> 
> Regards,
> Richard W.
> 
> 