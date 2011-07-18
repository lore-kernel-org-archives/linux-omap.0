From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv3 1/6] OMAP: move voltage.h and vp.h under platform include directory
Date: Mon, 18 Jul 2011 16:45:27 -0700
Message-ID: <8762mzkvag.fsf@ti.com>
References: <1311010522-5868-1-git-send-email-t-kristo@ti.com>
	<1311010522-5868-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:42761 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751728Ab1GRXpb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Jul 2011 19:45:31 -0400
Received: by mail-iw0-f176.google.com with SMTP id 5so5004562iwi.35
        for <linux-omap@vger.kernel.org>; Mon, 18 Jul 2011 16:45:30 -0700 (PDT)
In-Reply-To: <1311010522-5868-2-git-send-email-t-kristo@ti.com> (Tero Kristo's
	message of "Mon, 18 Jul 2011 20:35:17 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, toddpoynor@google.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com

Tero Kristo <t-kristo@ti.com> writes:

> This is needed so that these include files can be accessed from drivers.

I think you can get by with a <plat/voltage.h> with simply an opaque
struct voltagedomain, and the definitions of the functions needed by the
regulator driver (currently only voltdm_scale, omap_vp_get_curr_volt).
Then mach-omap2/voltage.h could just include <plat/voltage.h> and all
the truly internal stuff can stay internal.

Also note that in the latest pm-wip/voltdm branch (just pushed)
omap_vp_get_curr_volt() no longer exists.  Just use
voltdm_get_voltage().

Kevin
