From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] Remove duplicate Kconfig LEDS_LP5521 entry introduced
 by 67a32ec7
Date: Wed, 24 Jun 2009 11:59:14 +0300
Message-ID: <20090624085914.GA16639@nokia.com>
References: <871vpaj9d1.fsf@small.ssi.corp>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:56918 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbZFXJBB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Jun 2009 05:01:01 -0400
Content-Disposition: inline
In-Reply-To: <871vpaj9d1.fsf@small.ssi.corp>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Arnaud Ebalard <arno@natisbad.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>

On Wed, Jun 24, 2009 at 10:59:06AM +0200, ext Arnaud Ebalard wrote:
> Hi,
> 
> While playing with kernel configuration for my N810, I noticed a
> duplicate config entry for LEDS_LP5521.
> 
> AFAICT, it was added by commit 67a32ec7 (leds: introduce lp5521 led
> driver) but the entry was already there from 43350bf4 (leds: lp5521:
> move to drivers/leds).
> 
> Following patch is against current linux-omap tree.

probably automerge issues.

-- 
balbi
