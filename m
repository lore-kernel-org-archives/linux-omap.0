From: Tony Lindgren <tony@atomide.com>
Subject: Re: Multiple errors while compiling from master
Date: Mon, 15 Mar 2010 09:03:00 -0700
Message-ID: <20100315160259.GQ2900@atomide.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E623BAC0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52111 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965282Ab0COQBg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Mar 2010 12:01:36 -0400
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E623BAC0@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Premi, Sanjeev <premi@ti.com> [100315 07:30]:
> Hi all,
> 
> While trying to build kernel from master, I encounter many errors (pasted below).
> 
> I believe the reason is missing headers - plat/resource.h and smartreflex.h
> ...but I couldn't find them in the tree.
> 
> premi # ls -l arch/arm/plat-omap/include/plat/res*
> ls: No match.
> premi # ls -l arch/arm/mach-omap2/smart*
> ls: No match.
> premi #
> 
> I am at commit: a842b5f9ce70e1b738eabb4d719860070180ed1c

It should build fine for all omaps now. Maybe do git status and see
if you have something extra applied? Those files are currently
only in Kevin's PM branch.

Regards,

Tony
