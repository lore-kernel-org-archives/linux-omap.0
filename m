From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: Re: OMAP3 L2/outer cache enabled in kernel (after being disabled by
	uBoot)?
Date: Fri, 27 Jan 2012 11:45:52 +0000
Message-ID: <WC20120127114552.660060@terrafix.co.uk>
References: <CAMQu2gzPGrbBd4_SOM0TFfGH_Y+XYzoh2XjsoPgpzU10tFOpYQ@mail.gmail.com> <WC20120117085444.17057E@terrafix.co.uk> <20120117121138.GC11475@arm.com> <4F15692D.4070100@ti.com> <CAMQu2gyft96O61Toja-h-MPpzFTQ8dpJWauw3o6qcPQBXEC_6A@mail.gmail.com> <20120117133918.GE11475@arm.com> <CAMQu2gwANxCe-ou_qv29ueLixodoHv9i6VyfvDi2rjEOvhttqA@mail.gmail.com> <WC20120120085711.330803@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp3.keele.netcentral.co.uk ([212.57.235.197]:57570 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754235Ab2A0Lqs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Jan 2012 06:46:48 -0500
In-Reply-To: <WC20120120085711.330803@terrafix.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Catalin Marinas <catalin.marinas@arm.com>
Cc: Aneesh V <aneesh@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm <linux-arm-kernel@lists.infradead.org>

Sorry for the shameless ping, but I'd really like to know the way forward here...

-----Original Message-----
From: "Joe Woodward" <jw@terrafix.co.uk>
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Catalin Marinas" <catalin.marinas@arm.com>
Cc: "Aneesh V" <aneesh@ti.com>, "Russell King - ARM Linux" <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, "linux-arm" <linux-arm-
kernel@lists.infradead.org>
Date: Fri, 20 Jan 2012 08:57:11 +0000
Subject: Re: OMAP3 L2/outer cache enabled in kernel (after being disabled by uBoot)?

> > 
> > So I re-iterate that we need to have solution to this problem.
> > 
> 
> ... I don't want to be a pain, but it seems to me that this dicussion
> didn't reach a full conclussion?
> 
> I think it was left with the open options being:
> 1) Leave the L2/outer cache enabled in the bootloader (not ideal and
> may cause problems with future devices)
> 2) Turn the L2/outer cache on for OMAP3 later in the kernel boot when
> the device is known
> 
> Is there any concensus?
> 
> Cheers,
> Joe
> 
> > Regards
> > Santosh
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


