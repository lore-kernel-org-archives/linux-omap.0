From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: Re: [PATCH 2/6] ARM: OMAP AM33xx: voltagedomain: Add voltage domain
 data
Date: Mon, 11 Jun 2012 14:49:58 +0530
Message-ID: <4FD5B83E.6020807@ti.com>
References: <20120521184053.22565.90037.stgit@dusk> <20120521184156.22565.87926.stgit@dusk> <alpine.DEB.2.00.1206101916480.20674@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56993 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751488Ab2FKJUI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 05:20:08 -0400
In-Reply-To: <alpine.DEB.2.00.1206101916480.20674@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Afzal Mohammed <afzal@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>



On 6/11/2012 6:50 AM, Paul Walmsley wrote:
> Hi Vaibhav, Afzal, Tony,
> 
> On Mon, 21 May 2012, Paul Walmsley wrote:
> 
>> From: Vaibhav Hiremath <hvaibhav@ti.com>
>>
>> Currently dummy voltage domain data is being created
>> in order to succeed boot process, nothing has been done
>> w.r.t actual hardware (voltage control).
>>
>> Also, hook up the AM33XX voltage domain to OMAP framework.
> 
> I had to update this patch again for v3.5 to account for the lack of 
> am33xx_init_early().  So now this patch has to add it (updated patch 
> below). 
> 

Paul,

I think this is not required, since Tony has already accepted the patch
which has this implementation (available on linux-omap/master).
Please refer to the commit,

commit 08f3098928c991560408e8c71d4af8b1a3ff2d67
Author: Afzal Mohammed <afzal@ti.com>
Date:   Fri May 11 00:38:49 2012 +0530

    ARM: OMAP2+: am33xx: Add AM335XEVM machine support

Thanks,
Vaibhav

