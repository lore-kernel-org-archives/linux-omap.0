From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 4/8] OMAP4 : DSS2 : HDMI: HDMI driver addition in
 the DSS drivers interface
Date: Tue, 1 Mar 2011 19:37:24 +0200
Message-ID: <1299001044.2049.46.camel@deskari>
References: <1298988988-28429-1-git-send-email-mythripk@ti.com>
	 <1298988988-28429-5-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45994 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752175Ab1CARh0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Mar 2011 12:37:26 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p21HbQ8k002805
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 11:37:26 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id p21HbPKA026106
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 11:37:26 -0600 (CST)
In-Reply-To: <1298988988-28429-5-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2011-03-01 at 08:16 -0600, K, Mythri P wrote:
> Adding the hdmi interface driver(hdmi.c) to the dss driver.
> It configures the audio and video portion of HDMI in the
> display header file to be accessed by the panels.

Check once more if the private functions and variables are marked as
static.

The edid variables should be in the hdmi struct. The constant data
arrays should be const.

hdmi_power_on() leaves clocks on in case of error.

 Tomi


