From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH 08/15] ata: ahci_platform: Manage SATA PHY
Date: Mon, 23 Sep 2013 10:12:51 -0400
Message-ID: <20130923141251.GB13844@htj.dyndns.org>
References: <1379595943-14622-1-git-send-email-rogerq@ti.com>
 <1379595943-14622-9-git-send-email-rogerq@ti.com>
 <523F3567.80303@cogentembedded.com>
 <20130922214859.GC27616@mtj.dyndns.org>
 <52404BD6.9070101@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ye0-f178.google.com ([209.85.213.178]:58370 "EHLO
	mail-ye0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584Ab3IWOMy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Sep 2013 10:12:54 -0400
Content-Disposition: inline
In-Reply-To: <52404BD6.9070101@cogentembedded.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Roger Quadros <rogerq@ti.com>, balbi@ti.com, bcousson@baylibre.com, tony@atomide.com, balajitk@ti.com, kishon@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On Mon, Sep 23, 2013 at 06:10:30PM +0400, Sergei Shtylyov wrote:
> >Unless it's actually likely to cause inclusion loop, I think it's
> >better to include the header than adding explicit declarations.
> 
>    Apparently, tastes differ here. E.g. Greg KH would have also told
> Roger to use forward declaration in such case. :-)

Yes, it's a matter of taste, but, of course mine is better than
Greg's. :P

-- 
tejun
