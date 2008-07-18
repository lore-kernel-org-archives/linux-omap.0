From: Kai Svahn <kai.svahn@nokia.com>
Subject: Re: N800 problems with MMC, LM8323 on current linux-omap git head
Date: Fri, 18 Jul 2008 12:11:11 +0300
Message-ID: <20080718091110.GN25099@six.research.nokia.com>
References: <alpine.DEB.1.00.0807172113070.467@utopia.booyaka.com> <20080718084520.GF28713@gandalf.research.nokia.com> <alpine.DEB.1.00.0807180247000.467@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:46912 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753304AbYGRJLs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jul 2008 05:11:48 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807180247000.467@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, jarkko.lavinen@nokia.com, kai.svahn@nokia.com, tony@atomide.com

On Fri, Jul 18, 2008 at 02:49:45AM -0600, ext Paul Walmsley wrote:
> 
> Kai, does MMC on N800 use the on-chip controller, or a controller on I2C?

If I remember right it uses internal controller but the voltage has to
be set for each slot from Menelaus and Menelaus is controlled by i2c. 

Cheers,
Kai
