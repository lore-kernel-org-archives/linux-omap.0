From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 19:13:40 +0200
Message-ID: <1274980420.27810.5557.camel@twins>
References: <Pine.LNX.4.44L0.1005271303190.3239-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:40436 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754600Ab0E0ROA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 May 2010 13:14:00 -0400
In-Reply-To: <Pine.LNX.4.44L0.1005271303190.3239-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, Thomas Gleixner <tglx@linutronix.de>, Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Thu, 2010-05-27 at 13:04 -0400, Alan Stern wrote:
> 
> Does this mean you believe "echo mem >/sys/power/state" is bad and
> should be removed?  Or "echo disk >/sys/power/state"?  They pay no
> attention to latencies or other requirements. 

Those are a whole different beast, those are basically a quick-off
button like thing. Forced suspend is conceptually a very different beast
from power-saving a running system.


