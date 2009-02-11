From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: OMAP [TV] video
Date: Wed, 11 Feb 2009 09:42:52 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403FA81B912@dbde02.ent.ti.com>
References: <4991A5B9.4060308@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59127 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753348AbZBKENJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Feb 2009 23:13:09 -0500
In-Reply-To: <4991A5B9.4060308@mlbassoc.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>, Linux OMAP <linux-omap@vger.kernel.org>



Thanks,
Vaibhav Hiremath
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Gary Thomas
> Sent: Tuesday, February 10, 2009 9:35 PM
> To: Linux OMAP
> Subject: OMAP [TV] video
> 
> I'm trying to get TV [S-Video] working on my 3530 board.
> The settings in the current kernel don't seem to work very
> well on my TV (U.S. NTSC, standard).  Comparing the video
> encoder setup with the suggested values in the manual, I
> find many differences, mostly with respect to the framing
> (signal shaping).
> 
> Questions:
> * Are the settings in the kernel tree known to work [as is]?
> * Why the divergence from the recommended values?
> 
> Any ideas or helpful pointers would be graciously accepted
> 
[Hiremath, Vaibhav] Can you provide some more details like,

Which kernel version are you using?
Are you using DSS2 for TV out?
Which board you are using, (must be EVM)?

> Thanks
> 
> --
> ------------------------------------------------------------
> Gary Thomas                 |  Consulting for the
> MLB Associates              |    Embedded world
> ------------------------------------------------------------
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

