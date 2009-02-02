From: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Subject: OMAP: MMC not working on 3430SDP
Date: Tue, 3 Feb 2009 01:01:32 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A3D45333@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53815 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753169AbZBBTbr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Feb 2009 14:31:47 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,
  When using the latest Linux Omap code base, MMC functionality is broken. MMC card insertion is not giving interrupts. Also at proc/interrupts, where mmc interrupt should have been, the entry says:
"Err:          0"

--
With Regards,
Jagadeesh Bhaskar P
 
----------------------------
Some men see things as they are and say why - I dream things that never were and say why not.
- George Bernard Shaw
----------------------------

