From: Tomi Valkeinen <tomi.valkeinen@Nokia.com>
Subject: Re: [PATCH v2] OMAP: DSS2: Replace strncmp() with sysfs_streq() in
 overlay_manager_store()
Date: Mon, 02 Aug 2010 16:26:47 +0300
Message-ID: <1280755607.3436.48.camel@tubuntu.research.nokia.com>
References: <1280754851-17077-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:55004 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753349Ab0HBN0x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Aug 2010 09:26:53 -0400
In-Reply-To: <1280754851-17077-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext archit taneja <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 2010-08-02 at 15:14 +0200, ext archit taneja wrote:
> From: Archit Taneja <archit@ti.com>
> 
> The function overlay_manager_store currently fails if the sysfs input is a
> prefix string of an existing overlay manager name. This occurs because strncmp
> compares the two strings only till the length of the input sysfs string. So a
> sysfs input "lcd" will match manager name "lcd2" which is incorrect behavior.
> 
> The use of sysfs_streq here will prevent this false positive match to occur.
> 
> Signed-off-by: Archit Taneja <archit@ti.com>

Looks good, thanks!

 Tomi


