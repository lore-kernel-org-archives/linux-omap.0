From: Paul Walmsley <paul@pwsan.com>
Subject: Re: v3.4-rc4 DSS PM problem (Was: Re: Problems with 3.4-rc5)
Date: Thu, 24 May 2012 10:19:42 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205240201500.2572@utopia.booyaka.com>
References: <1336033721.14378.2.camel@deskari>  <WC20120503084938.900446@terrafix.co.uk>  <1336050442.14378.10.camel@deskari>  <WC20120504091902.970499@terrafix.co.uk> <1336139415.2552.4.camel@deskari>  <1336140072.2552.6.camel@deskari>
 <WC20120504140943.7604D0@terrafix.co.uk>  <1336143281.2552.21.camel@deskari> <1336143500.2552.23.camel@deskari>  <1336483598.5761.45.camel@deskari> <WC20120514073642.6306D7@terrafix.co.uk>  <1336982138.2532.32.camel@lappyti>  <alpine.DEB.2.00.1205151148440.16649@utopia.booyaka.com>
  <1337159300.7692.22.camel@deskari> <1337160001.7692.24.camel@deskari>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39061 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933336Ab2EXQTo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 May 2012 12:19:44 -0400
In-Reply-To: <1337160001.7692.24.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com, Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org, b-cousson@ti.com

On Wed, 16 May 2012, Tomi Valkeinen wrote:

> JFYI, I also tested changing DISPC's SYSCONFIG:CLOCKACTIVITY, which, to
> me, sounds a bit related to dpll autoidle. By default it's 0, "interface
> and functional clocks can be switched off". I tested the three other
> values, but none of them had any effect.

As I understand it (which could very well be mistaken), the CLOCKACTIVITY 
bits are only useful in situations where we'd like to allow the 
interconnect to idle, but keep the functional clock of the IP block (or 
subsystem) running.  Right now, we control an IP block's interface clock 
and functional clock together, so CLOCKACTIVITY should probably always be 
0.

But for drivers that want to do more fine-grained clock control, or if we 
create some notion of an "autonomous IP block" in our integration layer 
for devices that can function without its interconnect, it might be worth 
exploring whether it is worthwhile to change those bits.


- Paul
