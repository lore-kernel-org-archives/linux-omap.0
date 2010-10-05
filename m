From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/3] OMAP: McBSP: Fix CLKR and FSR signal muxing
Date: Tue, 5 Oct 2010 09:11:55 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010050911230.13816@utopia.booyaka.com>
References: <1286281775-27692-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57856 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524Ab0JEPL4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 11:11:56 -0400
In-Reply-To: <1286281775-27692-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Tue, 5 Oct 2010, Jarkko Nikula wrote:

> Fix bit clear. Now it clears all other bits than mask bit where it should
> clear only it.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Paul Walmsley <paul@pwsan.com>

Doh.  Thanks Jarkko.

Obviously this is an important patch and should go in ASAP.

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
