From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 0/4] OMAP3 Beagle: update defconfig to match board file
Date: Wed, 28 May 2008 04:57:44 -0500
Message-ID: <bf8bea47238577986216c6ae6927cbac@felipebalbi.com>
References: <5e088bd90805272245q4ab6c1aue4b4d7d76e025422@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:46469 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbYE1J5q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 May 2008 05:57:46 -0400
In-Reply-To: <5e088bd90805272245q4ab6c1aue4b4d7d76e025422@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: linux-omap@vger.kernel.org



On Tue, 27 May 2008 22:45:03 -0700, "Steve Sakoman" <sakoman@gmail.com>
wrote:
> While preparing a set of patches to add nand support for beagle I
> noticed that the beagle defconfig hasn't kept up with the features
> present in board-omap3beagle.c
> 
> This series of patches updates the defconfig to enable mmc, rtc, usb, and
> fb

All of these could come in only one patch.


-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

