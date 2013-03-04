From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP1: Fix build related to kgdb.h no longer
 including serial_8250.h
Date: Mon, 4 Mar 2013 13:23:57 -0800
Message-ID: <20130304212357.GY11806@atomide.com>
References: <20130211224600.GB4801@atomide.com>
 <20130304190238.GU11806@atomide.com>
 <201303042032.50856.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:43332 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932607Ab3CDVYF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Mar 2013 16:24:05 -0500
Content-Disposition: inline
In-Reply-To: <201303042032.50856.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [130304 12:36]:
> On Monday 04 March 2013, Tony Lindgren wrote:
> > > Arnd & Olof, can you please apply this to your non-critical fixes
> > > or some other branch that gets merged early on during the merge
> > > window?
> > 
> > I'll apply this into omap-for-v3.9-rc1/fixes.
> > 
> 
> I totally missed this one from you, and I have a couple more such
> fixes for OMAP1 (and others) that I'll try to send out ASAP.

No problem. I have this and few other omap fixes queued up in
omap-for-v3.9-rc1/fixes. Will send a pull req on Tuesday for that.

Regards,

Tony
