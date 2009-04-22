From: "Christensen, Mikkel" <mlc@ti.com>
Subject: RE: LDP broken in 2.6.30-rc 2
Date: Wed, 22 Apr 2009 22:13:00 +0200
Message-ID: <E49DAF743FB3E9469ED423C0D3DB5F1CA8E5B54B@dnce01.ent.ti.com>
References: <E49DAF743FB3E9469ED423C0D3DB5F1C9E8D7960@dnce01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37660 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751312AbZDVUNI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Apr 2009 16:13:08 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n3MKD3Ct007261
	for <linux-omap@vger.kernel.org>; Wed, 22 Apr 2009 15:13:08 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id n3MKD2bs018768
	for <linux-omap@vger.kernel.org>; Wed, 22 Apr 2009 15:13:02 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep20.itg.ti.com (8.12.11/8.12.11) with ESMTP id n3MKD2OT027207
	for <linux-omap@vger.kernel.org>; Wed, 22 Apr 2009 15:13:02 -0500 (CDT)
In-Reply-To: <E49DAF743FB3E9469ED423C0D3DB5F1C9E8D7960@dnce01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Christensen, Mikkel" <mlc@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


-----Original Message-----
From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Christensen, Mikkel
Sent: Monday, April 20, 2009 3:28 PM
To: linux-omap@vger.kernel.org
Subject: LDP broken in 2.6.30-rc 2


>I cloned master a few days ago and when I boot up the OMAP3 LDP, the board >seem to hang in the "i2c /dev entries driver" dialog and after a minute the >kernel dumps. Have anybody else seen this problem?

 I found that the commit "92f00c2fa10629bad7206cd613d3b3357c8d6a81 - Extra omap code in linux-omap tree" breaks the LDP bootup.

Best regards,
 Mikkel


