From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 14/15] ARM: OMAP2+: omap2plus_defconfig: Enable Mailbox
Date: Sat, 03 Nov 2012 13:43:25 +0000
Message-ID: <50951F7D.1000609@deeprootsystems.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com> <1351859566-24818-15-git-send-email-vaibhav.bedia@ti.com> <50950C09.6000108@deeprootsystems.com> <B5906170F1614E41A8A28DE3B8D121433EBFEA96@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:46762 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755953Ab2KCNnZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Nov 2012 09:43:25 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so1992419wey.19
        for <linux-omap@vger.kernel.org>; Sat, 03 Nov 2012 06:43:24 -0700 (PDT)
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EBFEA96@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>

On 11/03/2012 01:17 PM, Bedia, Vaibhav wrote:
> On Sat, Nov 03, 2012 at 17:50:25, Kevin Hilman wrote:
>> On 11/02/2012 01:32 PM, Vaibhav Bedia wrote:
>>> AM33XX PM code depends on Mailbox module for IPC
>>> between MPU and WKUP_M3.
>>
>> OK, but what if I try to build for AM33xx without starting from
>> omap2plus_defconfig?
>
> I honestly didn't think about this scenario.
>
>>
>> IOW, instead of changing the default defconfig, AM33xx should select
>> this when PM
>> is enabled.   Something like the (untested) change below.
>>
>
> Will try it out. Thanks for the suggestion.

You're welcome.

See... sometimes maintainers can be useful for something other than 
complaining.  ;)

Kevin
