From: santosh shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH] ARM: OMAP4: remove dead kconfig option OMAP4_ERRATA_I688
Date: Tue, 17 Mar 2015 09:26:31 -0700
Message-ID: <550855B7.3020905@oracle.com>
References: <1424889867-8980-1-git-send-email-stefan.hengelein@fau.de> <20150316233005.GA2598@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150316233005.GA2598@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Stefan Hengelein <stefan.hengelein@fau.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, gregkh@linuxfoundation.org
List-Id: linux-omap@vger.kernel.org



On 3/16/2015 4:30 PM, Tony Lindgren wrote:
> * Stefan Hengelein <stefan.hengelein@fau.de> [150225 10:48]:
>> The Kconfig-Option OMAP4_ERRATA_I688 is never visible due to a
>> contradiction in it's dependencies.
>> The option requires ARCH_MULTIPLATFORM to be 'disabled'. However, an
>> enclosing menu requires either ARCH_MULTI_V6 or ARCH_MULTI_V7 to be
>> enabled. These options inherit a dependency from an enclosing menu,
>> that requires ARCH_MULTIPLATFORM to be 'enabled'.
>> This is a contradiction and made this option also unavailable for
>> non-multiplatform configurations.
>>
>> Since there are no selects on OMAP4_ERRATA_I688, which would ignore
>> dependencies, the code related to that option is dead and can be
>> removed.
>>
>> This (logical) defect has been found with the undertaker tool.
>> (https://undertaker.cs.fau.de)
>>
>> Signed-off-by: Stefan Hengelein <stefan.hengelein@fau.de>
>>
>> ---
>> Tony Lindgren suggested to remove the code since nobody complained for
>> a few years and Santosh Shilimkar agreed.
>> https://lkml.org/lkml/2015/2/25/449
>> ---
>> As far as I see, this should remove all the code related to
>> OMAP4_ERRATA_I688, I hope I didn't remove too much.
>
> Seems to boot fine, so applying into omap-for-v4.1/fixes-not-urgent.
>
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
