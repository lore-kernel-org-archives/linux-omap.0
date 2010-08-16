From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [PATCH] omap4: fb: Adds missing display update call when
 panning
Date: Mon, 16 Aug 2010 16:40:34 +0300
Message-ID: <1281966034.2348.9.camel@tubuntu.research.nokia.com>
References: <1279197422-23662-1-git-send-email-mayur@ti.com>
	 <1280130435.2427.3.camel@tubuntu.research.nokia.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02C65D7394@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:60367 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753822Ab0HPNku (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Aug 2010 09:40:50 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C65D7394@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Janorkar, Mayuresh" <mayur@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Diaz Prado, Gustavo" <gusdp@ti.com>

Hi,

On Wed, 2010-08-11 at 12:14 +0200, ext Janorkar, Mayuresh wrote:
> Hi Tomi,
> 
> Could you please provide me info on how to update the screen from user's space incase of manual update mode?

You can use OMAPFB_UPDATE_WINDOW ioctl.

 Tomi


