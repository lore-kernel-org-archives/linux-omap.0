From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v5 00/10] OMAP4 : DSS2 : HDMI support on OMAP4
Date: Wed, 16 Mar 2011 14:02:12 +0530
Message-ID: <1300264332.1917.87.camel@lappyti>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com>
	 <1299769580.2017.235.camel@deskari>
	 <AANLkTik7kaMDMrL_AweAY0dCo7wxaaHkQxTcmMfVB-=f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57362 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885Ab1CPIcV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Mar 2011 04:32:21 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2G8WIse031009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 16 Mar 2011 03:32:20 -0500
In-Reply-To: <AANLkTik7kaMDMrL_AweAY0dCo7wxaaHkQxTcmMfVB-=f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 2011-03-11 at 02:24 -0600, K, Mythri P wrote:
> Hi Tomi,
> 
> On Thu, Mar 10, 2011 at 8:36 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:

> > There is this code in dss.c:
> >
> > #ifdef CONFIG_OMAP2_DSS_VENC
> >        REG_FLD_MOD(DSS_CONTROL, 1, 4, 4);      /* venc dac demen */
> >        REG_FLD_MOD(DSS_CONTROL, 1, 3, 3);      /* venc clock 4x enable */
> >        REG_FLD_MOD(DSS_CONTROL, 0, 2, 2);      /* venc clock mode = normal */
> > #endif
> >
> Regarding this piece of code , although it appears that is should not affect ,
> I think we should move this out of dss_init , if any such change is needed
> we should do that on VENC enable dont you think ?

Either we should enable them on venc_enable, or remove the ifdef. If
there are side effects (which we don't know currently) we should use do
them on venc_enable. If there aren't any side effects, we should just
write the register always.

 Tomi
 

