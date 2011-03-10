From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v5 08/10] OMAP4 : DSS : HDMI: Call to HDMI module init
 to register driver.
Date: Thu, 10 Mar 2011 16:04:53 +0200
Message-ID: <1299765893.2017.198.camel@deskari>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com>
	 <1299753858-12222-2-git-send-email-mythripk@ti.com>
	 <1299753858-12222-3-git-send-email-mythripk@ti.com>
	 <1299753858-12222-4-git-send-email-mythripk@ti.com>
	 <1299753858-12222-5-git-send-email-mythripk@ti.com>
	 <1299753858-12222-6-git-send-email-mythripk@ti.com>
	 <1299753858-12222-7-git-send-email-mythripk@ti.com>
	 <1299753858-12222-8-git-send-email-mythripk@ti.com>
	 <1299753858-12222-9-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40287 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751655Ab1CJOEz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 09:04:55 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2AE4sR2019205
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 08:04:54 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p2AE4sP2028243
	for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 08:04:54 -0600 (CST)
In-Reply-To: <1299753858-12222-9-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2011-03-10 at 04:44 -0600, K, Mythri P wrote:
> calling the platform registration of HDMI driver from core
> during initialization.

Capital letter.

And don't say calling foo, or adding bar, or similar in the patch
description (I've seen this in other patches also). I'm not a master in
English, but I don't think that's proper English =).

Just say "call foo" or "add bar". Or "this patch adds foo".

 Tomi


