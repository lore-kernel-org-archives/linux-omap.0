From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCHv2 11/12] ARM: OMAP4: clock data: add clockdomains for
 clocks used as main clocks
Date: Mon, 11 Jun 2012 22:15:04 +0200
Message-ID: <4FD651C8.8030108@ti.com>
References: <20120611004502.20034.8840.stgit@dusk> <20120611004623.20034.52760.stgit@dusk> <4FD61C94.4030004@ti.com> <alpine.DEB.2.00.1206111050430.5849@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42142 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751126Ab2FKUPK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 16:15:10 -0400
In-Reply-To: <alpine.DEB.2.00.1206111050430.5849@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

On 6/11/2012 6:59 PM, Paul Walmsley wrote:
> On Mon, 11 Jun 2012, Cousson, Benoit wrote:
>
>> In fact, neither prm_clkdm not cm_clkdm are valid clock domain on OMAP4
>> :-(.
>>
>> I've just realized that you introduced that for 3.5, but this is wrong.
>> We should not start adding some fake clock domains just because the fmwk
>> is not smart enough to allow a NULL clock domain.
>>
>
> ...
>
>> In a period of data size reduction, adding some fake information does
>> not seems to be the right approach. Don't you think so?
>
> No, I do not.
>
> These clockdomains are clearly documented in both the OMAP4 TRM[1]
> and the NDA OMAP4 PRCM functional specifications.

Sorry for the confusion; I was just referring to the prm_clkdm and cm_clkdm.

> I continue to be baffled as to why you assert that they are fake, given
> how clearly they are documented.

In that case the clock domains are valid, but that does not change the 
fact that they are useless, at least for the moment.
The PRCM is already taking care of managing properly the domains based 
on module activity. Adding that to the clocks nodes is not wrong, but 
does add an information that is a duplication of what the HW is already 
doing.
That's why we should populate that information only if this is needed, 
like it was the case for the DPLL, but it should remain optional.

Regards,
Benoit
