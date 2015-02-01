From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: [PATCH 4/4] ARM: dts: Add minimal support for dm8168-evm
Date: Sun, 1 Feb 2015 02:51:22 +0100
Message-ID: <CAALWOA-XVrC84=6Xt04m+QaBhweAcp2HVTH7v=QewtJmQLEaWA@mail.gmail.com>
References: <1421192272-20754-1-git-send-email-tony@atomide.com>
 <1421192272-20754-5-git-send-email-tony@atomide.com> <20150117164709.GS18552@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:58611 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877AbbBABvo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 Jan 2015 20:51:44 -0500
Received: by mail-wi0-f181.google.com with SMTP id fb4so9037350wid.2
        for <linux-omap@vger.kernel.org>; Sat, 31 Jan 2015 17:51:43 -0800 (PST)
In-Reply-To: <20150117164709.GS18552@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>

I just noticed the dm816x.dtsi says:

ocp {
        compatible = "ti,omap3-l3-smx", "simple-bus";

This is incorrect: the DM81xx (and siblings like the AM335x) use
Arteris FlexNOC for the L3 interconnect, same as omap4/5 and vayu, not
SonicsMX. (In general everything on the DM81xx seems to be
omap4-generation)
