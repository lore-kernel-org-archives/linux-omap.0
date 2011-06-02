From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH pm_wip/voltdm_nm] OMAP: VP: Explicitly mask VPVOLTAGE field
Date: Thu, 02 Jun 2011 16:13:18 -0700
Message-ID: <878vtjomi9.fsf@ti.com>
References: <20110528021559.GA482@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:48513 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755142Ab1FBXNW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jun 2011 19:13:22 -0400
Received: by mail-pz0-f47.google.com with SMTP id 36so652344pzk.20
        for <linux-omap@vger.kernel.org>; Thu, 02 Jun 2011 16:13:21 -0700 (PDT)
In-Reply-To: <20110528021559.GA482@google.com> (Todd Poynor's message of "Fri,
	27 May 2011 19:15:59 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: linux-omap@vger.kernel.org

Todd Poynor <toddpoynor@google.com> writes:

> Reading the VPVOLTAGE field of PRM_VP_*_VOLTAGE registers currently
> relies on a u32 -> u8 conversion to mask off the FORCEUPDATEWAIT field
> in the upper bits.  Make this explicit using the mask symbol
> already defined, added as a new field in struct omap_vp_common.
>
> Signed-off-by: Todd Poynor <toddpoynor@google.com>

Thanks, applied.

Kevin
