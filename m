From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH v2 00/13] OMAP: McBSP: hwmod adaptation  and runtime
 conversion
Date: Tue, 1 Feb 2011 19:53:26 +0200
Message-ID: <20110201195326.b3c9f5f5.jhnikula@gmail.com>
References: <1296485437-12806-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63975 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586Ab1BARxa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Feb 2011 12:53:30 -0500
Received: by fxm20 with SMTP id 20so7070558fxm.19
        for <linux-omap@vger.kernel.org>; Tue, 01 Feb 2011 09:53:29 -0800 (PST)
In-Reply-To: <1296485437-12806-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, paul@pwsan.com, charu@ti.com, shubhrajyoti@ti.com, b-cousson@ti.com, khilman@deeprootsystems.com, p-basak2@ti.com

On Mon, 31 Jan 2011 20:20:24 +0530
Kishon Vijay Abraham I <kishon@ti.com> wrote:

> Modify OMAP McBSP driver to use omap hwmod framework and pm runtime  APIs.
> 
> Created on top of linux OMAP master (linux-omap-2.6 :master)
> Did digital loopback testing on OMAP4430, OMAP3430 and OMAP2430 SDP boards.
> Verified that this patch series does not break the OMAP1 build.
> 
> Patch series modifies audio layer and hence would appreciate the help of
> some audio guy to test this series.
> 
> Patch series requires the following patch to be present
> http://permalink.gmane.org/gmane.linux.ports.arm.omap/51132
> http://permalink.gmane.org/gmane.linux.ports.arm.omap/51133
> http://permalink.gmane.org/gmane.linux.ports.arm.omap/51134
> 
Generally I don't see any major show stopper here in audio point of
view after fixing those few minor details. I tested and Beagle plays
fine and N810 too with some tweaks (not related to this set).

Mark, Liam: is it ok if the 12/13 goes together with rest of the set
via linux-omap when ready?

-- 
Jarkko
