From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH v3 2/3] DSS2: make VRFB depends on OMAP2,3
Date: Thu, 17 Jun 2010 12:03:59 +0300
Message-ID: <1276765439.12438.80.camel@tubuntu.research.nokia.com>
References: <1276169037-2598-1-git-send-email-svadivu@ti.com>
	 <1276169037-2598-2-git-send-email-svadivu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:42468 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755416Ab0FQJEa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jun 2010 05:04:30 -0400
In-Reply-To: <1276169037-2598-2-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Guruswamy Senthilvadivu <svadivu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "hvaibhav@ti.com" <hvaibhav@ti.com>

Hi,

On Thu, 2010-06-10 at 13:23 +0200, ext Guruswamy Senthilvadivu wrote:
> From: Senthilvadivu Guruswamy <svadivu@ti.com>
> 
> config VRFB should depend on ARCH_OMAP2 or ARCH_OMAP3.
> 
> Changes from v1:
> 	- Addressed multi-omap build issue

Did you mean the VRFB config option to be visible via Kconfig? It
doesn't show there.

Please use the same patch subject as the other dss patches (applies to
other patches in this set also):

OMAP: DSS2: <subsys>: foobar

Don't add changelogs into the patch message.

 Tomi


