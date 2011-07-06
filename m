From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v3 12/20] GPIO: OMAP: Use wkup_status for all SoCs
Date: Wed, 6 Jul 2011 10:03:34 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037BD02909@dbde02.ent.ti.com>
References: <1309513634-20971-1-git-send-email-tarun.kanti@ti.com>
	<1309513634-20971-13-git-send-email-tarun.kanti@ti.com>
 <87k4bwkz9y.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58700 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750907Ab1GFEdn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jul 2011 00:33:43 -0400
In-Reply-To: <87k4bwkz9y.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>

[..]
> 
> > On OMAP4 we are not allowed to access wakeup_set/clear registers.
> 
> We are allowed, it is not recommended.  Probably makes sense to
> reference the TRM here.  Basically, these are legacy registers and
> starting with OMAP4, the legacy registers should not be used in
> combination with the updated regsiters.
Yes, I will modify the comments.
--
Tarun
[...]
