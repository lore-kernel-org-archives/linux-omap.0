From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 3/4] omap mailbox: remove mbox_configured scheme
Date: Thu, 24 Jun 2010 10:10:38 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4C890B71@dlee03.ent.ti.com>
References: <1277251896-6890-1-git-send-email-ohad@wizery.com>
 <1277251896-6890-3-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45680 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754063Ab0FXPKn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 11:10:43 -0400
In-Reply-To: <1277251896-6890-3-git-send-email-ohad@wizery.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>

Ohad,

> mbox_configured is global and therefore does not support
> concurrent usage of multiple mailbox instances.

-- Why do you say that it doesn't support concurrent usage of multiple mailbox instances ? If you take example of OMAP4, we have 2 mailbox instances, one talking to DSP and other to Ducati and they should be supported concurrently.

If you remove the mbox_configured variable, then the mailbox module would shut down once the first instance calls the omap_mbox_put function.

Thank you,
Best regards,
Hari
