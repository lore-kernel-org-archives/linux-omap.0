From: Cliff Brake <cliff.brake@gmail.com>
Subject: Re: [PATCH] OMAP3 PM: fix the error messages printed when the system suspend
Date: Tue, 10 Aug 2010 18:16:22 -0400
Message-ID: <AANLkTimS8Wns3Do3R+BrevjnuTb+mzP1iF3NsRtDjYQa@mail.gmail.com>
References: <1277195484-5501-1-git-send-email-stanley.miao@windriver.com>
	<87iq5bm7ac.fsf@deeprootsystems.com>
	<AANLkTi=Dud9H_1TUD6egOtAUaSYzqyqsMP3=3Sj9YWjZ@mail.gmail.com>
	<4C60ABAA.5010805@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52439 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932759Ab0HJWQY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 18:16:24 -0400
Received: by wwj40 with SMTP id 40so13473596wwj.1
        for <linux-omap@vger.kernel.org>; Tue, 10 Aug 2010 15:16:23 -0700 (PDT)
In-Reply-To: <4C60ABAA.5010805@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "stanley.miao" <stanley.miao@windriver.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

On Mon, Aug 9, 2010 at 9:30 PM, stanley.miao <stanley.miao@windriver.co=
m> wrote:
> Cliff Brake wrote:
>>
>> Functionally, what does this statement mean? =A0The 3503 seems to ha=
ve
>> the EN_IO [8] bit, but I've yet to figure out what the EN_IO_CHAIN
>> [16] means.
>>
>
> Please reference to Chapter 4.11 PRCM Off-Mode Management in OMAP35x =
TRM.

Thanks for the pointer.  Do you know offhand what TI documentation
details the differences between the 3503 and the 3530 in this regard.
I'm also trying to piece together what practical impact this will have
on a system.

I have an older 3503 system, and it is still spewing "Wake up daisy
chain activation failed" messages.  Do you expect the following patch
would have fixed this?

So I then instrumented the following macros:

CLIFF: cpu_is_omap3503 =3D 0
CLIFF: cpu_is_omap3515 =3D 0
CLIFF: cpu_is_omap3525 =3D 0
CLIFF: cpu_is_omap3530 =3D 0
CLIFF: is_omap3430 =3D 0
CLIFF: omap3_has_iva =3D 2
CLIFF: omap3_has_sgx =3D 0
CLIFF: omap3_has_io_wakeup =3D 64

Perhaps it is not a 3503???  The kernel prints the following on bootup:
OMAP3525 ES2.1 (l2cache iva neon isp )

But, then I look at u-boot, and see:
OMAP3503-GP ES2.1, CPU-OPP2, L3-165MHz, Max clock-600Mhz

So not everyone is telling the same story.  Anyway, it seems we have a
problem in that the cpu_is_xxx macros are not working.

Thanks,
Cliff

commit ad0c63f1d623ea9d3e0c0521d5ce9cd522c4e1f0
Author: stanley.miao <stanley.miao@windriver.com>
Date:   Mon Aug 2 14:21:40 2010 +0300

    OMAP3: AM3505/3517 do not have IO wakeup capability

    AM3505/3517 doesn't have IO wakeup capability, so we do not need to=
 set
    the bit OMAP3430_EN_IO and the bit OMAP3430_EN_IO_CHAIN in the regi=
ster
    PM_WKEN_WKUP when the system enters suspend state.

    Tested on AM3517EVM and OMAP3530EVM.

    Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
    Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
    Signed-off-by: Tony Lindgren <tony@atomide.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
