From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv3 20/22] OMAP3: PM: VP force update method of voltage scaling
Date: Tue, 27 Apr 2010 12:16:59 -0700
Message-ID: <87och4hfis.fsf@deeprootsystems.com>
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
	<1271408597-3066-20-git-send-email-thara@ti.com>
	<1271408597-3066-21-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f204.google.com ([209.85.222.204]:33124 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755931Ab0D0TRC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 15:17:02 -0400
Received: by pzk42 with SMTP id 42so9206859pzk.4
        for <linux-omap@vger.kernel.org>; Tue, 27 Apr 2010 12:17:01 -0700 (PDT)
In-Reply-To: <1271408597-3066-21-git-send-email-thara@ti.com> (Thara Gopinath's message of "Fri\, 16 Apr 2010 14\:33\:15 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch introduces VP force update method of voltage scaling
> and enables it by default. The older method of vc bypass is now
> configuratble through a menu config option. VP force update is the
> hardware recommended method of voltage scaling.

changelog needs update.  It is no longer a menuconfig option.

Kevin

