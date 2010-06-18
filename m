From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] Add OMAP4 Panda support
Date: Fri, 18 Jun 2010 20:56:50 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032358E7F8@dbde02.ent.ti.com>
References: <7B4574D56E4ADF438756313E9A172A8799C0D3C6@dlee01.ent.ti.com>
 <87y6ecbedt.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37426 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932475Ab0FRP06 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jun 2010 11:26:58 -0400
In-Reply-To: <87y6ecbedt.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Anders, David" <x0132446@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

> IIUC, Panda was built to be compatible with the SDP/Blaze, right?
> 
> If so, is there any reason we can't support both boards from the same
> board file?
> 
> Just add the above MACHINE_START.._END section to board-4430sdp.c to handle
> the both machine IDs, but all the functions could be common.
> 

Nope, the Blaze was built to be compatible with the SDP.

The Panda is the beagleboard-like OMAP4 board.

- Anand
