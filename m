From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [PATCH-Fix] OMAP: Add DSI regulator supply to OMAP3EVM board
 file
Date: Thu, 11 Mar 2010 14:25:18 +0200
Message-ID: <1268310318.28571.103.camel@tubuntu.research.nokia.com>
References: <hvaibhav@ti.com>
	 <1268297717-8062-1-git-send-email-hvaibhav@ti.com>
	 <1268297945.28571.81.camel@tubuntu.research.nokia.com>
	 <19F8576C6E063C45BE387C64729E7394044DD32B51@dbde02.ent.ti.com>
	 <1268299850.28571.92.camel@tubuntu.research.nokia.com>
	 <19F8576C6E063C45BE387C64729E7394044DD32B73@dbde02.ent.ti.com>
	 <1268300631.28571.94.camel@tubuntu.research.nokia.com>
	 <19F8576C6E063C45BE387C64729E7394044DD32B8D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:42561 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693Ab0CKMZg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 07:25:36 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044DD32B8D@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

On Thu, 2010-03-11 at 11:03 +0100, ext Hiremath, Vaibhav wrote:
> > 
> [Hiremath, Vaibhav] Tomi, the above patch has already present in main-line. The patch I am talking about is defconfig update for DSS on both OMAP3EVM and AM3517EVM.
> It happened to be the same commit description at your repository when you split it.

Yes, you are right. I seem to have confused the patch with board changes
and defconf changes. I'll take the defconfig changes to my next pull
request.

I also changed the patch descriptions a bit, so that I won't mix them up
again =).

 Tomi


