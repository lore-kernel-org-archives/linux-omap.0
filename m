From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: Serial port crashes omap3 on boot with 2.6.28rc4
Date: Fri, 14 Nov 2008 17:52:56 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403E5F2B68D@dbde02.ent.ti.com>
References: <571101AA-6E65-4BA6-8DF6-B445515010A1@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58601 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751618AbYKNMXF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Nov 2008 07:23:05 -0500
In-Reply-To: <571101AA-6E65-4BA6-8DF6-B445515010A1@student.utwente.nl>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>



Thanks,
Vaibhav Hiremath

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Koen Kooi
> Sent: Friday, November 14, 2008 5:45 PM
> To: linux-omap@vger.kernel.org List
> Subject: Re: Serial port crashes omap3 on boot with 2.6.28rc4
> 
> 
> Op 14 nov 2008, om 11:56 heeft Koen Kooi het volgende geschreven:
> 
> >
> > Op 14 nov 2008, om 11:17 heeft Koen Kooi het volgende geschreven:
> >
> >> Hi,
> >>
> >> I updated to the current head
> >> (5ecf98b76fa95078277c9037bb01640fd3de5e2c) and get this on boot
> >> (with debug_ll) on omap3evm:
> >>
> >> <7>omap-dss DISPLAY: panel 'panel-dvi' registered
> >> <6>Serial: 8250/16550 driver4 ports, IRQ sharing enabled
> >> <6>serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654
> >> <....,...:4...4../0400..1=......F1.5S.<....,...:4.3^F!^C../
> >> 0.0^F00..1=7K....F1.5S.<.....%;..&=%.".$.<."F:..5. .!*$.<...0^G..
> >> 5. .!*$.<...%^B-
> J/.0.."..%C0^G...5(V6..!^C0.^D000)^V.6...%C0^G%C%.
> >> %^C!"2^G.."...$...&R...%C0^G...8).%
> >> ..'%:%.#. ...,.<.!.74^C3..:..#.#V%...1.V..<.).5...v8. {...$.r.
> >> 3...6......
> >>
> >> Any ideas?
> >
> > I get this on rc3 now as well, it seems that the evm dss2 patch
> has
> > some side effects, console is restored when userspace launches
> getty
> 
> I can boot rc4 + dss2 + dss2-evm into userspace if the omap_rev()
> TWL
> writes don't get triggered in board-omap3evm.c. Once those get run I
> get more garbage and a crash, without them a little garbage that
> getty
> fixes up.
> 
[Hiremath, Vaibhav] Is this happens with default config + DSS2 + DSS2FB? Are you enabling something extra config option?
I have tested it on EVM board, and it is working for me.

> regards,
> 
> Koen
