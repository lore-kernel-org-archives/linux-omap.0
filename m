From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: OMAP4 ES2.0 Unhandled fault: imprecise external abort
Date: Wed, 24 Nov 2010 12:21:57 +0800
Message-ID: <AANLkTin7YJ9GKdpFH1C_fwFXJp6yyO09s5ZJRos1Er1T@mail.gmail.com>
References: <AANLkTinXqSA0botGAGzEtk8_xOVt0W05k9+0w4v1gqF0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:48823 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001Ab0KXEV6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Nov 2010 23:21:58 -0500
Received: by qwb7 with SMTP id 7so381618qwb.19
        for <linux-omap@vger.kernel.org>; Tue, 23 Nov 2010 20:21:57 -0800 (PST)
In-Reply-To: <AANLkTinXqSA0botGAGzEtk8_xOVt0W05k9+0w4v1gqF0@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: TAO HU <tghk48@motorola.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Tao Hu,

Did you try the similar solution in our Ubuntu kernel? We suspect it
related to HIGHMEM, SMP and cache control code.
And how about your test case?

Thanks a lot,
-Bryan

On Wed, Nov 24, 2010 at 11:11 AM, TAO HU <tghk48@motorola.com> wrote:
> Hi, All
>
> We got following errors on OMAP ES2.0 board.
>
> And noticed a similar case was reported at below link
> http://www.opensubscriber.com/message/kernel-team@lists.ubuntu.com/14=
591440.html
>
> Is any conclusion/fix available?
>
> <1>[ 348.873840] Unhandled fault: imprecise external abort (0x1406) a=
t
> 0x462d301c
> <1>[ 348.885040] Unhandled fault: imprecise external abort (0x1406) a=
t
> 0xbe8fec78
> <1>[ 348.897247] Unhandled fault: imprecise external abort (0x1406) a=
t
> 0xbe8fec78
> <1>[ 348.954772] Unhandled fault: imprecise external abort (0x1406) a=
t
> 0xb000c454
> <1>[ 348.967590] Unhandled fault: imprecise external abort (0x1406) a=
t
> 0xb000c454
> <1>[ 348.989471] Unhandled fault: imprecise external abort (0x1406) a=
t
> 0xbeb02fb8
> <4>[ 349.006683] Process 2664(coredump) has RLIMIT_CORE set to 1
> <4>[ 349.012481] Aborting core
> <1>[ 349.023040] Unhandled fault: imprecise external abort (0x1406) a=
t
> 0xbeb02fb8
> <1>[ 349.041625] Unhandled fault: imprecise external abort (0x1406) a=
t
> 0xbed6cfbc
> <4>[ 349.061370] Process 2665(kkkkkkkkkkkkkkk) has RLIMIT_CORE set to=
 1
> <4>[ 349.067810] Aborting core
> <0>[ 349.077362] Kernel panic - not syncing: Attempted to kill init!
>
> --
> Best Regards
> Hu Tao
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
