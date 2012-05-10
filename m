From: Will Deacon <will.deacon@arm.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Thu, 10 May 2012 09:44:23 +0100
Message-ID: <20120510084422.GB27276@mudshark.cambridge.arm.com>
References: <87ipg76hfm.fsf@ti.com>
 <4FA8284C.7080803@ti.com>
 <87k40nzi3i.fsf@ti.com>
 <4FA8FCFF.40105@ti.com>
 <4FA9588E.9020906@ti.com>
 <87sjfal65t.fsf@ti.com>
 <4FAA4DB9.8060504@ti.com>
 <4FAAB1A3.9040806@ti.com>
 <4FAAC549.6010206@ti.com>
 <4FAAE564.6040708@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:33788 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756273Ab2EJIxw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 04:53:52 -0400
Content-Disposition: inline
In-Reply-To: <4FAAE564.6040708@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Ming Lei <ming.lei@canonical.com>, Maynard Johnson <maynardj@us.ibm.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, Lik Lik <lik88888@gmail.com>, "eranian@gmail.com" <eranian@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, May 09, 2012 at 10:45:08PM +0100, Jon Hunter wrote:
> Hi All,

Hi Jon,

> I have posted my latest series here [1] based upon that from Will [2]
> which attempts to fix the EMU CD based upon the inputs from this thread.
> It is working on my omap4460 panda. Hopefully Ming and/or Will can also
> test. I know that Ming is out this week but said he can test next week.

Many thanks to you (+Kevin, Benoit, Paul and co) for persevering with this.
If I can get my hands on a Panda, I'll see if I can test something this
week. Any particular tests you want me to run to exercise the interaction
with PM?

Cheers,

Will
