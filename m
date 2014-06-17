From: Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: Re: Unifying cape overlays into boot .dtb for BeagleBoard.org boards
Date: Tue, 17 Jun 2014 19:59:21 +0300
Message-ID: <317D412E-B455-4B9D-95B3-F010C68744A3@antoniou-consulting.com>
References: <CA+T6QP==raXdWz9mezK3JxSvZjWhUZZ7aKv4CpCr0SbdaCMgDQ@mail.gmail.com> <CA+T6QPmCk9GzHPHqCKG4vHDvUGirgGaizH-V9bsHT4V=8=gCaA@mail.gmail.com> <20140617090931.GB3705@n2100.arm.linux.org.uk> <20140617125831.GI4173@beef> <20140617131522.GD3705@n2100.arm.linux.org.uk> <C3DA6AFC-2784-4A41-BC72-EF25B2B03B41@antoniou-consulting.com> <20140617160119.GE3705@n2100.arm.linux.org.uk>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from li42-95.members.linode.com ([209.123.162.95]:57707 "EHLO
	li42-95.members.linode.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933627AbaFQQ7b convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jun 2014 12:59:31 -0400
In-Reply-To: <20140617160119.GE3705@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Matt Porter <mporter@linaro.org>, Jason Kridner <jkridner@gmail.com>, beagleboard@googlegroups.com, Robert Nelson <robertcnelson@gmail.com>, devicetree@vger.kernel.org, OMAP List <linux-omap@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@secretlab.ca>

Hi Russell,

On Jun 17, 2014, at 7:01 PM, Russell King - ARM Linux wrote:

> On Tue, Jun 17, 2014 at 04:32:11PM +0300, Pantelis Antoniou wrote:
>> The complexity is absolutely required, and it has nothing to do with
>> beaglebone capes.
>> 
>> The fact of the matter is that reconfigurable hardware is here, on
>> shipping system, and we, as the linux kernel community have to make
>> sure it works, and that it works in a sane way.
> 
> Right, so looking back in the git history, this project has been going
> on for... at least four years?  Probably longer than the length of time
> that we've been converting ARM to DT.  At no point during that has anyone
> brought up the issue of DT being dynamic, so none of the drivers which
> we have been converting caters for this.
> 

The timeline does not go that far back. The first (non-DT overlay based)
capebus patchset was posted on October 2012 and after feedback (i.e. it
was deemed to suck) it was pointed that a DT based generic method should
be used; hence DT overlays.

The dynamic DT part has always been part of PPC DT support for pSeries.

> Isn't this a bit of a missed opportunity, if this is a direction that
> OF wishes to head towards?
> 

I am going to let Grant answer that, but personally I believe a lot of
the troubles we've been having with DT and dynamic device graph changes
can be handled elegantly using something DT overlays (and the follow up
work which is transaction DT support).
 
> Wouldn't it have been relevant to the discussion at kernel summit too,
> concerning DRM/v4l2/componentised systems?  What if someone comes along
> tomorrow with part of their multimedia based system inside a FPGA
> which they program up at runtime?
> 

That case might already work on FPGA people's trees. I know Altera for sure
uses overlays, and some xilinx guys popped up on past discussions.
Their vendor trees probably use an older revision of the patches.

BTW, there is nothing special about DRM/v4l2 that can't be handled by a generic
DT mechanism. What makes this such a big problem?

Regards

-- Pantelis


> -- 
> FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
> improving, and getting towards what was expected from it.
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

