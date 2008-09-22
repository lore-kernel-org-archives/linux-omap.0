From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH] ARM: OMAP: Add missing McBSP interrupts
Date: Mon, 22 Sep 2008 12:29:35 +0300
Message-ID: <20080922122935.8023fbe8.jarkko.nikula@nokia.com>
References: <6ed0b2680809190724g717e20f7k446c681ea48deca5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:41298 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbYIVJad (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Sep 2008 05:30:33 -0400
In-Reply-To: <6ed0b2680809190724g717e20f7k446c681ea48deca5@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext notaz <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org

On Fri, 19 Sep 2008 17:24:36 +0300
"ext notaz" <notasas@gmail.com> wrote:

> I was trying to get audio going through McBSP3, and was getting this:
> 
> omap-mcbsp omap-mcbsp.3: Unable to request RX IRQ 0 for McBSP3
> 
> This patch fixes the problem for me.
> 
Heh, I was faster. See:

http://marc.info/?l=linux-omap&m=122156990412457&w=2

My version takes also 2430 into account.


Jarkko
