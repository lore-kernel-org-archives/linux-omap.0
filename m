From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v5 4/7] arm: omap4: hwmod: introduce emu hwmod
Date: Tue, 8 Nov 2011 08:42:15 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1111080837250.10451@utopia.booyaka.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com> <1319467559-5518-5-git-send-email-ming.lei@canonical.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43135 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755907Ab1KHPmQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Nov 2011 10:42:16 -0500
In-Reply-To: <1319467559-5518-5-git-send-email-ming.lei@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>, b-cousson@ti.com
Cc: linux@arm.linux.org.uk, will.deacon@arm.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@deeprootsystems.com


Hi

I just read 

http://comments.gmane.org/gmane.comp.embedded.pandaboard/168

Looks to me that the L3_EMU interconnect and the emulation IP blocks need 
to be added to the OMAP4 hwmod data, based on Section 2.2.1 "L3_EMU Memory 
Space Mapping" in the OMAP4460 TRM Rev. I.  If the clockdomain & 
powerdomain are correctly defined then the OMAP framework code will 
automatically enable these too.



- Paul
