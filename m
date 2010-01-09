From: "Luke-Jr" <luke@dashjr.org>
Subject: Re: problem with n810 boot up
Date: Fri, 8 Jan 2010 20:56:44 -0600
Message-ID: <201001082056.48448.luke@dashjr.org>
References: <200912290152.16357.luke@dashjr.org> <201001070941.05201.luke@dashjr.org> <20100107165502.GS9728@swansys>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from vps2.mechanicalrealm.com ([66.216.20.21]:60634 "EHLO
	zinan.dashjr.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754196Ab0AIC5G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 21:57:06 -0500
Received: from tsuruki.localnet (unknown [IPv6:2002:62b3:1d4c:0:20e:a6ff:fec4:4e5d])
	(Authenticated sender: luke-jr)
	by zinan.dashjr.org (Postfix) with ESMTPSA id 5C465B9C6F1
	for <linux-omap@vger.kernel.org>; Sat,  9 Jan 2010 02:59:04 +0000 (UTC)
In-Reply-To: <20100107165502.GS9728@swansys>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thursday 07 January 2010 10:55:02 am green wrote:
> I would like to run Debian on my N810; have you gotten PM, gps, and
>  internal mmc to work while running Gentoo?

Don't expect GPS to ever work. The proprietary driver depends on a bug fixed 
in 2.6.23 or so, and even ignoring that, is full of bugs. It's a soft-GPS 
(like winmodems are for modems), so I suppose someone who understands GPS 
technical stuff might be able to rewrite it.

If you know anyone who has push with TI, the chipset is the TI GPS5300.

