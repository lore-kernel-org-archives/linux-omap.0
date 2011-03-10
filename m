From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v5 01/10] OMAP4 : DSS2 : Add display type HDMI to DSS2
Date: Thu, 10 Mar 2011 15:48:39 +0200
Message-ID: <1299764919.2017.181.camel@deskari>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com>
	 <1299753858-12222-2-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52913 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752791Ab1CJNsl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 08:48:41 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2ADmeLO000484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 07:48:40 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p2ADmeHo020792
	for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 07:48:40 -0600 (CST)
In-Reply-To: <1299753858-12222-2-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2011-03-10 at 04:44 -0600, K, Mythri P wrote:
> Adding HDMI type in dss_features , overlay and
> the manager so that HDMI type of display will be recognized.
> 
> Signed-off-by: Mythri P K <mythripk@ti.com>

What editor are you using? Your descriptions and comments are often
oddly formatted, like this. The editor should handle things like that
automatically, if it's a decent one.

What it should be is:

Adding HDMI type in dss_features , overlay and the manager so that HDMI
type of display will be recognized.

Well, there's the extra space before the comma, which should also be
fixed.

Generally, split the lines at column, say, 78. And leave a blank line
between paragraphs (not in this case, but elsewhere).

 Tomi


