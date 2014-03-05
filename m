From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCHv3 00/13] OMAP IOMMU DT adaptation for 3.15
Date: Wed, 5 Mar 2014 14:07:01 -0600
Message-ID: <531783E5.4090302@ti.com>
References: <1393620164-14633-1-git-send-email-s-anna@ti.com> <20140228230000.GW13624@atomide.com> <20140304160432.GG2799@8bytes.org> <5316068F.3020003@ti.com> <20140305193326.GA7599@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38720 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752791AbaCEUHh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Mar 2014 15:07:37 -0500
In-Reply-To: <20140305193326.GA7599@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Joerg Roedel <joro@8bytes.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tony,

On 03/05/2014 01:33 PM, Tony Lindgren wrote:
> * Suman Anna <s-anna@ti.com> [140304 09:03]:
>> On 03/04/2014 10:04 AM, Joerg Roedel wrote:
>>>
>>> Applied patches 1-7 to my arm/omap branch.
>>>
>>> Tony, you can pull that branch into your tree if needed (when I pushed
>>> it, which will happen today or tomorrow).
>
> OK thanks, looks like remaining patches compile just fine even without
> it which is nice.

Yes, I did test the boot specifically for this both with and without the 
corresponding DTS nodes.

>
>> Tony,
>> Can you also pull in the corresponding DTS node patches as well that
>> go along with this series.
>> http://marc.info/?l=linux-omap&m=139362062805816&w=2
>
> They look OK to me, but looks like Benoit and Paul are not Cc:ed
> on the hwmod changes. I suggest you resend just patches 8 - 13 and
> the .dts changes as a new series with Benoit and Paul on Cc for
> them so they have a chance to review and ack them.

OK, will do.

Thanks
Suman


