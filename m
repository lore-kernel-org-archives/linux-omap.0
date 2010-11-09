From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: DSS2 Query: Use of FIFO preload values
Date: Tue, 09 Nov 2010 12:01:10 +0200
Message-ID: <1289296870.3297.136.camel@tubuntu>
References: <FCCFB4CDC6E5564B9182F639FC356087034BF2DD10@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:23214 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753569Ab0KIJ7r (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Nov 2010 04:59:47 -0500
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087034BF2DD10@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Taneja, Archit" <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2010-11-09 at 05:20 +0100, ext Taneja, Archit wrote:
> Hi,
> 
> I was going through the DSS2 code and was unable to find a place
> where we set the 11th bit in DISPC_GFX_ATTRIBUTES or the 19th bit
> in DISPC_VIDn_ATTRIBUTES.
> 
> Setting these bits ensures that the DISPC FIFO's fill up to the
> high threshold value specified by us instead of the preload values.
> 
> Is this done on purpose or it got missed out?

A bit both. The TRM is quite unclear about fifo threshold and preload
configuration, and I've never understood how to configure them for
different interfaces. The current setup is mostly configured in such a
way that things seem to work =).

And if I recall right, even if the bits say that preload values are
used, changing the threshold values still broke things. So, as I said, I
never quite understood how they work.

 Tomi


