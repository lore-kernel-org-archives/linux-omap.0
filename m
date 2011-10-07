From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v2 5/6] OMAP3+: Update DPLL Fint range for OMAP36xx and
 OMAP4xxx devices
Date: Fri, 7 Oct 2011 17:16:22 -0500
Message-ID: <4E8F7A36.3030408@ti.com>
References: <1316195322-15062-1-git-send-email-jon-hunter@ti.com> <alpine.DEB.2.00.1110061938210.4611@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33368 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758624Ab1JGWQ1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Oct 2011 18:16:27 -0400
In-Reply-To: <alpine.DEB.2.00.1110061938210.4611@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, mturquette@ti.com

Hi Paul,

On 10/6/2011 20:40, Paul Walmsley wrote:
> On Fri, 16 Sep 2011, Jon Hunter wrote:
>
>> From: Jon Hunter<jon-hunter@ti.com>
>>
>> The OMAP36xx and OMAP4xxx DPLLs have a different internal reference
>> clock frequency (fint) operating range than OMAP3430. Update the
>> dpll_test_fint() function to check for the correct frequency ranges
>> for OMAP36xx and OMAP4xxx.
>>
>> For OMAP36xx and OMAP4xxx devices, DPLLs fint range is 0.5MHz to
>> 2.5MHz for j-type DPLLs and otherwise it is 32KHz to 52MHz for all
>> other DPLLs.
>>
>> Signed-off-by: Jon Hunter<jon-hunter@ti.com>
>
> This looks okay to me for now - queued for 3.2.  Ideally we would move the
> Fint DPLL data to the struct dpll_data, but this would be a fairly
> significant undertaking, since we don't have a clean way to use different
> dpll_data for different OMAP3 variants.  Something good to keep in mind
> for the common clock conversion.

You know at first I was thinking about adding this to the dpll_data 
struct, but then I thought these ranges only change for a couple dplls 
and so adding a few more members to each dpll struct was bloating the 
struct and making this a massive change. So I went the other path and 
just added a couple defines to minimise the changes. However, we could 
definitely do that if it is preferred and if with next-gen devices (such 
as omap5) more dplls have different ranges then this would make more 
sense too.

Cheers
Jon

