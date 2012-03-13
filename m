From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 0/2] Fixes in hwmod reset code
Date: Tue, 13 Mar 2012 22:54:24 +0530
Message-ID: <4F5F82C8.7000002@ti.com>
References: <1331647435-31666-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1203130819480.22211@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:36660 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758683Ab2CMRYd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Mar 2012 13:24:33 -0400
Received: by gghe5 with SMTP id e5so974821ggh.5
        for <linux-omap@vger.kernel.org>; Tue, 13 Mar 2012 10:24:32 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1203130819480.22211@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: b-cousson@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Paul,

On Tuesday 13 March 2012 07:52 PM, Paul Walmsley wrote:
> Hi Rajendra
>
> On Tue, 13 Mar 2012, Rajendra Nayak wrote:
>
>> This fixes a couple of issues around hwmod reset
>> APIs'.
>> Patches are based on 3.3.-rc7.
>>
>> Rajendra Nayak (2):
>>    ARM: omap: hwmod: Restore sysc after a reset
>>    ARM: omap: hwmod: Make omap_hwmod_softreset wait for reset status
>>
>>   arch/arm/mach-omap2/omap_hwmod.c |   18 ++++++------------
>>   1 files changed, 6 insertions(+), 12 deletions(-)
>
> Could you base this on either my 'hwmod_code_cleanup_3.4' branch or
> 'hwmod_enable_remaining_hwmods_devel_3.4' branch?  There are some reset
> changes in there also.

Sure, will send them out shortly.

regards,
Rajendra
>
>
> - Paul

