From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2] omap: id: add chip id recognition for omap4430 es2.3
Date: Wed, 7 Dec 2011 16:23:42 -0800
Message-ID: <20111208002342.GW31337@atomide.com>
References: <1323302492-20211-1-git-send-email-x0132446@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:24042 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754399Ab1LHAXp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Dec 2011 19:23:45 -0500
Content-Disposition: inline
In-Reply-To: <1323302492-20211-1-git-send-email-x0132446@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Anders <x0132446@ti.com>
Cc: danders.dev@gmail.com, linux-omap@vger.kernel.org, nm@ti.com, aneesh@ti.com, jayabharath@ti.com

* David Anders <x0132446@ti.com> [111207 15:29]:
> allow for the omap4430 es2.3 revision to be recognized in the
> omap4_check_revision() function.
> 
> most aspects of all omap4430 es2.x versions are identical, however
> a number of small variations such as default pullup or pulldown
> resistor configurations vary between revisions.
> 
> detailed information on silicon errata for omap4430 revisions can
> be found at http://focus.ti.com/pdfs/wtbu/swpz009D.pdf

I have the earlier one already applied, this seems to be the
exact same patch, right?

Tony
