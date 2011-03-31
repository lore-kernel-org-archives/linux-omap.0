From: "Avinash.H.M." <avinashhm@ti.com>
Subject: Re: [PATCH] omap: hwmod: add syss reset done flags to omap2, omap3
 hwmods
Date: Thu, 31 Mar 2011 21:52:49 +0530
Message-ID: <20110331162248.GA18957@avinash-laptop>
References: <20110314161609.GA10506@avinash-laptop>
 <alpine.DEB.2.00.1103242336410.21987@utopia.booyaka.com>
 <20110325062534.GA25480@avinash-laptop>
 <20110325072035.GB25480@avinash-laptop>
 <alpine.DEB.2.00.1103251124040.21987@utopia.booyaka.com>
 <20110326113538.GB3668@avinash-laptop>
 <20110331144010.GA18054@avinash-laptop>
 <871v1njpq2.fsf@ti.com>
 <20110331155142.GB18054@avinash-laptop>
 <4D94A413.3000406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:50830 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758660Ab1CaQXH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Mar 2011 12:23:07 -0400
Received: by mail-gx0-f179.google.com with SMTP id 1so1131788gxk.38
        for <linux-omap@vger.kernel.org>; Thu, 31 Mar 2011 09:23:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D94A413.3000406@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>

> >Looks like without this clock, GPIO module isn't resetting even on
> >writing to SYSCONFIG register. Should we provide a seperate reset
> >function for gpio, like the way it was suggested for i2c ?
> 
> No need for that, it is already working like that on OMAP4.
> We have a nice flag that handle that clock during reset.
> 
> 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,

Thanks benoit. I'll use this flag and try resetting GPIO module.

br ,
- avinash

> 
> Regards,
> Benoit
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
