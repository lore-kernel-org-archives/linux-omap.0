From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Git tree updated to v2.6.27-rc2, help needed
Date: Mon, 11 Aug 2008 13:58:24 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0808111355250.10219@utopia.booyaka.com>
References: <20080811152620.GO25784@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54263 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753943AbYHKT6Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Aug 2008 15:58:25 -0400
In-Reply-To: <20080811152620.GO25784@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Sakari Ailus <sakari.ailus@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Eduardo Valentin <edubezval@gmail.com>

On Mon, 11 Aug 2008, Tony Lindgren wrote:

> - Booting fails early on 3430sdp for some reason

This affects all ARMv7 and is due to a bug in the TLB clearing code; patch 
coming shortly.

> - Alignment error on omap2/3. This seems to happen also with
>   718fc6cd4db902aa2242a736cc3feb8744a4c71a reverted?

Haven't seen this here with CSL gcc 2007q3-51 on OMAP3.


- Paul
