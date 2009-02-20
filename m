From: Imre Deak <imre.deak@nokia.com>
Subject: Re: OMAP3: PM : Timer to turn LCD off
Date: Fri, 20 Feb 2009 15:38:48 +0200
Message-ID: <20090220133848.GI14315@localhost>
References: <B85A65D85D7EB246BE421B3FB0FBB59301C74A6B3D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:16762 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131AbZBTNnE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Feb 2009 08:43:04 -0500
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301C74A6B3D@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Feb 20, 2009 at 02:24:50PM +0100, ext Premi, Sanjeev wrote:
> While testing cpuidle (from Kevin's PM beanch) with default configuration for OMAP3EVM, the c-state never transitions from C0.
> 
> Even compiling with minimal drivers did not help. "fck_core1" continues to be active.
> Also, the LCD continues to be powered on... Despite compiling out V4L and FB drivers.
> 
> A simple way to turn LCD off would be to implement an inactivity timer. (e.g. serial.c on the pm branch)

Blanking seems to me more of a user space policy. You could turn off the
LCD backlight from the board file if the FB driver is not configured.

--Imre

> 
> The question is - where should this timer be implemented?
> - As part of the backlight driver?
>   OR
> - As part of the fb driver?
>   OR
> - Should it be tied to the board initialization?
> 
> Best regards,
> Sanjeev
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
