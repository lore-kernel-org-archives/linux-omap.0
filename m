From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/6] ARM: OMAP AM33xx: voltagedomain: Add voltage domain
 data
Date: Mon, 11 Jun 2012 10:10:14 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206111008410.5849@utopia.booyaka.com>
References: <20120521184053.22565.90037.stgit@dusk> <20120521184156.22565.87926.stgit@dusk> <alpine.DEB.2.00.1206101916480.20674@utopia.booyaka.com> <4FD5B83E.6020807@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60983 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755104Ab2FKQKR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 12:10:17 -0400
In-Reply-To: <4FD5B83E.6020807@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Afzal Mohammed <afzal@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>

Hi Vaibhav,

On Mon, 11 Jun 2012, Vaibhav Hiremath wrote:

> I think this is not required, since Tony has already accepted the patch
> which has this implementation (available on linux-omap/master).
> Please refer to the commit,
> 
> commit 08f3098928c991560408e8c71d4af8b1a3ff2d67
> Author: Afzal Mohammed <afzal@ti.com>
> Date:   Fri May 11 00:38:49 2012 +0530
> 
>     ARM: OMAP2+: am33xx: Add AM335XEVM machine support

Thanks, that's what I need.  Looks like our series needs to be based on 
this commit, rather than mainline.


- Paul
