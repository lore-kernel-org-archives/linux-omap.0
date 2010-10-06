From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/4] omap4: pandaboard: machine cleanups
Date: Wed, 06 Oct 2010 15:12:56 -0700
Message-ID: <87eic3gec7.fsf@deeprootsystems.com>
References: <1286399673-912-1-git-send-email-x0132446@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:45061 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759244Ab0JFWM6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Oct 2010 18:12:58 -0400
Received: by pwj5 with SMTP id 5so12025pwj.19
        for <linux-omap@vger.kernel.org>; Wed, 06 Oct 2010 15:12:58 -0700 (PDT)
In-Reply-To: <1286399673-912-1-git-send-email-x0132446@ti.com> (David Anders's
	message of "Wed, 6 Oct 2010 16:14:29 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Anders <x0132446@ti.com>
Cc: linux-omap@vger.kernel.org

David Anders <x0132446@ti.com> writes:

> PandaBoard machine file related cleanups.
>
> David Anders (4):
>   omap4: pandaboard: remove unused hsmmc definition
>   omap4: pandaboard: Fix the init if CONFIG_MMC_OMAP_HS is not set
>   omap4: pandaboard: Adding card detect support for MMC1
>   omap4: pandaboard: enable the ehci port on pandaboard

Hi David,

Thanks for updating.

Note that the LAKML mailing-list address has changed.  Correct address
is

   linux-arm-kernel@lists.infradead.org

Please fixup patch 4 to apply against current l-o master, and drop patch
3 for now so that Kishore can fold it into his, then re-post including
LAKML.

FWIW, I tested patches 1, 2 and 4 (after manual fixup) on my es2.0 panda
and MMC is working, so feel free to add 

Tested-by: Kevin Hilman <khilman@deeprootsystems.com>

to patches 1, 2 and 4.  At least MMC boot will work, and we'll have to
wait for Kishore to get the card detect merged.

Kevin
