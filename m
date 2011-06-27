From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [RFC/PATCH 8/9] OMAP: PM CONSTRAINTS: implement the devices
 wake-up latency constraints
Date: Mon, 27 Jun 2011 11:33:45 -0700
Message-ID: <20110627183345.GA6187@google.com>
References: <1308926286-30445-1-git-send-email-j-pihet@ti.com>
 <1308926286-30445-9-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:54483 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753178Ab1F0SeS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jun 2011 14:34:18 -0400
Content-Disposition: inline
In-Reply-To: <1308926286-30445-9-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Fri, Jun 24, 2011 at 04:38:05PM +0200, jean.pihet@newoldbits.com wrote:
...
> +	/* Find the associated omap_device for dev */
> +	od = container_of(pdev, struct omap_device, pdev);
> +	if (!od || (od->hwmods_cnt != 1)) {
> +		pr_err("%s: Error: No unique hwmod for device %s\n",
> +		       __func__, dev_name(pm_qos_req->dev));
> +		return -EINVAL;

Check for !od can be dropped... if there's a check for !pdev needed
can add that, but container_of() won't return NULL for a valid
contained field.


Todd
