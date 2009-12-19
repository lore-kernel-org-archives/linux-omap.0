From: Paul Walmsley <paul@pwsan.com>
Subject: RE: OMAP4 clock code needs some modifying now that clockdomains are
 present
Date: Sat, 19 Dec 2009 10:14:34 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912191011030.17907@utopia.booyaka.com>
References: <alpine.DEB.2.00.0912181118100.12561@utopia.booyaka.com> <alpine.DEB.2.00.0912181331010.12561@utopia.booyaka.com> <EAF47CD23C76F840A9E7FCE10091EFAB02BFFDEF40@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59416 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671AbZLSROf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Dec 2009 12:14:35 -0500
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BFFDEF40@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pagare, Abhijit" <abhijitpagare@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sat, 19 Dec 2009, Pagare, Abhijit wrote:

> 	Thanks for the update. I will take care of that, rebase on the 
> suggested queue and send them soon.

Hello Abhijit,

Just to clarify, that branch already contains your patches.  No need to 
rebase or replace your existing patches.  I'd like to see a new patch that 
cleans up those TODOs.


- Paul
