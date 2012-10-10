From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3.6.0- 0/6] ARM: use module_platform_driver macro
Date: Wed, 10 Oct 2012 18:46:44 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210101837440.5736@utopia.booyaka.com>
References: <1349893796-6947-1-git-send-email-srinivas.kandagatla@st.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:60626 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658Ab2JJSqp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Oct 2012 14:46:45 -0400
In-Reply-To: <1349893796-6947-1-git-send-email-srinivas.kandagatla@st.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Cc: rnayak@ti.com, Hiroshi.DOYU@nokia.com, tony@atomide.com, linux-omap@vger.kernel.org, tarun.kanti@ti.com, thara@ti.com, grinberg@compulab.co.il, eric.y.miao@gmail.com, linux-arm-kernel@lists.infradead.org, juha.yrjola@nokia.com

Hi

On Wed, 10 Oct 2012, Srinivas KANDAGATLA wrote:

> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> 
> Running below Coccinelle lookup pattern like below on the 
> latest kernel showed about 52 hits. This patch series is a subset 
> of those 52 patches, so that it will be easy for maintainers to review.

so the idea looks okay to me, but several of the patches aren't addressed 
to the right people.  You can use the MAINTAINERS file to figure out the 
right place to send them.

The PXA patches need to go to the appropriate PXA people, who are 
probably:

M:      Eric Miao <eric.y.miao@gmail.com>
M:      Russell King <linux@arm.linux.org.uk>
M:      Haojian Zhuang <haojian.zhuang@gmail.com>
L:      linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)

The OMAP RNG patch needs to go to 

M:      Deepak Saxena <dsaxena@plexity.net>
M:      Matt Mackall <mpm@selenic.com>
M:      Herbert Xu <herbert@gondor.apana.org.au>

As far as the remaining three OMAP patches go, they look okay to me but 
Tony Lindgren is the maintainer of these files and so he's the right 
person to merge them.

> Hopefully these patches will get rid of some code duplication in kernel.

One other comment - the description on the patches isn't quite accurate.  
The patches don't remove code duplication per se, they just replace some 
boilerplate code with a macro.


- Paul
