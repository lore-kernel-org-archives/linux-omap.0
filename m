From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 00/05] OMAP3: SR: Fixes in Smartreflex driver
Date: Wed, 18 Mar 2009 09:29:19 -0700
Message-ID: <8763i6pzfk.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02FAEDE846@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:41123 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758395AbZCRQ3Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Mar 2009 12:29:25 -0400
Received: by qw-out-2122.google.com with SMTP id 8so117105qwh.37
        for <linux-omap@vger.kernel.org>; Wed, 18 Mar 2009 09:29:23 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02FAEDE846@dbde02.ent.ti.com> (Rajendra Nayak's message of "Wed\, 18 Mar 2009 15\:25\:10 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Nayak, Rajendra" <rnayak@ti.com> writes:

> Hi,
>
> This series fixes a set of defects/issues in Smartreflex driver. SR autocompensation is now
> functional and is validated with these patches on a ES3.1 based SDP with the
> N values in Efuse.
> Patches apply and are validated on the latest pm branch (2.6.28).
>

Hi Rajendra,

Thanks for this series of SR fixes.  I send a couple very minor
comments to a couple of the patches.  Also, this series does not apply
cleanly to pm-2.6.28, I'm not sure why.  Applying manually with
'patch' allows them to apply with "fuzz" suggesting that they were not
generated against the current tree.

Also, while you are in there cleaing up, could you add one more patch
which converts the printk(KERN_* ...) into pr_debug, pr_err, pr_info,
etc.

Thanks,

Kevin

