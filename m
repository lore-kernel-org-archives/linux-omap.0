From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH 10/12] ARM: OMAP3: mmc-twl4030 allow arbitrary slot	names
Date: Mon, 16 Mar 2009 12:04:29 +0200
Message-ID: <49BE242D.7080307@nokia.com>
References: <20090310205824.16425.97745.stgit@localhost> <20090310211352.16425.44160.stgit@localhost> <20090315160838.GF10786@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:40477 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbZCPKEY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Mar 2009 06:04:24 -0400
In-Reply-To: <20090315160838.GF10786@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, David Brownell <dbrownell@users.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Russell King - ARM Linux wrote:
> On Tue, Mar 10, 2009 at 02:13:52PM -0700, Tony Lindgren wrote:
>> From: Adrian Hunter <adrian.hunter@nokia.com>
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
>> Acked-by: David Brownell <dbrownell@users.sourceforge.net>
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>> ---
>>  arch/arm/mach-omap2/mmc-twl4030.c |    5 ++++-
>>  arch/arm/mach-omap2/mmc-twl4030.h |    1 +
>>  2 files changed, 5 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
>> index 9f53d22..9831b2b 100644
>> --- a/arch/arm/mach-omap2/mmc-twl4030.c
>> +++ b/arch/arm/mach-omap2/mmc-twl4030.c
>> @@ -402,7 +402,10 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
>>  			return;
>>  		}
>>  
>> -		sprintf(twl->name, "mmc%islot%i", c->mmc, 1);
>> +		if (c->name)
>> +			strncpy(twl->name, c->name, HSMMC_NAME_LEN);
> 
> Bug.  strncpy can result in a non-null terminated string, and it just so
> happens that twl->name has been declared as being HSMMC_NAME_LEN+1 in size.
> 

Well to be pedantic, it is not actually a "bug".  twl->name is zero-filled so HSMMC_NAME_LEN+1
guarantees that it is null terminated.

> That's rather unsafe.  Using strlcpy() and sizeof(twl->name) instead will
> ensure that no matter what happens to the size of the array declaration,
> the code remains correct.

Unless the programmer decides to make twl->name a pointer to allocated memory
- then sizeof(twl->name) is no good.  You could use ARRAY_SIZE(twl->name) which
(for gcc) includes a check that twl->name is an array.

> 
>> diff --git a/arch/arm/mach-omap2/mmc-twl4030.h b/arch/arm/mach-omap2/mmc-twl4030.h
>> index 0aa1686..ea59e86 100644
>> --- a/arch/arm/mach-omap2/mmc-twl4030.h
>> +++ b/arch/arm/mach-omap2/mmc-twl4030.h
>> @@ -14,6 +14,7 @@ struct twl4030_hsmmc_info {
>>  	bool	cover_only;	/* No card detect - just cover switch */
>>  	int	gpio_cd;	/* or -EINVAL */
>>  	int	gpio_wp;	/* or -EINVAL */
>> +	char	*name;		/* or NULL for default */
> 
> const?
> 

OK

