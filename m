From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: public git l2 cache off.
Date: Mon, 5 May 2008 18:27:03 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D9130274290439AAD8@dlee13.ent.ti.com>
References: <1209575641-25613-1-git-send-email-tony@atomide.com> <20080505131403.93d0a64d.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59806 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753207AbYEEX1k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 May 2008 19:27:40 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20080505131403.93d0a64d.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Hi,

Looks like a tweak from the ARM or TI tree may be needed.  Builds of recent pulls of the OMAP3 kernel show L2 cache is disabled. This really has a huge performance impact.

I don't have time right now to suggest a patch but may look some time this week.  TI internal kernels do have it enabled.

A stop in Lauterbach and a look at the L2EN bit in AUX control register will show it is not correct.

Regards,
Richard W.

