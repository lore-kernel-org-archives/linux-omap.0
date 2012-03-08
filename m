From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] few more fixes for v3.3-rc6
Date: Thu, 8 Mar 2012 10:13:46 -0800
Message-ID: <20120308181345.GU12083@atomide.com>
References: <20120308180441.GT12083@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:41633 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862Ab2CHSNu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 13:13:50 -0500
Content-Disposition: inline
In-Reply-To: <20120308180441.GT12083@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Olof,

* Tony Lindgren <tony@atomide.com> [120308 09:34]:
> 
> Vaibhav Hiremath (1):
>       ARM: OMAP: id: Add missing break statement in omap3xxx_check_revision

FYI, this one will cause a minor merge conflict with what's in
arm-soc/for-next, here's how to resolve for reference:

--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@@ -397,7 -342,8 +397,8 @@@ void __init omap3xxx_check_revision(voi
  		break;
  	case 0xb944:
  		omap_revision = AM335X_REV_ES1_0;
 -		*cpu_rev = "1.0";
 +		cpu_rev = "1.0";
+ 		break;
  	case 0xb8f2:
  		switch (rev) {
  		case 0:

Regards,

Tony
