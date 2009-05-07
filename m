From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Beagleboard rev C memory timings & suspend/resume
Date: Thu, 7 May 2009 13:18:41 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0905071316160.17514@utopia.booyaka.com>
References: <200904291553.49378.jpihet@mvista.com> <alpine.DEB.2.00.0905060009100.17514@utopia.booyaka.com> <200905071318.30501.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53621 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755430AbZEGTSm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 May 2009 15:18:42 -0400
In-Reply-To: <200905071318.30501.jpihet@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jpihet@mvista.com>
Cc: linux-omap <linux-omap@vger.kernel.org>


Hello Jean,

one other suggestion.  You mentioned that you had self-refresh working on 
another OMAP3430 board with two SDRAM chip-selects.  You might consider 
dumping the SDRC registers from that board, and dumping the SDRC registers 
on Beagle rev C, and comparing.  It could be that the bootloader on your 
other board is setting some important bit.


- Paul
