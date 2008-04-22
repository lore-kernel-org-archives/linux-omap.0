From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 2/2] PLAT-OMAP: MCBSP: Move code mach specific from
 plat-omap to mach-omap
Date: Tue, 22 Apr 2008 12:38:19 +0300
Message-ID: <20080422123819.c46428d6.jarkko.nikula@nokia.com>
References: <20080414181827.GE4463@kedavra.cpe.vivax.com.br>
	<1208203891-11225-1-git-send-email-edubezval@gmail.com>
	<1208203891-11225-2-git-send-email-edubezval@gmail.com>
	<20080421183305.GB12099@atomide.com>
	<a0580c510804212329p141712d7g97bf9f07dbd59621@mail.gmail.com>
	<7EAD1AEEA7621C45899FE99123E124A001922611@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:30553 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004AbYDVJiD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2008 05:38:03 -0400
In-Reply-To: <7EAD1AEEA7621C45899FE99123E124A001922611@dbde01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Syed Mohammed, Khasim" <khasim@ti.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@indt.org.br>

On Tue, 22 Apr 2008 14:54:21 +0530
"ext Syed Mohammed, Khasim" <khasim@ti.com> wrote:

> Good to know you are volunteering for upgrading McBSP driver.
> 
> Can you also make sure that McBSP driver uses DMA chaining APIs? With
> out chaining support McBSP Driver will be unusable for a real time
> audio playback.
> 
Multichannel chaining is not necessary AFAIK because we can set up
OMAP DMA transfer so that interrupt is generated in end of each ALSA
period and then link channel with itself.

I did it so in my ASoC driver:

http://opensource.wolfsonmicro.com/cgi-bin/gitweb.cgi?p=linux-2.6-asoc.git;a=blob;f=sound/soc/omap/omap-pcm.c;h=62370202c649c5aac50e542626b574a7079909e2;hb=dev

In fact, my first version used the chaining API, until we figured out
this with Tony :-)


Jarkko
