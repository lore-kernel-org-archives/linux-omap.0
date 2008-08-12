From: Tony Lindgren <tony@atomide.com>
Subject: Re: Git tree updated to v2.6.27-rc2, help needed
Date: Tue, 12 Aug 2008 14:51:30 +0300
Message-ID: <20080812115130.GH6705@atomide.com>
References: <20080811152620.GO25784@atomide.com> <alpine.DEB.1.00.0808111355250.10219@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59923 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbYHLLtT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Aug 2008 07:49:19 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0808111355250.10219@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Sakari Ailus <sakari.ailus@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Eduardo Valentin <edubezval@gmail.com>

* Paul Walmsley <paul@pwsan.com> [080811 22:58]:
> On Mon, 11 Aug 2008, Tony Lindgren wrote:
> 
> > - Booting fails early on 3430sdp for some reason
> 
> This affects all ARMv7 and is due to a bug in the TLB clearing code; patch 
> coming shortly.
> 
> > - Alignment error on omap2/3. This seems to happen also with
> >   718fc6cd4db902aa2242a736cc3feb8744a4c71a reverted?
> 
> Haven't seen this here with CSL gcc 2007q3-51 on OMAP3.

Seems to happen on 24xx only.

Tony
