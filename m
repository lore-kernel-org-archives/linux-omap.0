From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: What did omap2_disp_get_dss morph into?
Date: Wed, 11 Mar 2009 08:18:38 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940427C51867@dbde02.ent.ti.com>
References: <94550a837462d3a60453cb4c0ba075e3.squirrel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45254 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751257AbZCKCsq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Mar 2009 22:48:46 -0400
In-Reply-To: <94550a837462d3a60453cb4c0ba075e3.squirrel@localhost>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "david.hagood@gmail.com" <david.hagood@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi David,

You must be having "struct omap_display" pointer populated in your driver during probe, you just need to stick with display->enable and
Display->disable function call. These functions in turn enables and disables clocks and save/restores the context.

If you provide some more details about your use case, then I would be able to understand better.

One more thing I just wanted to share, there some bugs we found during our release cycle in save and restore context path which I will be publishing soon. So please let me know if you are facing some issues, I can assist you with this.

Thanks,
Vaibhav Hiremath
Platform Support Products
Texas Instruments Inc
Ph: +91-80-25099927
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of david.hagood@gmail.com
> Sent: Wednesday, March 11, 2009 2:02 AM
> To: linux-omap@vger.kernel.org
> Subject: What did omap2_disp_get_dss morph into?
> 
> I am trying to get the TI accelerated video driver to build against
> the
> current DSS2 kernel image, and I think I am this close || to getting
> it to
> go, but I am missing a pair of functions: omap2_disp_get_dss and
> omap2_disp_put_dss.
> 
> Obviously, they've changed into something else - what did they morph
> into?
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

