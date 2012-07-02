From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v3] ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset fix
 issues.
Date: Mon, 2 Jul 2012 10:05:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1207021003050.6472-100000@netrider.rowland.org>
References: <CAP05o4JctmjdAk+S--v9T0PM0kabFN50ESyiPiwAYXNUX5yyBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:38467 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751173Ab2GBOFj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jul 2012 10:05:39 -0400
In-Reply-To: <CAP05o4JctmjdAk+S--v9T0PM0kabFN50ESyiPiwAYXNUX5yyBg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Partha Basak <parthab@india.ti.com>, Igor Grinberg <grinberg@compulab.co.il>, mantesh@ti.com, s-sapna1@ti.com, Russ Dill <Russ.Dill@gmail.com>

On Mon, 2 Jul 2012, Munegowda, Keshava wrote:

> Hi Samuel
>        please drop this patch for now , since Alan stern has mentioned
> improvements for this patch and we
> need to wait for Alan's new patch on ehci-omap.c and then Rus dill
> patch and my usbhs tll
> patch series need to be rebased.

No, that's okay.  I rebased my patch on top of Russ's; see

	http://marc.info/?l=linux-usb&m=134098478928668&w=2

so Russ's patch should be kept.  My patch needed other changes also, so
this wasn't a big deal.

The extra problems I mentioned in an earlier email will still need to
be fixed after both Russ's patch and my own are merged.

Alan Stern

