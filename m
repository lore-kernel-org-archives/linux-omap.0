From: Tony Lindgren <tony@atomide.com>
Subject: Re: 4430sdp nfsroot broken with ff5c9059
Date: Wed, 10 Apr 2013 13:54:07 -0700
Message-ID: <20130410205407.GQ10155@atomide.com>
References: <20130409212318.GR10155@atomide.com>
 <5165A1DB.3020404@ti.com>
 <20130410182034.GH10155@atomide.com>
 <5165CED4.1040800@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:15421 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1765493Ab3DJUyK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Apr 2013 16:54:10 -0400
Content-Disposition: inline
In-Reply-To: <5165CED4.1040800@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap@vger.kernel.org, "Cousson, Benoit" <b-cousson@ti.com>

* Jon Hunter <jon-hunter@ti.com> [130410 13:47]:
> 
> On 04/10/2013 01:20 PM, Tony Lindgren wrote:
> > * Jon Hunter <jon-hunter@ti.com> [130410 10:35]:
> >> Hi Tony,
> >>
> >> On 04/09/2013 04:23 PM, Tony Lindgren wrote:
> >>> Hi Jon,
> >>>
> >>> Looks like at least 4430sdp nfsroot got broken with commit
> >>> ff5c9059 (ARM: dts: OMAP3+: Correct gpio #interrupts-cells
> >>> property).
> >>
> >> Thanks for reporting. I am actually amazed that ethernet is 
> >> working on any OMAP board (with device-tree) that requires a
> >> gpio as an interrupt because we have still not come to an
> >> agreement on [1]. Looking at the OMAP4 SDP I believe this is
> >> working by luck because there are other gpios in the same
> >> bank that are active and so the bank is enabled. If that were
> >> not the case then this would not work. 
> >>
> >> Hence, I have not been testing ethernet when booting with 
> >> device-tree because we need to fix [1] which has been really
> >> crippling my testing. So this needs to be resolved so ethernet
> >> can work consistently on all omap boards.
> > 
> > Cool.
> >   
> >>> Do we need to pass the GPIO edge/level info now?
> >>
> >> Yes and here is a patch. I have tested on my OMAP4 SDP this
> >> morning. Reviewing all the OMAP/AM dts(i) files I believe
> >> that only the SDP and OMAP4-VAR-SOM are impacted by this. I
> >> don't see any other boards currently using the gpio as an 
> >> interrupt-controller.
> > 
> > Great. Just one comment: You might be able to already use
> > the DT preprocessor now easily with linux next for the edge
> > info.
> 
> Good idea. We could do something like the below, but it would
> be better to include the "arm-gic.h" from the omap4.dtsi file
> so that the definitions can be used there too. The problem is
> that if I include "arm-gic.h" in the omap4.dtsi file I get a
> DTC compiler error because of the "#include" statement. It
> appears that the compiler does not like it if a file includes
> a file using "/include/" and the file it is including uses
> "#include". So really I think that we need to switch all the
> dts/dtsi files to use "#include" first.

OK maybe note that in the description too.

Also, is there need to back port these two patches to v3.9-rc?
If nobody has noticed, I guess not?

Regards,

Tony
