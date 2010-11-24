From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: OMAP4 ES2.0 Unhandled fault: imprecise external abort
Date: Wed, 24 Nov 2010 11:10:16 +0530
Message-ID: <aed955b665a0511402480c258615c2d8@mail.gmail.com>
References: <AANLkTinXqSA0botGAGzEtk8_xOVt0W05k9+0w4v1gqF0@mail.gmail.com><AANLkTin7YJ9GKdpFH1C_fwFXJp6yyO09s5ZJRos1Er1T@mail.gmail.com>
 <AANLkTi=iMXB6LvkNkj5JU17PPC3Kt+hnbDd1s=Dj8voq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:54293 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750941Ab0KXFrU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Nov 2010 00:47:20 -0500
Received: by mail-qw0-f51.google.com with SMTP id 5so888751qwe.24
        for <linux-omap@vger.kernel.org>; Tue, 23 Nov 2010 21:47:18 -0800 (PST)
In-Reply-To: <AANLkTi=iMXB6LvkNkj5JU17PPC3Kt+hnbDd1s=Dj8voq@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: TAO HU <tghk48@motorola.com>, Bryan Wu <bryan.wu@canonical.com>
Cc: TAO HU <taohu@motorola.com>, linux-omap <linux-omap@vger.kernel.org>

TAO,
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of TAO HU
> Sent: Wednesday, November 24, 2010 10:05 AM
> To: Bryan Wu
> Cc: TAO HU; linux-omap
> Subject: Re: OMAP4 ES2.0 Unhandled fault: imprecise external abort
>
> Hi, Bryan
>
> Thanks.
>
> Unfortunately, it is not easy to reproduce the problem in our HW.
> We only observed 2~3 times so far.
>
> But we do enable HIGHMEM, SMP and L2 cache in our config.
> That's why I'd like to know the root cause.
>
> On Wed, Nov 24, 2010 at 12:21 PM, Bryan Wu <bryan.wu@canonical.com>
wrote:
> > Tao Hu,
> >
> > Did you try the similar solution in our Ubuntu kernel? We suspect it
> > related to HIGHMEM, SMP and cache control code.
> > And how about your test case?
> >
> > Thanks a lot,
> > -Bryan
> >
> > On Wed, Nov 24, 2010 at 11:11 AM, TAO HU <tghk48@motorola.com> wrote:
> >> Hi, All
> >>
> >> We got following errors on OMAP ES2.0 board.
> >>
> >> And noticed a similar case was reported at below link
> >> http://www.opensubscriber.com/message/kernel-
> team@lists.ubuntu.com/14591440.html
> >>
> >> Is any conclusion/fix available?
> >>
> >> <1>[ 348.873840] Unhandled fault: imprecise external abort (0x1406)
at
> >> 0x462d301c
> >> <1>[ 348.885040] Unhandled fault: imprecise external abort (0x1406)
at
> >> 0xbe8fec78
> >> <1>[ 348.897247] Unhandled fault: imprecise external abort (0x1406)
at
> >> 0xbe8fec78
> >> <1>[ 348.954772] Unhandled fault: imprecise external abort (0x1406)
at
> >> 0xb000c454
> >> <1>[ 348.967590] Unhandled fault: imprecise external abort (0x1406)
at
> >> 0xb000c454
> >> <1>[ 348.989471] Unhandled fault: imprecise external abort (0x1406)
at
> >> 0xbeb02fb8
> >> <4>[ 349.006683] Process 2664(coredump) has RLIMIT_CORE set to 1
> >> <4>[ 349.012481] Aborting core
> >> <1>[ 349.023040] Unhandled fault: imprecise external abort (0x1406)
at
> >> 0xbeb02fb8
> >> <1>[ 349.041625] Unhandled fault: imprecise external abort (0x1406)
at
> >> 0xbed6cfbc
> >> <4>[ 349.061370] Process 2665(kkkkkkkkkkkkkkk) has RLIMIT_CORE set to
1
> >> <4>[ 349.067810] Aborting core
> >> <0>[ 349.077362] Kernel panic - not syncing: Attempted to kill init!
> >>

Can you enable the L3 error debugging and see the crash log??
On your build this option should be available.
It should point you to offending HW initiator/target.

I still don't have a cleaned up version I could submit to LO

Regards,
Santosh
