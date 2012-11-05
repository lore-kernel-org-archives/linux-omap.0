From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH V2 0/3] ARM: dts: omap5: EMIF and LPDDR2 device tree data
Date: Mon, 5 Nov 2012 12:03:44 +0100
Message-ID: <50979D10.1070406@ti.com>
References: <1349959669-16366-1-git-send-email-lokeshvutla@ti.com> <50975581.7010508@ti.com> <50979A14.1050805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58099 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab2KELD6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 06:03:58 -0500
In-Reply-To: <50979A14.1050805@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On 11/05/2012 11:51 AM, Benoit Cousson wrote:
> Hi Lokesh,
> 
> On 11/05/2012 06:58 AM, Lokesh Vutla wrote:
>> Hi,
>> On Thursday 11 October 2012 06:17 PM, Lokesh Vutla wrote:
>>> This patch series adds Device tree data for the EMIF
>>> sdram controllers in OMAP5 and LPDDR2 memory devices
>>> in OMAP5-evm board.
>>>
>>> Testing:
>>> - Boot tested on OMAP5430 evm.
>>> - Built EMIF as a module.
>>>
>>> Changes from v1:
>>> * Created a seperate dtsi file for Samsung LPDDR2 memory device
>>>    used in OMAP5-evm.
>>> * Passing reg and interrupt fields from dt for EMIF1 and EMIF2.
>> Gentle ping on this series.
> 
> Sorry, I missed it. It might be too late for 3.8, since Tony wanted us
> to push before -rc4. I'll pull the series anyway just in case.
> 
> I have a least one comment.

Could you just rebase on top of the for_3.8 branch, fix the minor
comments and repost ASAP.

Thanks,
Benoit

