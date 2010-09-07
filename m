From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [PATCH 1/2] OMAP: DSS2: Introduce dss_features files
Date: Tue, 07 Sep 2010 14:08:57 +0300
Message-ID: <1283857737.2363.72.camel@tubuntu.research.nokia.com>
References: <1282826618-24584-1-git-send-email-archit@ti.com>
	 <1282826618-24584-2-git-send-email-archit@ti.com>
	 <1283855584.2363.53.camel@tubuntu.research.nokia.com>
	 <FCCFB4CDC6E5564B9182F639FC356087031162D3AE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:26717 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755743Ab0IGLJ1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Sep 2010 07:09:27 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087031162D3AE@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Taneja, Archit" <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2010-09-07 at 13:05 +0200, ext Taneja, Archit wrote:
> Hi,

> There are 2 functions in the present code:
> omap_dss_get_num_overlays()
> omap_dss_get_num_overlay_managers()
> 
> They look very similar to the dss_feature functions but are required.
> I will need to come up with new names for them to avoid confusion.
> 
> We could probably give a naming like : dss_feat_get_num_mgrs() etc so
> that it doesn't confuse things.

Yes, that sounds good. And the defines/enums could be FEAT_xxx, perhaps?
They are DSS internal defines anyway, so DSS_FEAT_xxx may not be needed,
but it's good to have some common prefix.

 Tomi


