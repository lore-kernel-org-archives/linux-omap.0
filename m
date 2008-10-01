From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: Soft lockup when disconnecting musb isochronous device.
Date: Wed, 1 Oct 2008 09:45:43 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403DC1A6434@dbde02.ent.ti.com>
References: <e5e6ade50809260951g50c3d55cn71ce7e7a04803184@mail.gmail.com>
 <19F8576C6E063C45BE387C64729E739403DC1A61CA@dbde02.ent.ti.com>
 <723A4899-A764-4476-BA28-118D86985449@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59387 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750698AbYJAEP5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Oct 2008 00:15:57 -0400
In-Reply-To: <723A4899-A764-4476-BA28-118D86985449@student.utwente.nl>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

> it happens when w_scan tries to tune into a specific frequency on a  
> USB DVB-T stick. Any ideas about that one?
> 
> I have applied these patches:

> [PATCH v3] OMAP:MUSB: Corrects urb unlink function path
> usb: musb: fix something
> MUSB high-bandwidth support patch
> MUSB ISO dma fix.

What version are you working at? If it is not the latest version on OMAP
GIT then try syncing with latest drivers/usb/storage/*
I had some issue with a pendrive and it got fixed by taking
latest (v2.6.27 rc3) usb/storage patches.

Regards,
Ajay 
