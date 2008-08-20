From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [RFC][DRAFT] TODO list for TI DSP BRIDGE
Date: Wed, 20 Aug 2008 09:32:32 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE896716203621E71D9@dlee02.ent.ti.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E0B38DC7B@dlee03.ent.ti.com>
	<94a0d4530808181308i53a9b11fyb20af0b21785c0d9@mail.gmail.com>
	<20080819062422.GD17276@atomide.com>
 <20080820.131042.200608197.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:38248 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752003AbYHTOdJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Aug 2008 10:33:09 -0400
In-Reply-To: <20080820.131042.200608197.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "tony@atomide.com" <tony@atomide.com>
Cc: "felipe.contreras@gmail.com" <felipe.contreras@gmail.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "soni.trilok@gmail.com" <soni.trilok@gmail.com>, "Pasam, Vijay" <vpasam@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "siarhei.siamashka@nokia.com" <siarhei.siamashka@nokia.com>, "Ramirez Luna, Omar" <x00omar@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

Hi Hiroshi,

> I sent some patches based on the above suggestion.
>
>   http://marc.info/?l=linux-omap&m=121922597019873&w=2
>   http://marc.info/?l=linux-omap&m=121922593919766&w=2
>
> I think that this virtual clock may allow any arbitrary combination of
> clocks and it may be possible to have multiple hierarchy of virtual
> clocks like:
>
>    dsp_clocks
>    |
>    |-- peripheral_clocks
>    |     |
>    |     |-- gpt5
>    |     |    |- gpt5_ick
>    |     |    `- gpt5_fck
>    |
>    |-- ....
>    ..
>
> Any comments would be appreciated.

A few quick comments:

- First off, I do like the idea of virtual clocks for grouping.  I did do this for OMAP2 for completely internal and dependent root clocks.  I also thought it might be nice to extend clock frame work to allow external clock registration (say for a codec chip).  In our local tree I did even add it.  One main issue was the internal clock structure is supposed to be opaque and you need to set internals to add a clock node.

- I worry a bit about grouping of internal resources which may be allocated differently per implementation.  Perhaps a board specific resource can handle it, but you've not included that in the patch.

- Where is the board specific side of this call?  I see clock calls added to clock.c but not resources added to mach-omap2/xyz-board.c.

- You're not preserving the enable error path back to the virtual clock.  A recovery from a failure would be messy.

- Will these clocks always be handled as a group?  If I were to try and optimize I might shut down a gpt5 clock individually to allow a PER domain to power off.  The DSP should aggressively be letting go of resource when it doesn't need them to allow power to work.  1 virtual resource with all related clocks would not be right.

If you wanted grouping their might be like DSP-CORE, DSP-Streaming-Audio, Dsp-...  You will want better granularity.  So the enable/disables are effective for power savings.  This is especially true if your not even using say a McBSP and are doing something like JPEG decode.


Regards,
Richard W.

