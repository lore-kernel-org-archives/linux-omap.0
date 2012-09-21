From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] Documentation: RCU: update the stall warning message
 "timer=-1" to match reality
Date: Fri, 21 Sep 2012 22:39:38 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209212239230.31812@utopia.booyaka.com>
References: <alpine.DEB.2.00.1209211610280.30239@utopia.booyaka.com> <20120921220741.GG2454@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:35185 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753380Ab2IUWjj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Sep 2012 18:39:39 -0400
In-Reply-To: <20120921220741.GG2454@linux.vnet.ibm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, "Bruce, Becky" <bbruce@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Hunter, Jon" <jon-hunter@ti.com>, snijsure@grid-net.com

On Fri, 21 Sep 2012, Paul E. McKenney wrote:

> Good catch!  Even worse, it gives "timer=18446744073709551615" on
> 64-bit systems, which is no easier on the eyes.  I therefore changed
> the code to print a nicer message in this case, patch below.

Looks better, thanks.

- Paul
