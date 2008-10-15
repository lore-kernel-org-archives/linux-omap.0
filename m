From: Paul Walmsley <paul@pwsan.com>
Subject: Re: omapfb: help from userspace
Date: Wed, 15 Oct 2008 05:57:17 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0810150556140.14740@utopia.booyaka.com>
References: <e5e6ade50810081136n2067600csf3c77195da0ef110@mail.gmail.com>  <e5e6ade50810081321h6f638cafjbe00f4c8a3a50f2c@mail.gmail.com>  <13B9B4C6EF24D648824FF11BE89671620365B58844@dlee02.ent.ti.com>  <B85A65D85D7EB246BE421B3FB0FBB59301B0108CAB@dbde02.ent.ti.com>
  <20081009124357.GF26230@atomide.com> <e5e6ade50810091055se7af4aasc404eb92f176dfeb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41242 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420AbYJOL5T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 07:57:19 -0400
In-Reply-To: <e5e6ade50810091055se7af4aasc404eb92f176dfeb@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nathan Monson <nmonson@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, "Woodruff, Richard" <r-woodruff2@ti.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, "TK, Pratheesh Gangadhar" <pratheesh@ti.com>

Hi Nathan,

On Thu, 9 Oct 2008, Nathan Monson wrote:

> On Thu, Oct 9, 2008 at 5:43 AM, Tony Lindgren <tony@atomide.com> wrote:
> > Nathan, good to hear that the SO mode helps. But since you seem to
> > have it easily reproducable..
> 
> Reproducing is as easy as applying the DSP Bridge kernel patches and
> then running the 'ping.out' sample like this:  while true; do
> ping.out; done
> 
> > Could you try the following patch based on RMK's earlier patch
> > without the strongly ordered patch and see if that makes any
> > difference?
> 
> Maybe it lasted a few seconds longer, or maybe it was luck, but in any
> case it eventually went into an IRQ -33 loop even with this patch.

could you try Lauri's patch posted here:

http://marc.info/?l=linux-omap&m=122407150608770&w=2

without the strongly-ordered memory patches?


- Paul
