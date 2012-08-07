From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH v3] i2c: omap: switch over to autosuspend API
Date: Tue, 7 Aug 2012 14:40:46 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EB30BDA@DBDE01.ent.ti.com>
References: <B5906170F1614E41A8A28DE3B8D121433EB3087D@DBDE01.ent.ti.com>
 <1344343087-8947-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35059 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753571Ab2HGOlC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 10:41:02 -0400
In-Reply-To: <1344343087-8947-1-git-send-email-balbi@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>

On Tue, Aug 07, 2012 at 18:08:07, Balbi, Felipe wrote:
> this helps us reduce unnecessary pm transitions
> in case we have another i2c message starting soon.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>

FWIW, Acked-by: Vaibhav Bedia <vaibhav.bedia@ti.com> 
