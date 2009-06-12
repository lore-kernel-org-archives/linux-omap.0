From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH 1/2] Serial: Define IRQ flags for 8250 driver
Date: Sat, 13 Jun 2009 00:41:53 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F5346526@dbde02.ent.ti.com>
References: <1244767784-22820-1-git-send-email-vikram.pandita@ti.com>
 <7A436F7769CA33409C6B44B358BFFF0C0115CBC08A@dlee02.ent.ti.com>
 <20090612063743.GA655@nokia.com>
 <7A436F7769CA33409C6B44B358BFFF0C0115CBC2F2@dlee02.ent.ti.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F53464BE@dbde02.ent.ti.com>
 <20090612190139.GC28101@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35965 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754186AbZFLTMI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jun 2009 15:12:08 -0400
In-Reply-To: <20090612190139.GC28101@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: Felipe Balbi [mailto:felipe.balbi@nokia.com]
>Sent: Friday, June 12, 2009 2:02 PM
>To: Pandita, Vikram
>Cc: Menon, Nishanth; Balbi Felipe (Nokia-D/Helsinki); linux-omap@vger.kernel.org
>Subject: Re: [PATCH 1/2] Serial: Define IRQ flags for 8250 driver
>
>On Fri, Jun 12, 2009 at 04:50:09PM +0200, ext Pandita, Vikram wrote:
>>
>>
>
>remove the default part:
>
>switch (up->port.flags & UPF_IRQ_FLAGS_MASK) {
>case UPF_IRQ_TRIG_RISING:
>	irq_flags |= IRQF_TRIGGER_RISING;
>	break;
>case UPF_IRQ_TRIG_FALLING:
>	irq_flags |= IRQF_TRIGGER_FALLING;
>	break;
>case UPF_IRQ_TRIG_HIGH:
>	irq_flags |= IRQF_TRIGGER_HIGH;
>	break;
>case UPF_IRQ_TRIG_LOW:
>	irq_flags |= IRQF_TRIGGER_LOW;
>	break;
>default:
>	break;
>}

Have posted the original patch to linux-serial already.
I can see your change is a replacement for if:else with switch:case

Thanks for the review. Lets see what's the response on the patch, and see when we can put these changes in.

>
>--
>balbi

