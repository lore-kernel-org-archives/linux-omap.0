From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 5/7] crypto: omap-sham: Convert to use pm_runtime API
Date: Thu, 25 Oct 2012 17:34:02 -0700
Message-ID: <87lieunkat.fsf@deeprootsystems.com>
References: <1351046167-4882-1-git-send-email-mgreer@animalcreek.com>
	<1351046167-4882-6-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53115 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753960Ab2JZAda (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 20:33:30 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2387904pbb.19
        for <linux-omap@vger.kernel.org>; Thu, 25 Oct 2012 17:33:30 -0700 (PDT)
In-Reply-To: <1351046167-4882-6-git-send-email-mgreer@animalcreek.com> (Mark
	A. Greer's message of "Tue, 23 Oct 2012 19:36:05 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net, dmitry.kasatkin@intel.com, rmk+kernel@arm.linux.org.uk, paul@pwsan.com

Hi Mark,

"Mark A. Greer" <mgreer@animalcreek.com> writes:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
>
> Convert the omap-sham crypto driver to use the
> pm_runtime API instead of the clk API.
>
> CC: Kevin Hilman <khilman@deeprootsystems.com>
> CC: Paul Walmsley <paul@pwsan.com>
> CC: Dmitry Kasatkin <dmitry.kasatkin@intel.com>
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>

I can't pretend to fully understand this driver, It looks like the
current code is doing a bit more fine-grained clock gating, and leaving
the IP clocked only when needed.

The proposed version does a 'get' in probe and a 'put' in remove, which
means the IP will always be enabled (and thus preventing low-power
states), even when it's not in use.

If that's really needed, it should be thoroughly described in the
changelog, otherwise I suggest doing the runtime PM 'get' and 'put' in
roughtly the same spots as the current clk enable/disable which makes
this a more straight-forward conversion.

Kevin
