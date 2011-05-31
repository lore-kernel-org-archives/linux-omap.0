From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/PATCH 00/13] OMAP2+: PM: isolate PM code in modules
Date: Tue, 31 May 2011 01:02:29 -0700
Message-ID: <20110531080229.GO11352@atomide.com>
References: <1305739950-11695-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:53772 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758008Ab1EaICd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 May 2011 04:02:33 -0400
Content-Disposition: inline
In-Reply-To: <1305739950-11695-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-omap@vger.kernel.org

* jean.pihet@newoldbits.com <jean.pihet@newoldbits.com> [110518 10:28]:
> From: Jean Pihet <j-pihet@ti.com>
> 
> First attempt at isolation of the OMAP2+ PM code
> 
> RFC quality code but successfully tested on board as a proof
> of concept
> 
> 1) provide PM functionality as modules
> 
> To allow for the PM functionality to be built and used as modules a
> clean-up and isolation task first has been performed ('spaghetti
> unwinding') because there are a lot of cross calls between various parts
> of the PM code (core, platform specific, cpuidle ...).

Glad to see this happening! :)
 
> 2) Addition of EXPORT_SYMBOL for functions and variables used by
> the code in PM modules. Lots of (too many?) symbols need to exported
> to the PM modules.

Ideally these would all be Linux generic of course..

Anyways, please also consider what all modules could be moved to
live under drivers/pm or similar. I'd assume a lot of this can
be done in a generic way.

Regards,

Tony
