From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: [PATCH v2] ARM: OMAP3: PM: fix I/O wakeup and I/O chain clock
 control detection
Date: Thu, 6 Oct 2011 14:22:23 -0700
Message-ID: <CAGDS+nmb20E4y2HqBtDN05PK1C1YXjmRvnVAbQkhGpp17s4Zcg@mail.gmail.com>
References: <alpine.DEB.2.00.1110061310390.4611@utopia.booyaka.com>
	<CAGDS+nno3=sDDwdF6Ew6qG-8mN9bCeawCpho+AJo=jE9QVk0ag@mail.gmail.com>
	<alpine.DEB.2.00.1110061346570.4611@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:39193 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965205Ab1JFVWY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Oct 2011 17:22:24 -0400
Received: by vcbfk10 with SMTP id fk10so2611225vcb.19
        for <linux-omap@vger.kernel.org>; Thu, 06 Oct 2011 14:22:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1110061346570.4611@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, dhylands@gmail.com

On Thu, Oct 6, 2011 at 12:47 PM, Paul Walmsley <paul@pwsan.com> wrote:
>
> The way that we detect which OMAP3 chips support I/O wakeup and
> software I/O chain clock control is broken.
>
> Currently, I/O wakeup is marked as present for all OMAP3 SoCs other
> than the AM3505/3517. =A0The TI81xx family of SoCs are at present
> considered to be OMAP3 SoCs, but don't support I/O wakeup. =A0To reso=
lve
> this, convert the existing blacklist approach to an explicit,
> whitelist support, in which only SoCs which are known to support I/O
> wakeup are listed. =A0(At present, this only includes OMAP34xx,
> OMAP3503, OMAP3515, OMAP3525, OMAP3530, and OMAP36xx.)
>
> Also, the current code incorrectly detects the presence of a
> software-controllable I/O chain clock on several chips that don't
> support it. =A0This results in writes to reserved bitfields, unnecess=
ary
> delays, and console messages on kernels running on those chips:
>
> =A0 =A0http://www.spinics.net/lists/linux-omap/msg58735.html
>
> Convert this test to a feature test with a chip-by-chip whitelist.
>
> Thanks to Dave Hylands <dhylands@gmail.com> for reporting this proble=
m
> and doing some testing to help isolate the cause. =A0Thanks to Steve
> Sakoman <sakoman@gmail.com> for catching a bug in the first version o=
f
> this patch.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Dave Hylands <dhylands@gmail.com>
> Cc: Steve Sakoman <sakoman@gmail.com>

I just tested a Linux 3.0 version of the patch on both ES2.1
and ES3.1 and it works just fine.

So here is my:

Tested-by: Steve Sakoman <steve@sakoman.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
