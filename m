From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 7/7] ARM: OMAP2+: PM: reorganize the powerdomain API in public and private parts
Date: Wed, 12 Sep 2012 17:11:13 -0700
Message-ID: <87r4q6rdcu.fsf@deeprootsystems.com>
References: <1347443732-7411-1-git-send-email-j-pihet@ti.com>
	<1347443732-7411-8-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:46252 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756076Ab2IMALO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Sep 2012 20:11:14 -0400
Received: by obbuo13 with SMTP id uo13so3598670obb.19
        for <linux-omap@vger.kernel.org>; Wed, 12 Sep 2012 17:11:14 -0700 (PDT)
In-Reply-To: <1347443732-7411-8-git-send-email-j-pihet@ti.com> (Jean Pihet's
	message of "Wed, 12 Sep 2012 11:55:32 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Nishanth Menon <nm@ti.com>, Rajendra Nayak <rnayak@ti.com>, Jean Pihet <j-pihet@ti.com>

Jean Pihet <jean.pihet@newoldbits.com> writes:

> The newly added code for functional power states re-defines the
> API to query and control the power domains settings.
>
> The API is now split in the following parts in powerdomain.h:
> - the public or external API, to be used by external PM components:
>   cpuidle, suspend, pmxxxx, clock* etc.
> - the private or internal API, to be used by the low level PM code
>   only: powerdomain*, pm-debug, hwmod, voltage, clockdomainxxxx.
>
> The function omap_set_pwrdm_state is not used anymore and so is
> removed.
>
> No functional change is introduced by this patch.
>
> Note: the API reorganization in a public and private header files
> is not part of this patch, this comes as a subsequent clean-up
> patch series.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

In addition to reorganizing the API, I suspect there are a handful of
out-of-tree hacks, er, users, that will are using the internal state
names, as well as the functions that should now only be internal.

As part of the subsequent cleanup series, it would it make sense to add
a '_' prefix to the internal names as well to catch unintentional use of
internal APIs?

Kevin
