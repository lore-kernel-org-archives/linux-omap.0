From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP4: sleep: byteswap data for big-endian
Date: Thu, 13 Feb 2014 09:47:25 -0800
Message-ID: <20140213174724.GB27022@atomide.com>
References: <52D404DE.2020806@ti.com>
 <CAArO44samX_uMeC93w4DBbC+yskEmrvVt_i-5VV_seatM56ypw@mail.gmail.com>
 <52D55CE5.1060902@ti.com>
 <CAA3XUr2cnF_rxMYvZfjBx22Sa8YE45o_qUU8GNoerQwhWqxhNQ@mail.gmail.com>
 <CAGo_u6oKpRFnPAWaqr9NTNAJB+m56jiDgBUgvsiZpaQ-3SF2kw@mail.gmail.com>
 <CAA3XUr1_cNuPmMU6Fs6c7Si2So0VFGcLyGJe+tS_R47BVKRXnw@mail.gmail.com>
 <CAGo_u6p7ErrKOMy4Ljg3nehVpd=DOg3XDn6gZ1nrFE_OuOjsWg@mail.gmail.com>
 <52D5A60C.7080800@ti.com>
 <CAGo_u6oGDK5s0SeE6Z7UFM6eYdgoy-E+Tj67+pBWP-wQ3r9=QA@mail.gmail.com>
 <52D5CBC9.5020201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:34171 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752696AbaBMRrn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Feb 2014 12:47:43 -0500
Content-Disposition: inline
In-Reply-To: <52D5CBC9.5020201@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Linaro Kernel <linaro-kernel@lists.linaro.org>, Russell King <linux@arm.linux.org.uk>, Patch Tracking <patches@linaro.org>, Taras Kondratiuk <taras.kondratiuk@linaro.org>, Victor Kamensky <victor.kamensky@linaro.org>, open list <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>, Linaro Networking <linaro-networking@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Santosh Shilimkar <santosh.shilimkar@ti.com> [140114 15:46]:
> On Tuesday 14 January 2014 04:13 PM, Nishanth Menon wrote:
> 
> I haven't looked at patch myself but as you pointed out if it adds
> dead code and makes the code un-readable then probably that something
> we shouldn't merge.

Yeah it seems the assembly parts should be done in more generic
way using macros so the same setup can then be used for other
SoCs. For the other trivial changes, let's try to get them merged
to shrink down the patchset.

Regards,

Tony
