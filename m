From: Andreas Ruprecht <rupran@einserver.de>
Subject: Re: [BUG(?)] Kconfig warning when selecting ARCH_OMAP1
Date: Sun, 7 Sep 2014 20:42:54 +0200
Message-ID: <CA+B2V-Jxg_LwenSfjykRCUxmd-_b_y16Wqi0GiXrR6MU5E-UOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:42684 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbaIGSmz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Sep 2014 14:42:55 -0400
Received: by mail-ob0-f181.google.com with SMTP id vb8so10276897obc.12
        for <linux-omap@vger.kernel.org>; Sun, 07 Sep 2014 11:42:54 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

I found the following inconsistency in the Kconfig dependencies for
ARCH_OMAP1 during my research, and as I don't know the exact
requirements for the OMAP configuration (and how the dependencies
could be restructured to get rid of the warning), I figured you might
be able to help me out.

When selecting ARCH_OMAP1 as the system type, Kconfig issues a warning:
"warning: (ARCH_OMAP1) selects ARCH_OMAP which has unmet direct
dependencies (ARCH_MULTI_V6 || ARCH_MULTI_V7)"

When I investigated this further, I found the reason to be as follows:
- ARCH_OMAP1 selects ARCH_OMAP
- ARCH_OMAP depends on ARCH_MULTI_V6 || ARCH_MULTI_V7
- ARCH_MULTI_V{6,7} depend on ARCH_MULTIPLATFORM
- ARCH_MULTIPLATFORM is in the same choice (System Type -> ARM system
type) as ARCH_OMAP1, and thus the two can never be enabled at the same
time.

Might there be an easy way to resolve this inconsistency by
restructuring the Kconfig dependencies?

Regards,
  Andreas
