From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH 4/6] ARM: OMAP4: PMU: Add runtime PM support
Date: Wed, 16 May 2012 16:17:01 +0800
Message-ID: <CACVXFVNmg-5HHFmdT9a0cfUvGb-OYMe1QOdn3JOMo9rc=aMqTQ@mail.gmail.com>
References: <1336599355-10983-1-git-send-email-jon-hunter@ti.com>
	<CACVXFVOmLOm8qD5Mq8qJQGSCcD7kNhW9OOsQqzx6W77709CXEQ@mail.gmail.com>
	<4FB26AA6.1060807@ti.com>
	<CACVXFVNqWM7G8dK2AA90JPvE6e_L0_Zwk-BJTjThY+nZ6ONnQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:57654 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759803Ab2EPIRG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 May 2012 04:17:06 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1SUZPr-0005OK-QP
	for linux-omap@vger.kernel.org; Wed, 16 May 2012 08:17:03 +0000
Received: by dady13 with SMTP id y13so656874dad.19
        for <linux-omap@vger.kernel.org>; Wed, 16 May 2012 01:17:01 -0700 (PDT)
In-Reply-To: <CACVXFVNqWM7G8dK2AA90JPvE6e_L0_Zwk-BJTjThY+nZ6ONnQA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Ming Lei <ming.lei@canonical.com>, linux-omap <linux-omap@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>

Jon,

On Wed, May 16, 2012 at 6:05 AM, Ming Lei <ming.lei@canonical.com> wrote:
>
>
> On Tuesday, May 15, 2012, Jon Hunter <jon-hunter@ti.com> wrote:
>> Hi Ming,
>>
>> On 05/14/2012 11:53 PM, Ming Lei wrote:
>>> On Thu, May 10, 2012 at 5:35 AM, Jon Hunter <jon-hunter@ti.com> wrote:
>>>> From: Jon Hunter <jon-hunter@ti.com>
>>>>
>>>> This patch is based upon Ming Lei's patch to add runtime PM support for
>>>> OMAP4
>>>> [1]. In Ming's original patch the CTI interrupts were being enabled
>>>> during
>>>> runtime when the PMU was used but they were only configured once during
>>>> init.
>>>> Therefore move the configuration of the CTI interrupts to the runtime PM
>>>> functions.
>>>
>>> As Shilimkar pointed out, you need to give the reason why the change
>>> is introduced
>>> in the patch.
>>
>> Yes will do. I have been waiting to get some feedback on HW_AUTO versus
>> SW_SLEEP from design before posting a V2. I will enhance the changelog.
>
> Looks pandaboard will hang during kernel boot
> with the latest next tree, so perf can't be tested now.
> Once the problem is fixed, l will run perf test and provide my feedback.

After bisecting, looks it is the 1st commit which triggers kernel
boot hang:

commit 5f3aa31f77733605f04a5a92ddc475ffd439585f
Merge: 0f131ea ce4deaa
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Mon May 14 18:55:39 2012 +1000

    Merge remote-tracking branch 'arm-soc/for-next'


These 6 patches can't be applied against previous commit, so
I can't verify these patches now.


Thanks,
--
Ming Lei
