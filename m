From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 12/19] omap: Fix gpio_resume_after_retention
Date: Fri, 12 Mar 2010 16:07:50 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0321EC96B2@dbde02.ent.ti.com>
References: <20100311234404.4500.82861.stgit@baageli.muru.com>
 <20100311234834.4500.12726.stgit@baageli.muru.com>
 <A24693684029E5489D1D202277BE894453FB11F8@dlee02.ent.ti.com>
 <20100311235640.GW2900@atomide.com>
 <A24693684029E5489D1D202277BE894453FB1216@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55036 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757270Ab0CLKiC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Mar 2010 05:38:02 -0500
In-Reply-To: <A24693684029E5489D1D202277BE894453FB1216@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre, Sergio" <saaguirre@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> I normally send my patches with this alias:
> 
> alias gsend='git send-email --smtp-server /usr/bin/msmtp 
> --from "Sergio Aguirre <saaguirre@ti.com>" 
> --envelope-sender="Sergio Aguirre <saaguirre@ti.com>"'
> 
> and then just do:
> 
> gsend --to='linux-omap@vger.kernel.org' 
> patches/forLO_20100311/0001-mypatch.patch
> 
> But somehow the patch ends up (I'm guessing through TI LDAP 
> server) changing that to "Aguirre, Sergio"...
> 
> and also Patchworks seems to continue display my old 
> fullname: "Aguirre Rodriguez, Sergio Alberto"... I guess it's 
> in a static data cache somewhere, maybe?
> 
> Does anyone know how to overcome this kind of scenario, and 
> force what --from param says?

I send patches with an explicit "From: Anand Gadiyar <gadiyar@ti.com>"
line in the content. This seems to work okay.

Can you check if this works for you?

- Anand
