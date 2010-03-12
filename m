From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [PATCH 12/19] omap: Fix gpio_resume_after_retention
Date: Fri, 12 Mar 2010 08:00:12 -0600
Message-ID: <A24693684029E5489D1D202277BE894453FB143B@dlee02.ent.ti.com>
References: <20100311234404.4500.82861.stgit@baageli.muru.com>
 <20100311234834.4500.12726.stgit@baageli.muru.com>
 <A24693684029E5489D1D202277BE894453FB11F8@dlee02.ent.ti.com>
 <20100311235640.GW2900@atomide.com>
 <A24693684029E5489D1D202277BE894453FB1216@dlee02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0321EC96B2@dbde02.ent.ti.com>
 <20100312131902.GD3802@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52874 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757656Ab0CLOA1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Mar 2010 09:00:27 -0500
In-Reply-To: <20100312131902.GD3802@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



From: Felipe Balbi [mailto:felipe.balbi@nokia.com]
Sent: Friday, March 12, 2010 7:19 AM
> On Fri, Mar 12, 2010 at 11:37:50AM +0100, ext Gadiyar, Anand wrote:
> >I send patches with an explicit "From: Anand Gadiyar <gadiyar@ti.com>"
> >line in the content. This seems to work okay.
> >
> >Can you check if this works for you?
> 
> $ git config --global sendemail.from "Sergio Aguirre <saaguirre@ti.com>"
> $ git send-email --to linux-omap@vger.kernel.org --from saaguirre@ti.com
> 0001-mypatch.patch
> 
> This will forge git to add the From: Sergio Aguirre <saaguirre@ti.com>
> when sending the patches

Great!

Thanks, Anand and Felipe. I'll definitely experiment with those 2.

Regards,
Sergio

> 
> --
> balbi
