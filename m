From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH 0/3] Prepare for GPMC driver conversion
Date: Tue, 12 Jun 2012 10:27:53 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E99803F@DBDE01.ent.ti.com>
References: <cover.1339419244.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52474 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751460Ab2FLK2B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jun 2012 06:28:01 -0400
In-Reply-To: <cover.1339419244.git.afzal@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Tony,

On Mon, Jun 11, 2012 at 19:31:01, Mohammed, Afzal wrote:

> Objective of this series is to make things easy for GPMC driver
> conversion series by separating out more things from driver
> conversion series.
> 
> This series,
> 1. Unifies NAND platform initialization functions
> 2. Cleans up OneNAND platform code a little
> 3. Handles additional timings in Kernel
> 
> This series is based on 3.5-rc1 & made on top of
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69501.html
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69881.html


Please let me know your comments on this series.

gpmc driver conversion series [1] is dependent on this.

Regards
Afzal

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69897.html

