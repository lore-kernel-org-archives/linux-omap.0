From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [RFC] OMAP: I2C: Use correct bit for CLOCKACTIVITY
Date: Thu, 5 Mar 2009 06:54:15 -0600
Message-ID: <7A436F7769CA33409C6B44B358BFFF0CFF3500B7@dlee02.ent.ti.com>
References: <12362344552581-git-send-email-ext-eero.nurkkala@nokia.com>
	 <alpine.DEB.2.00.0903050113021.26353@utopia.booyaka.com>
	 <1236242774.29572.45.camel@eenurkka-desktop>
	 <7A436F7769CA33409C6B44B358BFFF0CFF3500A2@dlee02.ent.ti.com>
 <1236256350.29572.67.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48001 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335AbZCEMya convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2009 07:54:30 -0500
In-Reply-To: <1236256350.29572.67.camel@eenurkka-desktop>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext-eero.nurkkala@nokia.com" <ext-eero.nurkkala@nokia.com>
Cc: ext Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Woodruff, Richard" <r-woodruff2@ti.com>

> -----Original Message-----
> From: Eero Nurkkala [mailto:ext-eero.nurkkala@nokia.com]
> Sent: Thursday, March 05, 2009 2:33 PM
> To: Menon, Nishanth
> Cc: ext Paul Walmsley; linux-omap@vger.kernel.org; Woodruff, Richard
> Subject: RE: [RFC] OMAP: I2C: Use correct bit for CLOCKACTIVITY
> 
> Thank you!
> 
> Could you please consider taking a loot at every single block
> (SPI, I2C, DMA... etc).
> 
> If I were you, I'd copy-paste the CLOCKACTIVITY features as
> is it to every single HW block. So it'd be coherent. I have a
> distant feeling that's what you've done, but TRM says something
> else..
me? I am just a code junkie ;).. "They" wont let me write the TRM :(.. :D... 

Anyways, I am told internally that the right setting is the one given in table 18-44, i.e.:

9:8 CLOCKACTIVITY Clock Activity selection bits RW 0x0
    0x0: Both clocks can be cut off
    0x1: Only interface clock must be kept active; functional clock can be cut off
    0x2: Only functional clock must be kept active; interface clock can be cut off
    0x3: Both clocks must be kept active

Have asked for the rest too.. But I am told that in case of these kind of issues, we should refer to the one in the register settings.

Regards,
Nishanth Menon
