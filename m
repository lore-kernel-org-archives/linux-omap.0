From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH RESEND] ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue
Date: Wed, 2 May 2012 10:49:40 +0200
Message-ID: <47849F2A-45ED-4881-ACDC-AB761D8CDC61@dominion.thruhere.net>
References: <1332139367-1302-1-git-send-email-keshava_mgowda@ti.com> <CAMrsUdKnL+kSRQXi=X0d1S2fZM5sGpmYqzKnp0TPpjCKVujuaw@mail.gmail.com> <CA+Bv8XZeCTV2kr_d7dEAeEthwD0TkNZPiEV5m-iOFjoX7xur9Q@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:46725 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753334Ab2EBItr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 May 2012 04:49:47 -0400
Received: by wgbdr13 with SMTP id dr13so392121wgb.1
        for <linux-omap@vger.kernel.org>; Wed, 02 May 2012 01:49:46 -0700 (PDT)
In-Reply-To: <CA+Bv8XZeCTV2kr_d7dEAeEthwD0TkNZPiEV5m-iOFjoX7xur9Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: "Raja, Govindraj" <govindraj.raja@ti.com>, Keshava Munegowda <keshava_mgowda@ti.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, balbi@ti.com, sameo@linux.intel.com, parthab@india.ti.com


Op 2 mei 2012, om 10:47 heeft Russ Dill het volgende geschreven:

> [    0.198272]  omap-mcbsp.3: alias fck already exists
> [    3.461212] clock: dpll1_ck failed transition to 'locked'

What's happening in those 3.3 seconds?

regards,

Koen
