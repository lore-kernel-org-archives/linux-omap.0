From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [RFC PATCH 0/3] ARM: OMAP2+: Add command line parameter for
 debugSS module control
Date: Tue, 9 Apr 2013 08:11:22 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EC47BD9@DBDE01.ent.ti.com>
References: <hvaibhav@ti.com>
 <1362396957-30113-1-git-send-email-hvaibhav@ti.com>
 <79CD15C6BA57404B839C016229A409A83EC281C1@DBDE01.ent.ti.com>
 <20130408173052.GR10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52029 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755065Ab3DIIL2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Apr 2013 04:11:28 -0400
In-Reply-To: <20130408173052.GR10155@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@linaro.org" <khilman@linaro.org>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Monday, April 08, 2013 11:01 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; khilman@linaro.org; paul@pwsan.com;
> Nayak, Rajendra; linux-arm-kernel@lists.infradead.org
> Subject: Re: [RFC PATCH 0/3] ARM: OMAP2+: Add command line parameter
> for debugSS module control
> 
> * Hiremath, Vaibhav <hvaibhav@ti.com> [130314 04:33]:
> > > From: Hiremath, Vaibhav
> > > This patch introduces new kernel parameter "omap_debugss_en",
> > > which will allow user to control debugSS module enable/disable
> > > part during boot-time.
> > >
> > > In case of OMAP3, the debugSS is part of EMU domain and
> > > is currently controlled by clock tree alone.
> > >
> > > In case of OMAP4, the debugSS is part of EMU domain and
> > > is currently controlled by clock tree, as MODULEMODE_SWCTRL
> > > is not defined for hwmod.
> > >
> > > In case of AM335x, the debugSS is in wakeup domain and is currently
> > > controlled through hwmod alone. Currently we keep it always
> enabled.
> >
> > Any comments or input on this patch series?
> 
> No comments on adding the clocks, but the enabling of
> them should be just a regular device driver.
> 

Thanks for review, on this patch I will add your Reviewed-by line on next version
Of the patch-series.

I have just responded my comment to the other mail on this, and based on
Your response we can conclude. 

Thanks,
Vaibhav
.

