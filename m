From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [TMP][PATCH 5/5] OMAP3EVM: Test gpmc-nand
Date: Tue, 27 Mar 2012 05:38:58 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A9317BD76F@DBDE01.ent.ti.com>
References: <1332484630-22181-1-git-send-email-afzal@ti.com>
 <4F70ACB6.5070208@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A9317BD700@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44373 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365Ab2C0FjD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Mar 2012 01:39:03 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A9317BD700@DBDE01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On Tue, Mar 27, 2012 at 10:49:32, Mohammed, Afzal wrote:
> Hi Jon,
> 
> On Mon, Mar 26, 2012 at 23:21:50, Hunter, Jon wrote:
> > I see this is marked as a temp patch, but this is actually needed to 
> > register the device. Actually, we would need to do this for all boards, 
> > right?
> 
> Yes, as NAND support on OMAP3EVM was not in mainline, made it TMP.
> Once GPMC driver interfaces are acceptable, other boards too will
> be modified accordingly.

Forgot to add that this patch was meant for testing and as the way
platforms deal with GPMC may change, this was kept as TMP for now.

Regards
Afzal
