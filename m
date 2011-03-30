From: Kevin Hilman <khilman@ti.com>
Subject: Re: Smartreflex on 'pm-wip/voltdm' Branch
Date: Wed, 30 Mar 2011 07:52:54 -0700
Message-ID: <87pqp8slrt.fsf@ti.com>
References: <AANLkTi=czLooLOFEZq-TYKLOqwFxn8eB6aTs7-3k_YSY@mail.gmail.com>
	<e3b58bb0f126f8849c7358c8f7e67222@mail.gmail.com>
	<874o6nky7a.fsf@ti.com>
	<AANLkTinHsk0dSKVwTK4DMYn+wmLnxXFxQkbRUREa2REy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:35017 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755961Ab1C3OxA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Mar 2011 10:53:00 -0400
Received: by yxk8 with SMTP id 8so581985yxk.32
        for <linux-omap@vger.kernel.org>; Wed, 30 Mar 2011 07:52:58 -0700 (PDT)
In-Reply-To: <AANLkTinHsk0dSKVwTK4DMYn+wmLnxXFxQkbRUREa2REy@mail.gmail.com>
	(Shweta Gulati's message of "Wed, 30 Mar 2011 11:51:48 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gulati, Shweta" <shweta.gulati@ti.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-omap@vger.kernel.org

Hi Shweta,

"Gulati, Shweta" <shweta.gulati@ti.com> writes:

[...]

>>> I did a quick debug on this and found that the root cause of the is=
sue is
>>> in usage of ffs (because of this, i2c slave address was configured =
wrongly
>>> in vc).
>>> Basically ffs returns the position of the first (least significant)=
 bit
>>> set in the word and the least significant bit is position 1 where a=
s our
>>> bit operation assumes that least significant position is 0.
>>
>> Vishwa, Thanks for findingg this. =C2=A0Indeed, I had assumed ffs() =
was zero based,
>> but it is 1 based.
>>
>>> I tested the attached patch on OMAP3 and it seems to work fine.
> Attached, is Patch which fixes the Issue, It works Fine for OMAP3 and
> OMAP4 SDP boards.

Thanks for the patch, but my voltage cleanup series is work-in-progress=
,
and a moving target at the moment.  I've changed (again) the way I'm
splitting up the code so this patch won't apply directly.

I will however change to using __ffs instead of ffs.  Thanks for
pointing that out.  I wasn't aware of the difference between __ffs() an=
d
ffs()

Kevin


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
