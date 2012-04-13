From: Archit Taneja <a0393947@ti.com>
Subject: Re: query about _setup() in omap_hwmod.c
Date: Fri, 13 Apr 2012 14:22:48 +0530
Message-ID: <4F87E960.408@ti.com>
References: <4F8550C6.9050402@ti.com> <alpine.DEB.2.00.1204130205200.25832@utopia.booyaka.com> <4F87E1F8.6000403@ti.com> <alpine.DEB.2.00.1204130234220.25832@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44085 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932790Ab2DMIxS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Apr 2012 04:53:18 -0400
In-Reply-To: <alpine.DEB.2.00.1204130234220.25832@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Rajendra Nayak <rnayak@ti.com>

Hi,

On Friday 13 April 2012 02:09 PM, Paul Walmsley wrote:
> Hi Archit,
>
> On Fri, 13 Apr 2012, Archit Taneja wrote:
>
>> There were still some issues related to this, particularly on OMAP4, I have
>> posted a patch set to fix this just a while back.
>
> Was looking at those.  The first one, removing the OCPIF_SWSUP_IDLE flags,
> makes sense to me.  But as far as the second one goes, it would be nice if
> we could use interface clocks again for interfaces, rather than functional
> clocks.  That's the root cause of the problem... Looks like this was added
> in commit da7cdfac1b0c58d6863532dd3b432c3fbc034978.  Maybe this is needed
> because we don't properly enable parent hwmods before the dependent child
> hwmods?
>

Yes, you are right. As you and Benoit in the other thread explained, if 
we get the parent-child dependency right, we could switch back to using 
l3_div interface clock.

Thanks,
Archit

>
> - Paul
>

