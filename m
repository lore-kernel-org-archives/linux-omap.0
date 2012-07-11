From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH] OMAP: USB : Fix the EHCI enumeration and core retention
 issue
Date: Wed, 11 Jul 2012 12:29:58 +0200
Message-ID: <20120711102958.GA23772@sortiz-mobl>
References: <87ehp71liv.fsf@ti.com>
 <20120622203645.GD29290@arwen.pp.htv.fi>
 <87d34nfdei.fsf@ti.com>
 <871uku85o8.fsf@ti.com>
 <CAP05o4+hxt6zY0AxK5aNW7a3Hyiw0_krP9=XK_prN5=Uk2SxmA@mail.gmail.com>
 <CAP05o4KinrK7N13nivOy+reibY526c8sv6ySkxwDZwDMJHSaiQ@mail.gmail.com>
 <87k3yj4pn4.fsf@ti.com>
 <20120705111901.GR22065@sortiz-mobl>
 <CAP05o4JEx0uSCH+mZzLhoV479A00uUumvYY_-b8dQ9j_5Awumw@mail.gmail.com>
 <CAP05o4+OBPBzqurM2FHDBmQ0AbBLVHL5DP+cMHW+jS5bG23-EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:32622 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757107Ab2GKKS1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Jul 2012 06:18:27 -0400
Content-Disposition: inline
In-Reply-To: <CAP05o4+OBPBzqurM2FHDBmQ0AbBLVHL5DP+cMHW+jS5bG23-EQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Munegowda, Keshava" <keshava_mgowda@ti.com>, Kevin Hilman <khilman@ti.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, notasas@gmail.com, Paul Walmsley <paul@pwsan.com>

Hi Keshava, Kevin,

On Fri, Jul 06, 2012 at 05:29:00PM +0530, Munegowda, Keshava wrote:
> Samuel
>           I have sent that patch to disable the ehci in
> omap2plus_defconfig; after merging that
> please merge this patch too. This will fix the crashes in during boot
> with NFS in beagleXM
I'm going to apply and push this patch for 3.5, and the defconfig patch can be
pushed through Tony's tree.
Kevin, could you please ACK it ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
