From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: Re: [PATCH 2/6] ARM: OMAP AM33xx: voltagedomain: Add voltage domain
 data
Date: Mon, 11 Jun 2012 22:46:26 +0530
Message-ID: <4FD627EA.7080606@ti.com>
References: <20120521184053.22565.90037.stgit@dusk> <20120521184156.22565.87926.stgit@dusk> <alpine.DEB.2.00.1206101916480.20674@utopia.booyaka.com> <4FD5B83E.6020807@ti.com> <alpine.DEB.2.00.1206111008410.5849@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41934 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449Ab2FKRQj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 13:16:39 -0400
In-Reply-To: <alpine.DEB.2.00.1206111008410.5849@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Afzal Mohammed <afzal@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>



On 6/11/2012 9:40 PM, Paul Walmsley wrote:
> Hi Vaibhav,
> 
> On Mon, 11 Jun 2012, Vaibhav Hiremath wrote:
> 
>> I think this is not required, since Tony has already accepted the patch
>> which has this implementation (available on linux-omap/master).
>> Please refer to the commit,
>>
>> commit 08f3098928c991560408e8c71d4af8b1a3ff2d67
>> Author: Afzal Mohammed <afzal@ti.com>
>> Date:   Fri May 11 00:38:49 2012 +0530
>>
>>     ARM: OMAP2+: am33xx: Add AM335XEVM machine support
> 
> Thanks, that's what I need.  Looks like our series needs to be based on 
> this commit, rather than mainline.
> 

Yes, its already done. As you know I maintain this branch which always
follows mainline and also integrates all the changes discussed on the list -

https://github.com/hvaibhav/am335x-linux/tree/am335x-upstream-staging

Thanks,
Vaibhav
