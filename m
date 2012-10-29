From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH] ARM: AM33xx: add support for reboot
Date: Mon, 29 Oct 2012 04:34:33 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EBEE8C3@DBDE01.ent.ti.com>
References: <1351448275-23509-1-git-send-email-zonque@gmail.com>
 <508D8537.9010107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42058 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757940Ab2J2Eer convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Oct 2012 00:34:47 -0400
In-Reply-To: <508D8537.9010107@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "arnd@arndb.de" <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, "Nori, Sekhar" <nsekhar@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Oct 29, 2012 at 00:49:19, Daniel Mack wrote:
> [Cc Tony]
> 
> On 28.10.2012 19:17, Daniel Mack wrote:
> > This patch adds the ability to reboot am33xx-based systems.
> 
> Sorry, I lacked to investigate on the attribution here. According to
> "git blame" of a BSP kernel I got these lines from, the original author
> is Afzal Mohammed.
> 
> Afzal, are you planning to resubmit this for mainline? My version can of
> course be disposed then.
> 

This should be on top of Paul's recent changes [1] to save him some rework
headache.
 
Regards,
Vaibhav

[1] http://marc.info/?l=linux-omap&m=135120744528680&w=2

