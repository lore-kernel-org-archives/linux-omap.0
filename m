From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP4: PCM049: remove vusim regulator
Date: Thu, 14 Jul 2011 00:34:45 -0700
Message-ID: <20110714073445.GL5783@atomide.com>
References: <1310554738.18446.12.camel@lws-weitzel>
 <1310554762-10743-1-git-send-email-j.weitzel@phytec.de>
 <4E1D8BCD.5060901@ru.mvista.com>
 <1310561772.18446.14.camel@lws-weitzel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:16634 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753757Ab1GNHet (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jul 2011 03:34:49 -0400
Content-Disposition: inline
In-Reply-To: <1310561772.18446.14.camel@lws-weitzel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jan Weitzel <J.Weitzel@phytec.de>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Jan Weitzel <J.Weitzel@phytec.de> [110713 05:51]:
> Am Mittwoch, den 13.07.2011, 16:13 +0400 schrieb Sergei Shtylyov:
> 
> > 
> >     Have you added that 'i' at the end intentionally?
> > 
> Thank you. It was a tribute to vim.

:i)

I'll fold the fixed patch into your original patch. Will also
keep the new board files in testing-board because of the code
coalescing and device tree conversion effort.

Tony
