From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 00/14] Fix issues with ARMv6+v6k+v7 kernels
Date: Wed, 9 Feb 2011 10:01:33 +0000
Message-ID: <AANLkTimGa-Y6ddHknGe9Gar7+mWPuA_T2+6VL6ecfgxD@mail.gmail.com>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<0557426516de482c1769a50fa0b5f17a@mail.gmail.com>
	<20110208164747.GD6188@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46063 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814Ab1BIKBe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Feb 2011 05:01:34 -0500
Received: by iwn9 with SMTP id 9so6626029iwn.19
        for <linux-omap@vger.kernel.org>; Wed, 09 Feb 2011 02:01:33 -0800 (PST)
In-Reply-To: <20110208164747.GD6188@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 8 February 2011 16:47, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Feb 08, 2011 at 10:06:20PM +0530, Santosh Shilimkar wrote:
>> Have tested this series on OMAP4430 and OMAP3430.
>> Don't know if it helps to push some of these patches to be part
>> of rc cycles. At least the SMP specific fixes should get merged
>> otherwise, builds like omap2plus_defconfig won't be running
>> right configuration on SMP machine.
>
> It's _too_ _late_ in the rc cycle for a fix of this size. =C2=A0As I'=
ve said
> (several times) it was only possible for rc1. =C2=A0That boat has bee=
n missed
> as we're now on rc4. =C2=A0We could see 2.6.38 in as little as two we=
eks time.
>
> =C2=A027 files changed, 183 insertions(+), 197 deletions(-)
>
> is too big.
>
> There's still the outstanding question over:
>
> =C2=A0ARM: v6k: use CPU domain feature if we include support for arch=
 < ARMv6K

Could we make the domains usage a run-time feature based on the
architecture version? For ARMv7, we need to have the vectors page
read-only anyway if the SWP emulation is enabled (and I posted a
simple patch in a reply to your email).

The issue I see is that ARM11MPCore is reported as v7 though we still
use domains on this processor (we could always remove the domains if
TLS register is available or use some more precise architecture
version identification).

--=20
Catalin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
