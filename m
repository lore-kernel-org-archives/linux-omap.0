From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [RFC] tidspbridge: use a parameter to allocate shared memory
Date: Thu, 7 Oct 2010 14:16:49 -0500
Message-ID: <4CAE1CA1.4050006@ti.com>
References: <1286430336-20204-1-git-send-email-omar.ramirez@ti.com>	<201010070940.14208.laurent.pinchart@ideasonboard.com>	<4CADFCEB.4030008@ti.com> <AANLkTim8H0ibSucP3Nq=q19t0QY0pvijim1kOZSbygY1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58293 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751460Ab0JGTRI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Oct 2010 15:17:08 -0400
In-Reply-To: <AANLkTim8H0ibSucP3Nq=q19t0QY0pvijim1kOZSbygY1@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, Greg Kroah-Hartman <gregkh@suse.de>, Russell King <linux@arm.linux.org.uk>, "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>, "Ramos Falcon, Ernesto" <ernesto@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>

On 10/7/2010 1:22 PM, Felipe Contreras wrote:
...
>
> Note that the "shared memory" described in the document you share has
> nothing to do with the SHM pool. AFAIK that memory is used for other
> things, like MMU PTEs, and storing the base image and socket-nodes,
> thus it needs to be contiguous.

hmmm, no. it is the same memory. i.e.: we propagate the current opp 
through the shared memory so the dsp can read it if it went to sleep, 
with the proper offset you can read that variable starting from the 
mempool base address.

"storing the base image and socket-nodes" symbols is also donde in the 
shared memory but this is done in different sections of the SHM.

>
> Right now allocating contiguous memory can only be done with memblock
> (bootmem), but in the future it could be done with CMA/VCMM. But the
> cacheability is a separate issue.

yes

>
> I don't see any problem flushing the SHM area when needed, which
> probably has performance implications when mmaping/unmapping buffers,
> at which point you need to flush bigger memory areas anyway, so that's
> not an issue.

well, you would have to flush when loading the base image, or allocating 
a socket node, but also minor flushes for opp propagation, SHM messages 
to DSP, chnl params, those are the ones I can quickly think of.

>
> Anyway, we will not know for sure until we try... Right?

yes we can try, at least we now for sure arm side can be done.

Regards,

omar

