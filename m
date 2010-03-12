From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 12/19] omap: Fix gpio_resume_after_retention
Date: Fri, 12 Mar 2010 15:19:02 +0200
Message-ID: <20100312131902.GD3802@nokia.com>
References: <20100311234404.4500.82861.stgit@baageli.muru.com>
 <20100311234834.4500.12726.stgit@baageli.muru.com>
 <A24693684029E5489D1D202277BE894453FB11F8@dlee02.ent.ti.com>
 <20100311235640.GW2900@atomide.com>
 <A24693684029E5489D1D202277BE894453FB1216@dlee02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0321EC96B2@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:34763 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932788Ab0CLNUE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Mar 2010 08:20:04 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0321EC96B2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gadiyar, Anand" <gadiyar@ti.com>
Cc: "Aguirre, Sergio" <saaguirre@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Mar 12, 2010 at 11:37:50AM +0100, ext Gadiyar, Anand wrote:
>I send patches with an explicit "From: Anand Gadiyar <gadiyar@ti.com>"
>line in the content. This seems to work okay.
>
>Can you check if this works for you?

$ git config --global sendemail.from "Sergio Aguirre <saaguirre@ti.com>"
$ git send-email --to linux-omap@vger.kernel.org --from saaguirre@ti.com 0001-mypatch.patch

This will forge git to add the From: Sergio Aguirre <saaguirre@ti.com> 
when sending the patches

-- 
balbi
