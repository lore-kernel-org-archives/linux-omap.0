From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: patch "phy: Add a driver for dm816x USB PHY" added to linux-phy tree
Date: Thu, 26 Mar 2015 08:01:24 +0100
Message-ID: <CAALWOA9ZHM6S+7WUffu0LF=9=fEO+PxfERpu=D9JpAbKSo1yNA@mail.gmail.com>
References: <20150325233606.GA7549@a0393678ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34474 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbbCZHBq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Mar 2015 03:01:46 -0400
Received: by obbgg8 with SMTP id gg8so38599078obb.1
        for <linux-omap@vger.kernel.org>; Thu, 26 Mar 2015 00:01:45 -0700 (PDT)
In-Reply-To: <20150325233606.GA7549@a0393678ub>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Brian Hutchinson <b.hutchman@gmail.com>, Bin Liu <binmlist@gmail.com>, pebolle@tiscali.nl, rusty@rustcorp.com.au, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 26 March 2015 at 00:36, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> Let me know if you find any problems with this patch.

I spotted a minor issue in drivers/phy/Kconfig:

> +         Enable this for dm81xx USB to work.

This should say dm816x instead.

Matthijs
