From: <ext-Eero.Nurkkala@nokia.com>
Subject: RE: [PATCH 06/20] OMAP: McBSP: Use appropriate value for startup
 delay
Date: Fri, 31 Jul 2009 09:21:30 +0200
Message-ID: <1FFEF31EBAA4F64B80D33027D4297760047DF3D65A@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-2-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-3-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-4-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-5-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-6-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-7-git-send-email-eduardo.valentin@nokia.com>,<20090730215642.2f509757.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:38400 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548AbZGaHVu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Jul 2009 03:21:50 -0400
In-Reply-To: <20090730215642.2f509757.jhnikula@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jhnikula@gmail.com, eduardo.valentin@nokia.com
Cc: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org, peter.ujfalusi@nokia.com


Jarkko Nikula [jhnikula@gmail.com] wrote:
> Are you sure this change is necessary? CLKSRG is kind of master clock
> to McBSP so original stetson guessed (?) 100 us should be fine for all
> serial links where bit clock is higher than 20 kHz.

The McBSP / DMA stuff doesn't really work properly, when PM is enabled
to full extent. The first DMA goes in _before_ the omap_mcbsp_start(),
so the higher delay compensates DMA misbehavior in a way...

.. L/R channels also may switch at random initially with full PM enabled.
So the L/R fix is only working, if no PM is enabled (sigh).

Need to make that work fine (no L/R switching and early no DMA completions)
to get rid of the higher, 500us, timeout. Maybe try not having 
XCCR/RCCR dma enable bit initially, but enabling them at omap_mcbsp_start()?
(I'd try if I wasn't also on vacation).

- Eero