From: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Subject: OMAP I2C: query on save and restore
Date: Thu, 22 Jan 2009 12:02:15 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A39CE7F6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44859 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754244AbZAVGcb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Jan 2009 01:32:31 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "jouni.hogander@nokia.com" <jouni.hogander@nokia.com>, "Nayak, Rajendra" <rnayak@ti.com>

For i2c-omap.c, on the origin/pm branch, upon save and restore, OMAP_I2C_SYSC_REG is not saved and restored.

Any specific reason, why it is so? Or is it a bug?

TIA.

--
With Regards,
Jagadeesh Bhaskar P
 
----------------------------
Some men see things as they are and say why - I dream things that never were and say why not.
- George Bernard Shaw
----------------------------
