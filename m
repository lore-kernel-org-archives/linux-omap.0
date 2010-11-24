From: TAO HU <tghk48@motorola.com>
Subject: Re: OMAP4 ES2.0 Unhandled fault: imprecise external abort
Date: Wed, 24 Nov 2010 14:09:58 +0800
Message-ID: <AANLkTimYCzNO0skDLForDWM5v_A6aPmfQ2qoZMBJUC4s@mail.gmail.com>
References: <AANLkTinXqSA0botGAGzEtk8_xOVt0W05k9+0w4v1gqF0@mail.gmail.com>
	<AANLkTin7YJ9GKdpFH1C_fwFXJp6yyO09s5ZJRos1Er1T@mail.gmail.com>
	<AANLkTi=iMXB6LvkNkj5JU17PPC3Kt+hnbDd1s=Dj8voq@mail.gmail.com>
	<aed955b665a0511402480c258615c2d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from exprod5og105.obsmtp.com ([64.18.0.180]:41942 "EHLO
	exprod5og105.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076Ab0KXGKC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Nov 2010 01:10:02 -0500
Received: from il06vts01.mot.com (il06vts01.mot.com [129.188.137.141])
	by mdgate1.mot.com (8.14.3/8.14.3) with SMTP id oAO6A4dL020325
	for <linux-omap@vger.kernel.org>; Tue, 23 Nov 2010 23:10:04 -0700 (MST)
Received: from mail-ew0-f54.google.com (mail-ew0-f54.google.com [209.85.215.54])
	by mdgate1.mot.com (8.14.3/8.14.3) with ESMTP id oAO6A2j4020315
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-omap@vger.kernel.org>; Tue, 23 Nov 2010 23:10:03 -0700 (MST)
Received: by ewy24 with SMTP id 24so7081166ewy.27
        for <linux-omap@vger.kernel.org>; Tue, 23 Nov 2010 22:09:58 -0800 (PST)
In-Reply-To: <aed955b665a0511402480c258615c2d8@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: TAO HU <taohu@motorola.com>, Bryan Wu <bryan.wu@canonical.com>, linux-omap <linux-omap@vger.kernel.org>

Hi, Santosh

Could you point out the specific kernel option for "L3 error debugging"?

On Wed, Nov 24, 2010 at 1:40 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> TAO,
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of TAO HU
>> Sent: Wednesday, November 24, 2010 10:05 AM
>> To: Bryan Wu
>> Cc: TAO HU; linux-omap
>> Subject: Re: OMAP4 ES2.0 Unhandled fault: imprecise external abort
>>
>> Hi, Bryan
>>
>> Thanks.
>>
>> Unfortunately, it is not easy to reproduce the problem in our HW.
>> We only observed 2~3 times so far.
>>
>> But we do enable HIGHMEM, SMP and L2 cache in our config.
>> That's why I'd like to know the root cause.
>>
>> On Wed, Nov 24, 2010 at 12:21 PM, Bryan Wu <bryan.wu@canonical.com>
> wrote:
>> > Tao Hu,
>> >
>> > Did you try the similar solution in our Ubuntu kernel? We suspect it
>> > related to HIGHMEM, SMP and cache control code.
>> > And how about your test case?
>> >
>> > Thanks a lot,
>> > -Bryan
>> >
>> > On Wed, Nov 24, 2010 at 11:11 AM, TAO HU <tghk48@motorola.com> wrote:
>> >> Hi, All
>> >>
>> >> We got following errors on OMAP ES2.0 board.
>> >>
>> >> And noticed a similar case was reported at below link
>> >> http://www.opensubscriber.com/message/kernel-
>> team@lists.ubuntu.com/14591440.html
>> >>
>> >> Is any conclusion/fix available?
>> >>
>> >> <1>[ 348.873840] Unhandled fault: imprecise external abort (0x1406)
> at
>> >> 0x462d301c
>> >> <1>[ 348.885040] Unhandled fault: imprecise external abort (0x1406)
> at
>> >> 0xbe8fec78
>> >> <1>[ 348.897247] Unhandled fault: imprecise external abort (0x1406)
> at
>> >> 0xbe8fec78
>> >> <1>[ 348.954772] Unhandled fault: imprecise external abort (0x1406)
> at
>> >> 0xb000c454
>> >> <1>[ 348.967590] Unhandled fault: imprecise external abort (0x1406)
> at
>> >> 0xb000c454
>> >> <1>[ 348.989471] Unhandled fault: imprecise external abort (0x1406)
> at
>> >> 0xbeb02fb8
>> >> <4>[ 349.006683] Process 2664(coredump) has RLIMIT_CORE set to 1
>> >> <4>[ 349.012481] Aborting core
>> >> <1>[ 349.023040] Unhandled fault: imprecise external abort (0x1406)
> at
>> >> 0xbeb02fb8
>> >> <1>[ 349.041625] Unhandled fault: imprecise external abort (0x1406)
> at
>> >> 0xbed6cfbc
>> >> <4>[ 349.061370] Process 2665(kkkkkkkkkkkkkkk) has RLIMIT_CORE set to
> 1
>> >> <4>[ 349.067810] Aborting core
>> >> <0>[ 349.077362] Kernel panic - not syncing: Attempted to kill init!
>> >>
>
> Can you enable the L3 error debugging and see the crash log??
> On your build this option should be available.
> It should point you to offending HW initiator/target.
>
> I still don't have a cleaned up version I could submit to LO
>
> Regards,
> Santosh
>



-- 
Best Regards
Hu Tao
