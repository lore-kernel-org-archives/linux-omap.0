From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] Runtime detection of Si features
Date: Thu, 13 Aug 2009 11:31:26 -0500
Message-ID: <4A843FDE.5090209@ti.com>
References: <1250176701-23998-1-git-send-email-premi@ti.com> <877hx7g09i.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46438 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754926AbZHMQbc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 12:31:32 -0400
In-Reply-To: <877hx7g09i.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin Hilman had written, on 08/13/2009 11:13 AM, the following:
> Sanjeev Premi <premi@ti.com> writes:
> 
>> The OMAP35x family has multiple variants differing
>> in the HW features. This patch detects these features
>> at runtime and prints information during the boot.
>>
>> Since most of the code seemed repetitive, macros
>> have been used for readability.
>>
>> Signed-off-by: Sanjeev Premi <premi@ti.com>
> 
> I like the feature-based approach.
> 
> A couple questions though.  Is there a bit/register that reports the
> collapsed powerdomains of the devices with modified PRCM?
> 
> Also, how will other code query the features?  You're currently
> exporting the omap_has_*() functions, but there are no prototypes.
> 
> I think I'd rather see a static inline functions in <mach/cpu.h>
> for checking features.  Comments to that end inlined below...
Wonder if we can setup some sort of infrastructure for:
a) features
b) erratas
linked to OMAP revs + even better w.r.t silicon module(SGX,I2c) 
revisions since at times they are used across multiple OMAPs?

-- 
Regards,
Nishanth Menon
