From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [RFC 0/5] OMAP4: mux: Add the OMAP4430 ES1 support
Date: Mon, 18 Oct 2010 16:08:24 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C014FAB2A16@dlee02.ent.ti.com>
References: <1285319748-28976-1-git-send-email-b-cousson@ti.com>
 <7A436F7769CA33409C6B44B358BFFF0C014FAB2762@dlee02.ent.ti.com>
 <4CBCB35E.9080502@ti.com>
 <7A436F7769CA33409C6B44B358BFFF0C014FAB29DA@dlee02.ent.ti.com>
 <4CBCB4B3.3030207@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33599 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933126Ab0JRVI0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Oct 2010 17:08:26 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o9IL8PeL029987
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 18 Oct 2010 16:08:25 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id o9IL8PSh017654
	for <linux-omap@vger.kernel.org>; Mon, 18 Oct 2010 16:08:25 -0500 (CDT)
Received: from dsbe71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o9IL8P47022402
	for <linux-omap@vger.kernel.org>; Mon, 18 Oct 2010 16:08:25 -0500 (CDT)
In-Reply-To: <4CBCB4B3.3030207@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Cousson, Benoit
> Sent: Monday, October 18, 2010 3:57 PM

> >>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >>>> owner@vger.kernel.org] On Behalf Of Benoit Cousson
> >>>>
> >>> Ping? Is there a possibility for a v2 non-rfc ES2 support?
> >>
> >> And what about a RFC v2? With ES2 support of course :-)
> >>
> >> The changes I have done are breaking RX51 support due to the usage of
> >> low-level API from the mux code.
> >>
> >> For the moment I just disabled that code from the RX51, so there is no
> >> way I send that except in a RFC form :-(
> > It'd be good to evolve this further.. looks like there is a bunch of
> > Drivers pending posting due to "lack of mux framework"..
> 
> I guess that the current code should be good enough for that, isn't it?
> The main API will not change. Only the low API will become forbidden.

Unfortunately, not in l-o or kernel.org means not upstreamed solution :(
That is not a codebase for any driver developer to build on unfortunately :(.

Regards,
Nishanth Menon

