From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3] OMAP4: pm.c extensions for OMAP4 support
Date: Tue, 14 Sep 2010 11:35:54 -0700
Message-ID: <1284489354.2661.74.camel@localhost>
References: <1283328893-14556-1-git-send-email-thara@ti.com>
	 <1284488501.2661.72.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:43557 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087Ab0INSgC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Sep 2010 14:36:02 -0400
Received: by pvg2 with SMTP id 2so2525625pvg.19
        for <linux-omap@vger.kernel.org>; Tue, 14 Sep 2010 11:36:01 -0700 (PDT)
In-Reply-To: <1284488501.2661.72.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, vishwanath.bs@ti.com, sawant@ti.com

On Tue, 2010-09-14 at 11:21 -0700, Kevin Hilman wrote:
> On Wed, 2010-09-01 at 13:44 +0530, Thara Gopinath wrote:
> > OMAP4 has an iva device and a dsp devcice where as OMAP2/3
> > has only an iva device. In this file the iva device in the
> > system is registered under the name dsp_dev and the API
> > to retrieve the iva device is omap2_get_dsp_device.
> > This patch renames the dsp_dev to iva_dev, renames
> > omap2_get_dsp_device to omap2_get_iva_device,
> > registers dsp_dev for OMAP4 and adds a new API
> > omap4_get_dsp_device to retrieve the dep_dev.
> > 
> > Signed-off-by: Thara Gopinath <thara@ti.com>
> > ---
> > v2: Removed fixing of l3_main hwmod for OMAP4 as Benoit has
> >     already submitted a pach fixing the same.
> > v3: Put OMAP4 check across dsp_dev init so that on other
> >     OMAP's this init does not throw a warn.
> 
> Thanks, queuing for 2.6.37 in my pm-next branch.
> 
> I changed the subject slightly, and I had to fix up a conflict that
> wasn't there when you submitted, so I fixed it myself: basically, there
> was already a cpu_is_omap4* check in the function due to the l3_main
> name differences, so I just added the dsp check to the existing cpu_is
> check. 

Ignore the bit about the conflict.  It applies cleanly to my pm-next.

The conflict is when merging with the l3_main name change later in the
pm-core branch.

Kevin


