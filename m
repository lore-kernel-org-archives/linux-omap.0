From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] arm: omap3: Only access IVA if one exists
Date: Fri, 27 Apr 2012 14:15:12 -0700
Message-ID: <87bomc27xb.fsf@ti.com>
References: <1334859465-14352-1-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:50406 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753642Ab2D0VPK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Apr 2012 17:15:10 -0400
Received: by pbbrr4 with SMTP id rr4so1611360pbb.26
        for <linux-omap@vger.kernel.org>; Fri, 27 Apr 2012 14:15:09 -0700 (PDT)
In-Reply-To: <1334859465-14352-1-git-send-email-mgreer@animalcreek.com> (Mark
	A. Greer's message of "Thu, 19 Apr 2012 11:17:45 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

"Mark A. Greer" <mgreer@animalcreek.com> writes:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
>
> prcm_setup_regs() blindly accesses IVA bits
> in the PRM and calls omap3_iva_idle() which
> does more IVA related register accesses.
> Only do this if the IVA hardware actually
> exists.
>
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>

Thanks, queuing for v3.5 (branch: for_3.5/cleanup/pm)

Kevin
