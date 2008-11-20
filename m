From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] Fix section mismatch warning.
Date: Thu, 20 Nov 2008 05:41:33 -0800
Message-ID: <200811200541.34166.david-b@pacbell.net>
References: <1227102749-19536-1-git-send-email-premi@ti.com> <200811191626.02717.david-b@pacbell.net> <B85A65D85D7EB246BE421B3FB0FBB59301B6C8C6E5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:22768 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754735AbYKTNlg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Nov 2008 08:41:36 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301B6C8C6E5@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thursday 20 November 2008, Premi, Sanjeev wrote:
> BTW, I could not locate the definition of platform_driver for twl4030
> to verify if probe() is indeed in __devinit.

In this case, drivers/mfd/twl4030-power.c is what will use that
data, and it's called from drivers/mfd/twl4030-core.c ... which
is an I2C client.

I don't know of any cases when it's safe to have I2C drivers
have their probe() use an __init or __devinit annotation.


