From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 20/20] OMAPDSS: Taal: remove rotate & mirror support
Date: Mon, 11 Mar 2013 11:51:59 +0530
Message-ID: <513D7807.2010509@ti.com>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com> <1362743515-10152-21-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41104 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122Ab3CKGWm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Mar 2013 02:22:42 -0400
In-Reply-To: <1362743515-10152-21-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

Hi,

On Friday 08 March 2013 05:21 PM, Tomi Valkeinen wrote:
> Taal panel driver has support to set rotation and mirroring. However,
> these features cannot be used without causing tearing, and are never
> used. The code is just extra bloat, so let's remove it.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

<snip>
>   static ssize_t taal_num_errors_show(struct device *dev,
> @@ -1025,10 +973,6 @@ static int taal_power_on(struct omap_dss_device *dssdev)
>   	if (r)
>   		goto err;
>
> -	r = taal_set_addr_mode(td, td->rotate, td->mirror);
> -	if (r)
> -		goto err;
> -

I'm curious if we need to set the address mode(to the default value) at 
least once. It may not be a requirement for Taal, but if that's the 
case, why did we have a set_addr_mode() call in taal_power_on() in the 
first place? Is it because we can prepare rotation and mirroring before 
we enable the panel?

Archit

