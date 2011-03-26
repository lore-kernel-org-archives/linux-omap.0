From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH] OMAP3: l3: fix for "irq 10: nobody cared" message
Date: Fri, 25 Mar 2011 19:44:20 -0500
Message-ID: <AANLkTi=kPVAU5H_mddpKpTBOkr+UVAn-T=kS4iV0phwY@mail.gmail.com>
References: <1301099396-30380-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:55748 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932122Ab1CZAoX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Mar 2011 20:44:23 -0400
Received: by eye27 with SMTP id 27so686905eye.20
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 17:44:20 -0700 (PDT)
In-Reply-To: <1301099396-30380-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, l-o <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>, sricharan <r.sricharan@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>, Benoit Cousson <b-cousson@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

On Fri, Mar 25, 2011 at 7:29 PM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
> If an error occurs in the L3 on any other initiator than MPU,
> the interrupt goes unhandled given that the 'base' register
> was calculated with the initialized err_base value (which

s/err_base/err_source/

> coincidentally points to MPU) and not with the actual source
> of the error.
>
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>

Regards,

Omar
