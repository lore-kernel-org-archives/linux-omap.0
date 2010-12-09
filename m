From: Paul Walmsley <paul@pwsan.com>
Subject: git.pwsan.com *_2.6.38 branches rebased to Tony's for-next branch
Date: Wed, 8 Dec 2010 17:38:22 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012081736180.13430@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33590 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604Ab0LIAiY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 19:38:24 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org


Hi,

just a quick note to any users of the 2.6.38 branches on git.pwsan.com.  
hwmod_a_2.6.38 and pwrdm_prcm_a_2.6.38 have been updated to base on Tony's 
for-next branch.  pwrdm_prcm_b_2.6.38 has been updated to base on 
pwrdm_prcm_a_2.6.38 due to dependencies.  And wdt_2.6.38 has been updated 
to base on hwmod_a_2.6.38 due to dependencies.


- Paul
