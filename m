From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [RFC part1/2 merge v3][PATCH 01/10] OMAP3: serial: Check for
 zero-based physical addr
Date: Tue, 9 Mar 2010 19:39:33 +0200
Message-ID: <20100309173933.GA3866@gandalf>
References: <1268151414-17071-1-git-send-email-saaguirre@ti.com>
 <1268151414-17071-2-git-send-email-saaguirre@ti.com>
 <20100309162115.GJ3851@gandalf>
 <A24693684029E5489D1D202277BE894453E4D72D@dlee02.ent.ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:47024 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578Ab0CIRjX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Mar 2010 12:39:23 -0500
Content-Disposition: inline
In-Reply-To: <A24693684029E5489D1D202277BE894453E4D72D@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre, Sergio" <saaguirre@ti.com>
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

Hi,

On Tue, Mar 09, 2010 at 10:30:08AM -0600, Aguirre, Sergio wrote:
> Ok, I didn't do that, since there are other printks in the same function.
> 
> I can change it here, no problem.
> 
> I guess I can add a separate patch to standardize and change all
> printks to dev_* macros... would that make sense?

sure that would make more sense :-)

> > change printk() + WARN_ON() into:
> > 
> > WARN(1, "%s: can't init uart%d, no clocks available\n",
> > 	koject_name(&dev->kobj), port);
> 
> That looks nicer. Thanks!

np

-- 
balbi
