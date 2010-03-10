From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/2] OMAP4: fix temporary hacks that break multi-omap PM
Date: Wed, 10 Mar 2010 13:49:53 -0800
Message-ID: <878w9zetj2.fsf@deeprootsystems.com>
References: <1268241391-26312-1-git-send-email-khilman@deeprootsystems.com>
	<1268241391-26312-3-git-send-email-khilman@deeprootsystems.com>
	<20100310214231.GO2900@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f194.google.com ([209.85.222.194]:36138 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932128Ab0CJVt4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Mar 2010 16:49:56 -0500
Received: by pzk32 with SMTP id 32so312081pzk.4
        for <linux-omap@vger.kernel.org>; Wed, 10 Mar 2010 13:49:56 -0800 (PST)
In-Reply-To: <20100310214231.GO2900@atomide.com> (Tony Lindgren's message of "Wed\, 10 Mar 2010 13\:42\:32 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@deeprootsystems.com> [100310 09:16]:
[...]

>> Note that this is only a short-term fix.  Longer-term, OMAP4
>> needs to create init functions for SDRC and hwmod late-init.
>
> Good to get rid of the temporary hacks. Santosh, maybe grep
> to see if there are other hacks left that can be now removed?

Oops, I shoul've removed  last comment about SDRC init.  I think
the only thing missing is an OMAP4 hwmod init, which is work in
progress with the auto-generated hwmods.

Kevin
