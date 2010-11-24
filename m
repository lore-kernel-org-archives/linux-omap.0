From: TAO HU <tghk48@motorola.com>
Subject: Re: OMAP4 ES2.0 Unhandled fault: imprecise external abort
Date: Wed, 24 Nov 2010 12:34:48 +0800
Message-ID: <AANLkTi=iMXB6LvkNkj5JU17PPC3Kt+hnbDd1s=Dj8voq@mail.gmail.com>
References: <AANLkTinXqSA0botGAGzEtk8_xOVt0W05k9+0w4v1gqF0@mail.gmail.com>
	<AANLkTin7YJ9GKdpFH1C_fwFXJp6yyO09s5ZJRos1Er1T@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from exprod5og113.obsmtp.com ([64.18.0.26]:58598 "EHLO
	exprod5og113.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998Ab0KXEeu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Nov 2010 23:34:50 -0500
Received: from il27vts01 (il27vts01.cig.mot.com [10.17.196.85])
	by mdgate2.corp.mot.com (8.14.3/8.14.3) with SMTP id oAO4XRLK000854
	for <linux-omap@vger.kernel.org>; Tue, 23 Nov 2010 21:33:27 -0700 (MST)
Received: from mail-ew0-f54.google.com (mail-ew0-f54.google.com [209.85.215.54])
	by mdgate2.corp.mot.com (8.14.3/8.14.3) with ESMTP id oAO4WmVl000739
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-omap@vger.kernel.org>; Tue, 23 Nov 2010 21:33:27 -0700 (MST)
Received: by mail-ew0-f54.google.com with SMTP id 24so5938891ewy.27
        for <linux-omap@vger.kernel.org>; Tue, 23 Nov 2010 20:34:49 -0800 (PST)
In-Reply-To: <AANLkTin7YJ9GKdpFH1C_fwFXJp6yyO09s5ZJRos1Er1T@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <bryan.wu@canonical.com>
Cc: TAO HU <taohu@motorola.com>, linux-omap <linux-omap@vger.kernel.org>

Hi, Bryan

Thanks.

Unfortunately, it is not easy to reproduce the problem in our HW.
We only observed 2~3 times so far.

But we do enable HIGHMEM, SMP and L2 cache in our config.
That's why I'd like to know the root cause.

On Wed, Nov 24, 2010 at 12:21 PM, Bryan Wu <bryan.wu@canonical.com> wro=
te:
> Tao Hu,
>
> Did you try the similar solution in our Ubuntu kernel? We suspect it
> related to HIGHMEM, SMP and cache control code.
> And how about your test case?
>
> Thanks a lot,
> -Bryan
>
> On Wed, Nov 24, 2010 at 11:11 AM, TAO HU <tghk48@motorola.com> wrote:
>> Hi, All
>>
>> We got following errors on OMAP ES2.0 board.
>>
>> And noticed a similar case was reported at below link
>> http://www.opensubscriber.com/message/kernel-team@lists.ubuntu.com/1=
4591440.html
>>
>> Is any conclusion/fix available?
>>
>> <1>[ 348.873840] Unhandled fault: imprecise external abort (0x1406) =
at
>> 0x462d301c
>> <1>[ 348.885040] Unhandled fault: imprecise external abort (0x1406) =
at
>> 0xbe8fec78
>> <1>[ 348.897247] Unhandled fault: imprecise external abort (0x1406) =
at
>> 0xbe8fec78
>> <1>[ 348.954772] Unhandled fault: imprecise external abort (0x1406) =
at
>> 0xb000c454
>> <1>[ 348.967590] Unhandled fault: imprecise external abort (0x1406) =
at
>> 0xb000c454
>> <1>[ 348.989471] Unhandled fault: imprecise external abort (0x1406) =
at
>> 0xbeb02fb8
>> <4>[ 349.006683] Process 2664(coredump) has RLIMIT_CORE set to 1
>> <4>[ 349.012481] Aborting core
>> <1>[ 349.023040] Unhandled fault: imprecise external abort (0x1406) =
at
>> 0xbeb02fb8
>> <1>[ 349.041625] Unhandled fault: imprecise external abort (0x1406) =
at
>> 0xbed6cfbc
>> <4>[ 349.061370] Process 2665(kkkkkkkkkkkkkkk) has RLIMIT_CORE set t=
o 1
>> <4>[ 349.067810] Aborting core
>> <0>[ 349.077362] Kernel panic - not syncing: Attempted to kill init!
>>
>> --
>> Best Regards
>> Hu Tao
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>



--=20
Best Regards
Hu Tao
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
