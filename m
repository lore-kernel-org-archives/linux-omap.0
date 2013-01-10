From: Omar Ramirez Luna <omar.ramirez@copitl.com>
Subject: [PATCH 0/5] staging: tidspbridge: for 3.9
Date: Thu, 10 Jan 2013 03:36:57 -0600
Message-ID: <1357810622-1709-1-git-send-email-omar.ramirez@copitl.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:54236 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172Ab3AJJhO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Jan 2013 04:37:14 -0500
Received: by mail-ob0-f181.google.com with SMTP id oi10so320446obb.40
        for <linux-omap@vger.kernel.org>; Thu, 10 Jan 2013 01:37:14 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Chen Gang <gang.chen@asianux.com>, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, Omar Ramirez Luna <omar.ramirez@copitl.com>

Patches for staging-next, fixing comments and suggestions provided
by Chen Gang.

There is an additional scm patch, that removes hardcoded defines
related to direct register handling for SCM, it was dependent on
changes that already made it to mainline.

Omar Ramirez Luna (5):
  staging: tidspbridge: fix potential array out of bounds write
  staging: tidspbridge: fix memory corruption on long string names
  staging: tidspbridge: fix uninitialized variable sym_name
  staging: tidspbridge: use scm functions to set boot address and mode
  staging: tidspbridge: remove unused code to handle iva_img

 drivers/staging/tidspbridge/core/tiomap3430.c      |   34 ++++---------------
 .../staging/tidspbridge/include/dspbridge/proc.h   |    2 -
 drivers/staging/tidspbridge/rmgr/dbdcd.c           |    3 +-
 drivers/staging/tidspbridge/rmgr/drv_interface.c   |    1 -
 drivers/staging/tidspbridge/rmgr/nldr.c            |    6 ++-
 drivers/staging/tidspbridge/rmgr/node.c            |   12 +++---
 drivers/staging/tidspbridge/rmgr/proc.c            |    6 +---
 7 files changed, 19 insertions(+), 45 deletions(-)

-- 
1.7.4.4

