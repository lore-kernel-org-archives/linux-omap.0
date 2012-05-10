From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Thu, 10 May 2012 14:05:37 -0500
Message-ID: <4FAC1181.7070403@ti.com>
References: <20120403092524.GD17741@mudshark.cambridge.arm.com> <20120403094749.GH17741@mudshark.cambridge.arm.com> <CAMQu2gyFirtVTWpMu4G_qG5sq33J-_s_o2JhVAdrUf7P3qJ3AA@mail.gmail.com> <20120403123444.GL17741@mudshark.cambridge.arm.com> <878vicsxef.fsf@ti.com> <20120403160706.GP17741@mudshark.cambridge.arm.com> <87ehs4pfw4.fsf@ti.com> <alpine.DEB.2.00.1204031727380.8000@utopia.booyaka.com> <20120404111524.GF32505@mudshark.cambridge.arm.com> <20120426180719.GC20186@mudshark.cambridge.arm.com> <4FA45580.8070802@ti.com> <87ipg76hfm.fsf@ti.com> <4FA8284C.7080803@ti.com> <87k40nzi3i.fsf@ti.com> <4FA8FCFF.40105@ti.com> <4FA9588E.9020906@ti.com> <87sjfal65t.fsf@ti.com> <4FAA4DB9.8060504@ti.com> <4FAAB1A3.9040806@ti.com> <4FAAC549.6010206@ti.com> <4FAAE564.6040708@ti.com> <874nronn0a.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54974 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757177Ab2EJTFt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 15:05:49 -0400
In-Reply-To: <874nronn0a.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Maynard Johnson <maynardj@us.ibm.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, Lik Lik <lik88888@gmail.com>, "eranian@gmail.com" <eranian@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Kevin,

On 05/10/2012 09:12 AM, Kevin Hilman wrote:
> Jon Hunter <jon-hunter@ti.com> writes:
> 
> [...]
> 
>> I have posted my latest series here [1] based upon that from Will [2]
>> which attempts to fix the EMU CD based upon the inputs from this thread.
>> It is working on my omap4460 panda. 
> 
> There are some differences between 4430 and 4460 here.  Can you test on
> 4430 as well?

No problem. I tested on an OMAP4430 ES2.2 EMU blaze this morning and it
is also working.

By the way, from an EMU power domain perspective the omap4430 and
omap4460 behave the same, that is the PD is always set to OFF state and
so will transition to OFF when ever the EMU CD idles. So same problem
exists when using PMU and CTI.

Cheers
Jon
