From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PM-SR] [PATCH] OMAP: PM: Remove the usage of vdd id's.
Date: Fri, 25 Jun 2010 11:49:06 -0700
Message-ID: <87aaqjj6cd.fsf@deeprootsystems.com>
References: <1277391768-3361-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:34009 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756716Ab0FYStJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jun 2010 14:49:09 -0400
Received: by pxi8 with SMTP id 8so841199pxi.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Jun 2010 11:49:08 -0700 (PDT)
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
>
> These changes should be part of V2 of the sr/voltage series
> instead of being a separate patch in itself.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>

[...]

> -static struct omap_sr *_sr_lookup(int srid)
> +static struct omap_sr *_sr_lookup(struct omap_volt_domain *volt_domain)
>  {
>  	struct omap_sr *sr_info, *temp_sr_info;
>  
>  	sr_info = NULL;
>  	list_for_each_entry(temp_sr_info, &sr_list, node) {
> -		if (srid == temp_sr_info->srid) {
> +		if (volt_domain == temp_sr_info->volt_domain) {
>  			sr_info = temp_sr_info;
>  			break;

Do we still need an _sr_lookup() function?  Isn't there a single SR
instance per voltage domain?

At init time, the sr_info should be linked to the voltage domain, and
then the code can simply do:

    struct omap_sr *sr_info = voltdm->sr_info;

instead of _sr_lookup.

Kevin
