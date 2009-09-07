From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 6/10] omap mailbox: remove unnecessary arg for
	omap_mbox_msg_send
Date: Mon, 7 Sep 2009 21:07:41 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BA89C477@dbde02.ent.ti.com>
References: <20090907150243.GB6538@flint.arm.linux.org.uk>
 <B85A65D85D7EB246BE421B3FB0FBB59301DD6C43EF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44584 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753706AbZIGPhz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Sep 2009 11:37:55 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DD6C43EF@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "C.A, Subramaniam" <subramaniam.ca@ti.com>, Russell King <rmk@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

Subbu,
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of C.A, Subramaniam
> Sent: Monday, September 07, 2009 9:03 PM
> To: Russell King
> Cc: linux-omap@vger.kernel.org; tony@atomide.com; Hiroshi.DOYU@nokia.com;
> Kanigeri, Hari; Gupta, Ramesh
> Subject: RE: [PATCH 6/10] omap mailbox: remove unnecessary arg for
> omap_mbox_msg_send
> 
> Hi Russell,
> 'arg' is used later in Patch 10, as part of the tasklet implementation,
> for writing messages to the mailbox. Should I be removing it in patch 6
> and introduce it only for the tasklet implementation?
> 

 Avoid top posting !!
