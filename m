From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V3 1/2] ARM: dts: OMAP2+: Add SDMA controller bindings
 and nodes
Date: Wed, 13 Mar 2013 10:50:55 -0500
Message-ID: <5140A05F.60108@ti.com>
References: <1361903244-19837-1-git-send-email-jon-hunter@ti.com> <1361903244-19837-2-git-send-email-jon-hunter@ti.com> <513F0AE3.6030408@ti.com> <513FA19C.60904@ti.com> <51409CD3.10301@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54772 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932656Ab3CMPvY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Mar 2013 11:51:24 -0400
In-Reply-To: <51409CD3.10301@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Vinod Koul <vinod.koul@intel.com>, Russell King <linux@arm.linux.org.uk>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Sebastien Guiriec <s-guiriec@ti.com>


On 03/13/2013 10:35 AM, Benoit Cousson wrote:
> Salut Jon,
> 
> On 03/12/2013 10:43 PM, Jon Hunter wrote:
>> Salut Benoit!
>>
>> On 03/12/2013 06:00 AM, Benoit Cousson wrote:
>>> + Seb G.
>>>
>>> Hi Jon,
>>>
>>> How to you plan to merge that series?
>>
>> Good question ... my thinking was that you or Tony would take 1/2 and
>> once that is queued then I would ask Tony to ack 2/2 and Vinod take that
>> patch.
> 
> Yep, this is what I was thinking too.
> 
>> By the way, I have accumulated several DT patches which I sent out
>> altogether [1] (at least for my own sanity if no one elses ;-) and I
>> have included the below patch with it. I was hoping that may be I could
>> create a branch for you to pull. If you would rather cherry-pick the
>> various patches and merge yourself then I can separate them too.
> 
> Merging your branch is indeed even better for me. So go ahead.

Ok. Care to take a quick review to see if there is anything else you
feel needs fixing before I re-submit fixing the commments posted so far?

Do you have an updated branch for v3.10 that I should base on?

Cheers
Jon
