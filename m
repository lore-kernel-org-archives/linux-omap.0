From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv3 18/22] OMAP3: PM: Optional reset of voltage during Smartreflex disable.
Date: Tue, 27 Apr 2010 12:14:40 -0700
Message-ID: <87vdbchfmn.fsf@deeprootsystems.com>
References: <1271408597-3066-1-git-send-email-thara@ti.com>
	<1271408597-3066-2-git-send-email-thara@ti.com>
	<1271408597-3066-3-git-send-email-thara@ti.com>
	<1271408597-3066-4-git-send-email-thara@ti.com>
	<1271408597-3066-5-git-send-email-thara@ti.com>
	<1271408597-3066-6-git-send-email-thara@ti.com>
	<1271408597-3066-7-git-send-email-thara@ti.com>
	<1271408597-3066-8-git-send-email-thara@ti.com>
	<1271408597-3066-9-git-send-email-thara@ti.com>
	<1271408597-3066-10-git-send-email-thara@ti.com>
	<1271408597-3066-11-git-send-email-thara@ti.com>
	<1271408597-3066-12-git-send-email-thara@ti.com>
	<1271408597-3066-13-git-send-email-thara@ti.com>
	<1271408597-3066-14-git-send-email-thara@ti.com>
	<1271408597-3066-15-git-send-email-thara@ti.com>
	<1271408597-3066-16-git-send-email-thara@ti.com>
	<1271408597-3066-17-git-send-email-thara@ti.com>
	<1271408597-3066-18-git-send-email-thara@ti.com>
	<1271408597-3066-19-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33147 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728Ab0D0TOn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 15:14:43 -0400
Received: by pwj9 with SMTP id 9so9721159pwj.19
        for <linux-omap@vger.kernel.org>; Tue, 27 Apr 2010 12:14:42 -0700 (PDT)
In-Reply-To: <1271408597-3066-19-git-send-email-thara@ti.com> (Thara Gopinath's message of "Fri\, 16 Apr 2010 14\:33\:13 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> Currently whenever smartreflex is disabled the voltage for the
> particular VDD is reset to the non-smartreflex compensated level.
> This step is unnecessary during dvfs because anyways in the next couple
> of steps before re-enabling smartreflex , the voltage level is changed.
>
> This patch adds the flexibility in the smartreflex framework for the user
> to specify whether or not a voltage reset is required after disabling
> of smartrefelx. The smartreflex driver just passes on this info
> to the smartreflex class driver, which ultimately takes the
> decision to reset the voltage or not.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>

I don't think this option should be a decision made for each call to
omap_smartreflex_[en|dis]able().  Rather it should be an init time
option.

Kevin
