From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP3: PM: fix I/O wakeup and I/O chain clock
 control detection
Date: Thu, 6 Oct 2011 13:46:02 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110061345260.4611@utopia.booyaka.com>
References: <alpine.DEB.2.00.1110061310390.4611@utopia.booyaka.com> <CAGDS+nno3=sDDwdF6Ew6qG-8mN9bCeawCpho+AJo=jE9QVk0ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50575 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756876Ab1JFTqD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Oct 2011 15:46:03 -0400
In-Reply-To: <CAGDS+nno3=sDDwdF6Ew6qG-8mN9bCeawCpho+AJo=jE9QVk0ag@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, dhylands@gmail.com

On Thu, 6 Oct 2011, Steve Sakoman wrote:

> Perhaps I'm confused but shouldn't it be an || instead of &&?
> 
> We're testing for ES3.1 *or* ES3.12?

You're correct - thanks for catching this.  v2 on its way.

- Paul
