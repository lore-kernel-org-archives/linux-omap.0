From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH v2 1/8] ARM/dts: OMAP2: Add McBSP entries for OMAP2420
 and OMAP2430 SoC
Date: Wed, 5 Sep 2012 15:31:55 +0200
Message-ID: <5047544B.60105@ti.com>
References: <1346247067-9632-1-git-send-email-peter.ujfalusi@ti.com> <1346247067-9632-2-git-send-email-peter.ujfalusi@ti.com> <5044C2DD.5000705@ti.com> <504578B3.3090804@ti.com> <5045D557.30404@ti.com> <79CD15C6BA57404B839C016229A409A83EAA7C99@DBDE01.ent.ti.com> <50470C1E.7090300@ti.com> <79CD15C6BA57404B839C016229A409A83EAA8014@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40519 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336Ab2IENcJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 09:32:09 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EAA8014@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Vaibhav,

On 09/05/2012 11:15 AM, Hiremath, Vaibhav wrote:
> On Wed, Sep 05, 2012 at 13:53:58, Ujfalusi, Peter wrote:
>> Hi,
>>
>> On 09/05/2012 09:11 AM, Hiremath, Vaibhav wrote:
>>>> Not yet, but we discussed that with Peter and since he does have these
>>>> patches for DT, he'll be able to test your series with the McBSP changes.
>>>>
>>>
>>> Great.
>>
>> With his series and your patch for omap-hwmod audio was probing and working on
>> OMAP3/4/5 without issues.
>>
> Peter,
> Care to provide your Tested-By??
> 
> Benoit,
> Can we merge this patch now?

Yes, I'll include it in the pull request along with DTS patches.

I've just tested it as well on OMAP4 by hacking the DTS for GPIO.
I'll try to update at least all the OMAP4 IPs as well with the proper
DTS resources for 3.7.

Regards,
Benoit

