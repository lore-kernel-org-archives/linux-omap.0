From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [alsa-devel] [PATCH v2 00/13] OMAP: McBSP: hwmod adaptation
 and runtime conversion
Date: Tue, 01 Feb 2011 17:58:17 +0000
Message-ID: <1296583097.3327.83.camel@odin>
References: <1296485437-12806-1-git-send-email-kishon@ti.com>
	 <20110201195326.b3c9f5f5.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59514 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477Ab1BAR6l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Feb 2011 12:58:41 -0500
Received: by ewy5 with SMTP id 5so3292738ewy.19
        for <linux-omap@vger.kernel.org>; Tue, 01 Feb 2011 09:58:40 -0800 (PST)
In-Reply-To: <20110201195326.b3c9f5f5.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, alsa-devel@alsa-project.org, b-cousson@ti.com, khilman@deeprootsystems.com, broonie@opensource.wolfsonmicro.com, paul@pwsan.com, p-basak2@ti.com, linux-omap@vger.kernel.org, shubhrajyoti@ti.com, charu@ti.com

On Tue, 2011-02-01 at 19:53 +0200, Jarkko Nikula wrote:
> On Mon, 31 Jan 2011 20:20:24 +0530
> Kishon Vijay Abraham I <kishon@ti.com> wrote:
> 
> > Modify OMAP McBSP driver to use omap hwmod framework and pm runtime  APIs.
> > 
> > Created on top of linux OMAP master (linux-omap-2.6 :master)
> > Did digital loopback testing on OMAP4430, OMAP3430 and OMAP2430 SDP boards.
> > Verified that this patch series does not break the OMAP1 build.
> > 
> > Patch series modifies audio layer and hence would appreciate the help of
> > some audio guy to test this series.
> > 
> > Patch series requires the following patch to be present
> > http://permalink.gmane.org/gmane.linux.ports.arm.omap/51132
> > http://permalink.gmane.org/gmane.linux.ports.arm.omap/51133
> > http://permalink.gmane.org/gmane.linux.ports.arm.omap/51134
> > 
> Generally I don't see any major show stopper here in audio point of
> view after fixing those few minor details. I tested and Beagle plays
> fine and N810 too with some tweaks (not related to this set).
> 
> Mark, Liam: is it ok if the 12/13 goes together with rest of the set
> via linux-omap when ready?
> 

Yep, that should be OK.

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk

