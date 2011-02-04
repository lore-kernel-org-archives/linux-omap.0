From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 0/2] Allow using machine ID for DEBUG_LL macros
Date: Thu, 03 Feb 2011 21:02:45 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102032057070.12104@xanadu.home>
References: <20110204012008.26298.16341.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:18550 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753721Ab1BDCCq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 21:02:46 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz25.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LG200ICLLMXSI00@vl-mh-mrz25.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Thu, 03 Feb 2011 21:01:45 -0500 (EST)
In-reply-to: <20110204012008.26298.16341.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Thu, 3 Feb 2011, Tony Lindgren wrote:

> Hi all,
> 
> Here are two patches that allow using machine ID for DEBUG_LL
> macros by adding a new macro inituart.

This won't work with the device tree support as the machine ID is then 
replaced with a catch-it-all-with-dt-support machine ID.


Nicolas
