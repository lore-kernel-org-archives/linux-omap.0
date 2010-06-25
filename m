From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PM-SR] [PATCH] OMAP: PM: Remove the usage of vdd id's.
Date: Fri, 25 Jun 2010 11:25:32 -0700
Message-ID: <87hbkrm0kj.fsf@deeprootsystems.com>
References: <1277391768-3361-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:55196 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754857Ab0FYSZf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jun 2010 14:25:35 -0400
Received: by pxi8 with SMTP id 8so830747pxi.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Jun 2010 11:25:35 -0700 (PDT)
In-Reply-To: <1277391768-3361-1-git-send-email-thara@ti.com> (Thara Gopinath's
	message of "Thu, 24 Jun 2010 20:32:48 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch removes the usage of vdd and sr id alltogether.
> This is achieved by introducing a separte voltage domain per
> VDD and hooking this up with the voltage and smartreflex
> internal info structure. Any user of voltage or smartreflex layer
> should call into omap_volt_domain_get to get the voltage
> domain handle and make use of this to call into the various
> exported API's.

Great, I'm glad to see those gone.

Minor comment on naming:

In current code, we currently have

   struct clockdomain *clkdm;
   struct powerdomain *pwrdm;

so, for consistency, I'd suggest using

   struct voltagedomain *voltdm;

instead of this:

   struct omap_volt_domain *volt_domain;


Also, it looks like your 'struct omap_vdd_info' is the real struct that
represents a voltage domain.

Maybe you're planning this already, but I suggest you get rid of
omap_vdd_info and just move all that stuff into the voltagedomain.
Again, that will probably create a diff with a ton of renames, so this
should just be part of your V2 series.

> These changes should be part of V2 of the sr/voltage series
> instead of being a separate patch in itself.

Agreed.

Kevin

