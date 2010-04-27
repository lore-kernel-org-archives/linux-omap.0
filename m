From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv3 17/22] OMAP3: PM: Implement latest h/w recommendations for SR and VP registers and SR VP enable disable sequence.
Date: Tue, 27 Apr 2010 12:12:20 -0700
Message-ID: <871ve0iuaz.fsf@deeprootsystems.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:62585 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756042Ab0D0TMc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 15:12:32 -0400
Received: by pwj9 with SMTP id 9so9718779pwj.19
        for <linux-omap@vger.kernel.org>; Tue, 27 Apr 2010 12:12:32 -0700 (PDT)
In-Reply-To: <1271408597-3066-18-git-send-email-thara@ti.com> (Thara Gopinath's message of "Fri\, 16 Apr 2010 14\:33\:12 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch introduces OMAP3 specific values for Smartreflex and
> Voltage processor registers as per the latest TI recommendations.
> This patch adds smartreflex errminlimit and voltage processor
> errorgain into the voltage tables as they vary with different
> voltages. This patch also improves the smartreflex and voltage
> processor enable disable sequences as per the latest recommendations.
>
> These recommendations were first formed based on experimentations
> on N900 platform  and were implemented in the N900 codebase
> base first by Nishanth Menon and Paul Walmsley.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>

Some minor CodingStyle issues.  Please check the multi-line comment
style in this patch.

Kevin
