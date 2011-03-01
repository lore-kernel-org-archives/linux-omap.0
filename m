From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 3/8] OMAP4 : DSS2 : HDMI: HDMI driver header file
 addition
Date: Tue, 1 Mar 2011 19:23:26 +0200
Message-ID: <1299000206.2049.43.camel@deskari>
References: <1298988988-28429-1-git-send-email-mythripk@ti.com>
	 <1298988988-28429-4-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54943 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754983Ab1CARX2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Mar 2011 12:23:28 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p21HNRpT031802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 11:23:27 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id p21HNRAC028020
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 11:23:27 -0600 (CST)
In-Reply-To: <1298988988-28429-4-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2011-03-01 at 08:16 -0600, K, Mythri P wrote:
> Adding the hdmi interface driver header file (hdmi.h) to the dss driver.
> Register and timing declaration to be used by the corresponding c file
> is added in this file.
> 
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  drivers/video/omap2/dss/hdmi.h |  597 ++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 597 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/video/omap2/dss/hdmi.h

This file is dss internal header. How will the audio side be handled?
Does the audio driver need something from here? If so, those things
should be somewhere else.

Some or many of the structs/enums in this file are not used currently.
It would make reviewing and understanding the code much easier, if
things would be added only when they are actually used. Can you go
through them and leave only the things that are needed for the current
driver.

 Tomi


