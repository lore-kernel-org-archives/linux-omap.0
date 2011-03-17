From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC][PATCH 3/3] OMAP PM: Add Board specific parameters for OMAP Volatge layer
Date: Thu, 17 Mar 2011 16:25:38 -0700
Message-ID: <87mxktqqh9.fsf@ti.com>
References: <1300199622-32500-1-git-send-email-vishwanath.bs@ti.com>
	<1300199622-32500-4-git-send-email-vishwanath.bs@ti.com>
	<AANLkTi=tss2NC569bvxVSVWftDg4kdZmiyyh5JZBZpko@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:53064 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753435Ab1CQXZl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 19:25:41 -0400
Received: by mail-iy0-f180.google.com with SMTP id 40so4432014iyf.11
        for <linux-omap@vger.kernel.org>; Thu, 17 Mar 2011 16:25:41 -0700 (PDT)
In-Reply-To: <AANLkTi=tss2NC569bvxVSVWftDg4kdZmiyyh5JZBZpko@mail.gmail.com>
	(Nishanth Menon's message of "Tue, 15 Mar 2011 21:08:17 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Vishwanath BS <vishwanath.bs@ti.com>, linux-omap@vger.kernel.org

"Menon, Nishanth" <nm@ti.com> writes:

[...]

> my overall suggestion - when I fill in board file params - I should say:
> I use PMIC x, i have oscillator with ramp "y" uSec - the params should
> talk my language as a board developers - I dont want to know indepth
> details of voltage VP/VC registers and what they should contain. it is
> upto voltage layer to translate, add, bit shift or do what ever is
> necessary to take my board and pmic level details to register details.

Completely agree with Nishanth.

See my comments on PATCH 1/3 which say basically the same thing.

Kevin
