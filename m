From: santosh shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: Dead Kconfig Option OMAP4_ERRATA_I688
Date: Wed, 25 Feb 2015 09:24:50 -0800
Message-ID: <54EE0562.40107@oracle.com>
References: <CABv5NL-bnfV0BoH+G=nX+1eo6xeT_LN8dOFtSnwvdpcvjJhUFQ@mail.gmail.com> <20150225171451.GQ11056@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:51211 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbbBYR0F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Feb 2015 12:26:05 -0500
In-Reply-To: <20150225171451.GQ11056@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Stefan Hengelein <stefan.hengelein@fau.de>
Cc: linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>

On 2/25/2015 9:14 AM, Tony Lindgren wrote:
> Hi,
>
> Adding Santosh to Cc on this one.
>
> * Stefan Hengelein <stefan.hengelein@fau.de> [150225 09:13]:
>> During the research for my masters thesis i came across the
>> OMAP4_ERRATA_I688 option and realized, it is never possible to enable
>> this option.
>>
>> The a62a6e98 commit added the "&& !ARCH_MULTIPLATFORM" dependency to
>> disable this option for multiplatforms. However, because of enclosing
>> dependencies, this option isn't available for non-MULTIPLATFORM
>> configurations either.
>
> Yes there is no clean way currently to enable this errata for
> multiplatform.
>
Right.To fix this, the barrier code needs to be run-time patched.

>> CONFIG_OMAP4_ERRATA_I688 is defined in the menu "TI OMAP/AM/DM/DRA
>> Family" which depends on ARCH_MULTI_V6 || ARCH_MULTI_V7. (in
>> arch/arm/mach-omap2/Kconfig)
>>
>> ARCH_MULTI_V6 and ARCH_MULTI_V7 however are defined in the menu
>> "Multiple platform selection" which depends on ARCH_MULTIPLATFORM (in
>> arch/arm/Kconfig)
>>
>> Which is a contradiction.
>>
>> There are no selects on OMAP4_ERRATA_I688, which would ignore
>> dependencies, either.
>>
>> The question is:
>> Was disabling this option for non-MULTIPLATFORM configurations also intentional?
>>
>> i have added a minimal example of the problem.
>
>  From what I remember the plan was to try to come up with a
> multiplatform friendly way of doing this errata. Santosh,
> any suggestions here? Should we just remove the code as it
> seems nobody has complained about it for a few years now?
>
I have to agree to with you on this.

Regards,
Santosh
