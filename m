From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 06/15] ARM: OMAP2+: hwmod: Enable OCMCRAM registration
 in AM33XX
Date: Sat, 3 Nov 2012 21:46:46 +0530
Message-ID: <5095436E.6030206@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com> <1351859566-24818-7-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42250 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752664Ab2KCQQy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 3 Nov 2012 12:16:54 -0400
In-Reply-To: <1351859566-24818-7-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com

On Friday 02 November 2012 06:02 PM, Vaibhav Bedia wrote:
> The hwmod data for OCMCRAM in AM33XX was commented out.
> This data is needed by the power management code, hence
> uncomment the same and register the OCP interface for it.
>
Why this data is needed by PM code ?

Regards
Santosh
