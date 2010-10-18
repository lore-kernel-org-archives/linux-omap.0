From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [RFC 0/5] OMAP4: mux: Add the OMAP4430 ES1 support
Date: Mon, 18 Oct 2010 15:53:17 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C014FAB29DA@dlee02.ent.ti.com>
References: <1285319748-28976-1-git-send-email-b-cousson@ti.com>
 <7A436F7769CA33409C6B44B358BFFF0C014FAB2762@dlee02.ent.ti.com>
 <4CBCB35E.9080502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59732 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755181Ab0JRUxT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Oct 2010 16:53:19 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o9IKrICa003000
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 18 Oct 2010 15:53:18 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id o9IKrI7C014443
	for <linux-omap@vger.kernel.org>; Mon, 18 Oct 2010 15:53:18 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o9IKrInm012824
	for <linux-omap@vger.kernel.org>; Mon, 18 Oct 2010 15:53:18 -0500 (CDT)
In-Reply-To: <4CBCB35E.9080502@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Cousson, Benoit
> Sent: Monday, October 18, 2010 3:52 PM
> 

> 
> On 10/18/2010 8:09 PM, Menon, Nishanth wrote:
> >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >> owner@vger.kernel.org] On Behalf Of Benoit Cousson
> >>
> > Ping? Is there a possibility for a v2 non-rfc ES2 support?
> 
> And what about a RFC v2? With ES2 support of course :-)
> 
> The changes I have done are breaking RX51 support due to the usage of
> low-level API from the mux code.
> 
> For the moment I just disabled that code from the RX51, so there is no
> way I send that except in a RFC form :-(
It'd be good to evolve this further.. looks like there is a bunch of
Drivers pending posting due to "lack of mux framework"..

Regards,
Nishanth Menon

