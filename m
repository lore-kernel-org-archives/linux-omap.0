From: Tony Lindgren <tony@atomide.com>
Subject: Re: compilation error on hwmods branch
Date: Wed, 17 Mar 2010 10:03:48 -0700
Message-ID: <20100317170348.GD2900@atomide.com>
References: <87y6isixhc.fsf@deeprootsystems.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C489C494@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56986 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839Ab0CQRCY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Mar 2010 13:02:24 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C489C494@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>

* Varadarajan, Charulatha <charu@ti.com> [100317 08:09]:
> In "origin/pm-wip/hwmods" branch, using "omap_3430sdp_defconfig" or  "omap3_defconfig", results in the following error. 
> Anyone working on this?
> 
> drivers/usb/musb/omap2430.c:261: error: expected identifier or '(' before 'do'
> drivers/usb/musb/omap2430.c:261: error: expected identifier or '(' before 'while'
> drivers/usb/musb/omap2430.c:268: error: expected identifier or '(' before 'do'
> drivers/usb/musb/omap2430.c:268: error: expected identifier or '(' before 'while'
> make[2]: *** [drivers/usb/musb/omap2430.o] Error 1
> make[1]: *** [drivers/usb/musb] Error 2
> make: *** [drivers] Error 2

A fix for that has been already queued via linux-usb. Also in
omap-testing and master branches.

Tony

