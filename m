From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH 1/2] OMAP3: MCBSP: Suspend/resume failure fix
Date: Fri, 13 Nov 2009 18:10:33 +0000
Message-ID: <CCAAF334-EA45-4C37-9EAB-CD3494B7EC34@opensource.wolfsonmicro.com>
References: <1258133987-20488-1-git-send-email-jwang@ti.com> (sfid-20091113_173850_761073_9598FCAB) <171D41FE-0C40-4921-97FF-B8DE2D360C9A@opensource.wolfsonmicro.com> <13B9B4C6EF24D648824FF11BE8967162039B9BAA0F@dlee02.ent.ti.com> (sfid-20091113_175312_309321_139F5501)
Mime-Version: 1.0 (iPhone Mail 7D11)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:60592 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754828AbZKMSK3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Nov 2009 13:10:29 -0500
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162039B9BAA0F@dlee02.ent.ti.com> (sfid-20091113_175312_309321_139F5501)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Wang, Jane" <jwang@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "peter.ujfalusi@nokia.com" <peter.ujfalusi@nokia.com>

On 13 Nov 2009, at 17:52, "Wang, Jane" <jwang@ti.com> wrote:

>
>
>> -----Original Message-----
>> From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel- 
>> bounces@alsa-
>> project.org] On Behalf Of Mark Brown
>> Sent: Friday, November 13, 2009 11:49 AM
>> To: Wang, Jane
>> Cc: alsa-devel@alsa-project.org; linux-omap@vger.kernel.org;
>> peter.ujfalusi@nokia.com; Wang, Jane
>> Subject: Re: [alsa-devel] [PATCH 1/2] OMAP3: MCBSP: Suspend/resume  
>> failure
>> fix
>>
>> On 13 Nov 2009, at 17:39, Jane Wang <jwang@ti.com> wrote:
>>
>>> McBSP fucntional clock is not disabled when suspend is triggerd  
>>> which
>>> prevents PER domain entering target low-power state. To fix the
>>> problem:
>>>
>>> 1. Disable/enable McBSP functional clock for suspend/resume.
>>>
>>> 2. In addition, reconfigure McBSP, this is needed when systerm comes
>>> out of OFF state.
>>>
>>
>> There is no need to resend your patches this iften - please allow at
>> least a week or so for review. You only need to repost if addressing
>> comments or it looks like the patch got missed.
>>
>
> Sorry for sending this again. Something is not set correctly with my
> git send-email. The email did not reach the mailing lists, it only  
> reached
> people in cc.

No, your posts are making it through to the lists just fine. Note that  
alsa-devel is moderated for non-subscribers
