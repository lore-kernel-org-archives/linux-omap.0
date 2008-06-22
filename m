From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP3: Fix warnings in clock34xx.h
Date: Sun, 22 Jun 2008 13:29:02 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0806221327300.7503@utopia.booyaka.com>
References: <485E3F4D.7070508@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54501 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754058AbYFVT3F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Jun 2008 15:29:05 -0400
In-Reply-To: <485E3F4D.7070508@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sun, 22 Jun 2008, Dirk Behme wrote:

> Fix warnings

One other request while you're in there: could you please also convert the 
0x0070 in:

 #define OMAP3430_PRM_CLKSRC_CTRL                                       \
       OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0070)

to 

 #define OMAP3430_PRM_CLKSRC_CTRL                                       \
       _OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, OMAP3_PRM_CLKSRC_CTRL_OFFSET)



- Paul
