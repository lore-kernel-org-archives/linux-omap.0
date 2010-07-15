From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH resend v2] omap: 3630: disable TLL SAR on 3630 ES1
Date: Thu, 15 Jul 2010 11:59:30 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0323A2C31D@dbde02.ent.ti.com>
References: <1279114729-8815-1-git-send-email-gadiyar@ti.com>
 <A24693684029E5489D1D202277BE8944566D6595@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53541 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754389Ab0GOG3g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Jul 2010 02:29:36 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o6F6TWlZ013892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 15 Jul 2010 01:29:35 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o6F6TWdm016522
	for <linux-omap@vger.kernel.org>; Thu, 15 Jul 2010 11:59:32 +0530 (IST)
In-Reply-To: <A24693684029E5489D1D202277BE8944566D6595@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre, Sergio" <saaguirre@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Aguirre, Sergio wrote:
> > +/*
> > + * The USBTLL Save-and-Restore mechanism is broken on
> > + * 3430s upto ES3.0 and 3630ES1.0. Hence this feature
> > + * needs to be disabled on these chips.
> > + * Refer: 3430 errata ID i459 and 3630 errata ID i579
> > + */
> >  static struct powerdomain core_3xxx_pre_es3_1_pwrdm = {
> 
> IMHO, The above name (and below ones) should be revisited, since
> its becoming misleading (even before your patch).
> Pre ES3.1 on OMAP3 chips is confusing, since both 3630ES1.0 and
> ES1.1 _are_ "pre ES3.1".
> 
> Not sure if this needs to be taken care before or in this patch..
> 
> What do you think? 

I thought of this, but did not want to disturb the existing name.

This is a one-time bug, and I do think people are aware that ES3.1
is for 3430 only.

If we were to change this, how about "core_3xxxx_no_tll_sar_pwrdm"?
Or does anyone have a better name in mind?

- Anand
