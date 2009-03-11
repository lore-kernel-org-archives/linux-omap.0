From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: DSPBRIDGE+BRIDGE_DVFS: Crashes on multiple reload
Date: Wed, 11 Mar 2009 11:40:06 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162037B763B7D@dlee02.ent.ti.com>
References: <7A436F7769CA33409C6B44B358BFFF0CFF48FEA4@dlee02.ent.ti.com>
 <13B9B4C6EF24D648824FF11BE8967162037B763A5A@dlee02.ent.ti.com>
 <7A436F7769CA33409C6B44B358BFFF0CFF490055@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51373 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751725AbZCKQkQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 12:40:16 -0400
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0CFF490055@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: ext Paul Walmsley <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>


> From: Menon, Nishanth
> Sent: Wednesday, March 11, 2009 11:33 AM

> > Does it need DVFS enabled to fail? Is voltage high enough (to current DM)?
> > There were some issues there.
> Yes, Rajendra's VDD change is merged in [1] pm branch.

Ok.

> It does not make sense for clock notifier_registration to oops out.. it has'nt
> come out of init even..
>
> This looks like list_del missing in clock_notifier unregistration function :(.
> I have a patch in place.. sending in a few mins

Yes.  Side issue I pointed out will come up later.  If notifier doesn't work there might be a few bugs its useable.

Regards,
Richard W.
