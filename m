From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 05/20] Move dss platform driver to dss.c
Date: Wed, 25 Aug 2010 11:49:43 +0300
Message-ID: <1282726183.9299.105.camel@tubuntu.research.nokia.com>
References: <1282579089-10487-1-git-send-email-svadivu@ti.com>
	 <1282579089-10487-2-git-send-email-svadivu@ti.com>
	 <1282579089-10487-3-git-send-email-svadivu@ti.com>
	 <1282579089-10487-4-git-send-email-svadivu@ti.com>
	 <1282579089-10487-5-git-send-email-svadivu@ti.com>
	 <1282579089-10487-6-git-send-email-svadivu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62093 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669Ab0HYIty (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Aug 2010 04:49:54 -0400
In-Reply-To: <1282579089-10487-6-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Guruswamy Senthilvadivu <svadivu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "khilman@ti.com" <khilman@ti.com>

On Mon, 2010-08-23 at 17:57 +0200, ext Guruswamy Senthilvadivu wrote:
> From: Senthilvadivu Guruswamy <svadivu@ti.com>
> 
> dsshw_probe and remove functions are moved to dss.c
> To maintain the order of init, through the dsshw_probe, omap_dss_init2
> is made as device_init_call_sync.
> 
> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>


Why is the omap_dsshw_driver moved to dss.c, but the hw_driver for other
blocks stay in core.c?

And generally about dss.c:

There are confusingly two things DSS may refer to: 1) the whole display
subsystem, including DSI/RFBI etc 2) the small main block inside DSS,
meaning the few DSS_* registers.

It would be good to have different names for those, but at the time
being they are both "DSS". In some patch I saw names like "dss_dispc".
Perhaps we could have "dss_dss" there too. Although it looks a bit
confusing too =).

dss.c is meant to handle the DSS_* registers, so it's about case 2.

And so it doesn't contain general DSS stuff, like clock allocation etc.,
those have been in core.c.

I'm not sure if this comment is valid for this patch, but at least
"[PATCH 07/20] Move clock functions from core driver to dss driver"
sounds like dss.c is used like case 1.

 Tomi


