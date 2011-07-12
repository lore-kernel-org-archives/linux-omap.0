From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/4] OMAP: PM: omap_device: update PM domain support for v3.1
Date: Tue, 12 Jul 2011 22:42:13 +0200
Message-ID: <201107122242.13837.rjw@sisk.pl>
References: <1310426969-30306-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:49612 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753934Ab1GLUld (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jul 2011 16:41:33 -0400
In-Reply-To: <1310426969-30306-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@lists.linux-foundation.org

Hi,

On Tuesday, July 12, 2011, Kevin Hilman wrote:
> For v3.1, the PM core has some changes that impact various assumptions
> made (by me) during the design and implementation of the PM domain
> support in the omap_device layer.
> 
> This series is needed to update our PM domain layer to behave properly
> under the new rules of the PM core code which are planned to be merged
> for v3.1 (see recent linux-pm discussions for the gory details.)
> 
> This series is based on the pm-domains branch of Rafael Wysocki's
> suspend-2.6 tree, and also depends on the patch which adds
> pm_runtime_status_suspended() helper function[1].
> 
> Rafael, because of the dependencies on your pm-domains branch (due to
> the pwr_domain -> pm_domain rename), it might be easiest to merge
> these via your tree.   Let me know if that's OK with you.

Yes, it is.  I'm going to apply them to my pm-runtime branch that is based
on pm-domains.

Thanks,
Rafael
