From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: RE: [RFC] OMAP: I2C: Use correct bit for CLOCKACTIVITY
Date: Thu, 05 Mar 2009 14:32:30 +0200
Message-ID: <1236256350.29572.67.camel@eenurkka-desktop>
References: <12362344552581-git-send-email-ext-eero.nurkkala@nokia.com>
	 <alpine.DEB.2.00.0903050113021.26353@utopia.booyaka.com>
	 <1236242774.29572.45.camel@eenurkka-desktop>
	 <7A436F7769CA33409C6B44B358BFFF0CFF3500A2@dlee02.ent.ti.com>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:36867 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502AbZCEMf1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2009 07:35:27 -0500
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0CFF3500A2@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Menon, Nishanth" <nm@ti.com>
Cc: ext Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Woodruff, Richard" <r-woodruff2@ti.com>

On Thu, 2009-03-05 at 13:29 +0100, ext Menon, Nishanth wrote:
> > 
> Yep, that does look nuts :(.. Have pinged internally.. 
> 
> Regards,
> Nishanth Menon

Thank you!

Could you please consider taking a loot at every single block
(SPI, I2C, DMA... etc).

If I were you, I'd copy-paste the CLOCKACTIVITY features as
is it to every single HW block. So it'd be coherent. I have a
distant feeling that's what you've done, but TRM says something
else..

- Eero


