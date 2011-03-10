From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v5 00/10] OMAP4 : DSS2 : HDMI support on OMAP4
Date: Thu, 10 Mar 2011 15:44:03 +0200
Message-ID: <1299764643.2017.177.camel@deskari>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39129 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752597Ab1CJNoF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 08:44:05 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2ADi5Vs016597
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 07:44:05 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id p2ADi4nF026004
	for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 07:44:04 -0600 (CST)
In-Reply-To: <1299753858-12222-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2011-03-10 at 04:44 -0600, K, Mythri P wrote:
> Adding HDMI support on OMAP4.
> 
> HDMI is a driver that is similar to the VENC or the DSI driver to support
> HDMI/DVI sink device.
> 
> The current design adheres to the DSS2 architecture.
> 
> It is split into the HDMI DSS driver and HDMI panel driver.

I think this version is good. It works for me, at least =).

Any Panda or Blaze owners reading this want to give this a try?

There are a couple of cosmetic fixes you could still do, I'll email
about those separately. But they are just about comments/descriptions,
you can fix them and email me a tarball for the patches, no need to spam
the mailing list.

 Tomi


