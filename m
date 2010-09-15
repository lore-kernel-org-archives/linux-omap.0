From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [PATCH v3 2/2] OMAP: DSS2: Use dss_features framework on DSS2
 code
Date: Wed, 15 Sep 2010 14:38:58 +0300
Message-ID: <1284550738.2522.143.camel@tubuntu.research.nokia.com>
References: <1284355810-20899-1-git-send-email-archit@ti.com>
	 <1284355810-20899-3-git-send-email-archit@ti.com>
	 <1284539461.2522.117.camel@tubuntu.research.nokia.com>
	 <FCCFB4CDC6E5564B9182F639FC35608703117E9E54@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:60083 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752821Ab0IOLjE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Sep 2010 07:39:04 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608703117E9E54@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Taneja, Archit" <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2010-09-15 at 13:34 +0200, ext Taneja, Archit wrote:
> Hi,
> 
> I was reworking some patches, I saw 2 functions in manager.c:
> 
> dss_mgr_wait_for_go() and dss_mgr_wait_for_go_ovl() both
> define the var "enum omap_channel channel;" but don't use it.
> 
> Is there any reason this is done, or is it just stray code?

Looks like leftovers from some earlier version...

 Tomi


