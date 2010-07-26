From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] omap4: fb: Adds missing display update call when
 panning
Date: Mon, 26 Jul 2010 10:47:15 +0300
Message-ID: <1280130435.2427.3.camel@tubuntu.research.nokia.com>
References: <1279197422-23662-1-git-send-email-mayur@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:38026 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222Ab0GZHrk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Jul 2010 03:47:40 -0400
In-Reply-To: <1279197422-23662-1-git-send-email-mayur@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Mayuresh Janorkar <mayur@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Gustavo Diaz Prado <x0083741@ti.com>

Hi,

On Thu, 2010-07-15 at 14:37 +0200, ext Mayuresh Janorkar wrote:
> From: Gustavo Diaz Prado <x0083741@ti.com>
> 
> Adds the missing display update call when panning, this
> is needed for the DSI panel when the auto-update feature is
> not enabled.

The omapfb driver is not meant to make updates automatically, except on
a few special cases (currently on initialization and when unblanking).
It's the user space's responsibility to update the screen.

The reason for this should be obvious if you think of a use case where
you have, say, all 3 overlays on the LCD, and you want to pan all of
them.

 Tomi


