From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH 4/6] ARM: OMAP4: PMU: Add runtime PM support
Date: Thu, 17 May 2012 13:28:13 +0800
Message-ID: <CACVXFVPGA7LdRT8=hSZkr5GLhz-8f1sNSDf6E5ima0TuSFgPCg@mail.gmail.com>
References: <1336599355-10983-1-git-send-email-jon-hunter@ti.com>
	<CACVXFVOmLOm8qD5Mq8qJQGSCcD7kNhW9OOsQqzx6W77709CXEQ@mail.gmail.com>
	<4FB26AA6.1060807@ti.com>
	<CACVXFVNqWM7G8dK2AA90JPvE6e_L0_Zwk-BJTjThY+nZ6ONnQA@mail.gmail.com>
	<CACVXFVNmg-5HHFmdT9a0cfUvGb-OYMe1QOdn3JOMo9rc=aMqTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:34230 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872Ab2EQF2Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 May 2012 01:28:16 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1SUtG3-0002Gh-9t
	for linux-omap@vger.kernel.org; Thu, 17 May 2012 05:28:15 +0000
Received: by dady13 with SMTP id y13so1947216dad.19
        for <linux-omap@vger.kernel.org>; Wed, 16 May 2012 22:28:13 -0700 (PDT)
In-Reply-To: <CACVXFVNmg-5HHFmdT9a0cfUvGb-OYMe1QOdn3JOMo9rc=aMqTQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Ming Lei <ming.lei@canonical.com>, linux-omap <linux-omap@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>

On Wed, May 16, 2012 at 4:17 PM, Ming Lei <ming.lei@canonical.com> wrot=
e:
> Jon,
>
> On Wed, May 16, 2012 at 6:05 AM, Ming Lei <ming.lei@canonical.com> wr=
ote:
>>
>>
>> On Tuesday, May 15, 2012, Jon Hunter <jon-hunter@ti.com> wrote:
>>> Hi Ming,
>>>
>>> On 05/14/2012 11:53 PM, Ming Lei wrote:
>>>> On Thu, May 10, 2012 at 5:35 AM, Jon Hunter <jon-hunter@ti.com> wr=
ote:
>>>>> From: Jon Hunter <jon-hunter@ti.com>
>>>>>
>>>>> This patch is based upon Ming Lei's patch to add runtime PM suppo=
rt for
>>>>> OMAP4
>>>>> [1]. In Ming's original patch the CTI interrupts were being enabl=
ed
>>>>> during
>>>>> runtime when the PMU was used but they were only configured once =
during
>>>>> init.
>>>>> Therefore move the configuration of the CTI interrupts to the run=
time PM
>>>>> functions.
>>>>
>>>> As Shilimkar pointed out, you need to give the reason why the chan=
ge
>>>> is introduced
>>>> in the patch.
>>>
>>> Yes will do. I have been waiting to get some feedback on HW_AUTO ve=
rsus
>>> SW_SLEEP from design before posting a V2. I will enhance the change=
log.
>>
>> Looks pandaboard will hang during kernel boot
>> with the latest next tree, so perf can't be tested now.
>> Once the problem is fixed, l will run perf test and provide my feedb=
ack.
>
> After bisecting, looks it is the 1st commit which triggers kernel
> boot hang:
>
> commit 5f3aa31f77733605f04a5a92ddc475ffd439585f
> Merge: 0f131ea ce4deaa
> Author: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: =A0 Mon May 14 18:55:39 2012 +1000
>
> =A0 =A0Merge remote-tracking branch 'arm-soc/for-next'

The above kernel hang is caused by mmc driver probe failure,
which can be fixed by the patch in below link:

      http://www.mail-archive.com/linux-omap@vger.kernel.org/msg68848.h=
tml

After applying the patch, I can test the 6 patches and looks they work =
well
about perf support on omap4, also perf can work well after S2R.

Tested-by: Ming Lei <ming.lei@canonical.com>


Thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
