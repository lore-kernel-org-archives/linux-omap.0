From: Adrian Hunter <ext-adrian.hunter@nokia.com>
Subject: Re: [PATCH] ARM: OMAP: OneNAND for OMAP3
Date: Wed, 06 Aug 2008 09:53:55 +0300
Message-ID: <48994A83.8040904@nokia.com>
References: <4892C533.50904@nokia.com> <20080804140243.GG8885@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:24536 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbYHFGwd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Aug 2008 02:52:33 -0400
In-Reply-To: <20080804140243.GG8885@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

I have split the patch into 3 patches, tidied up drivers/mtd/onenand/omap2.c
ready to be sent to MTD (which I will do shortly), and made multi-omap changes
