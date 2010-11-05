From: Arno Steffen <arno.steffen@googlemail.com>
Subject: OMAP3 Feature list buggy
Date: Fri, 5 Nov 2010 16:08:13 +0100
Message-ID: <AANLkTingmCrQGX9RQpYy0vgSbgLt+F6exgbnsMP0CuXY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55444 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451Ab0KEPIO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 11:08:14 -0400
Received: by iwn41 with SMTP id 41so1005543iwn.19
        for <linux-omap@vger.kernel.org>; Fri, 05 Nov 2010 08:08:14 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

There is a copy/paste bug in arch/arm/plat-omaop/include/control:

Please replace:

#define OMAP3_IVA_MASK			(1 << OMAP3_SGX_SHIFT)

by:

#define OMAP3_IVA_MASK			(1 << OMAP3_IVA_SHIFT)

Best regards
Arno
