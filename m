From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH v4 7/9] OMAP4 : DSS : HDMI: Call to HDMI module init to
 register driver.
Date: Wed, 9 Mar 2011 21:24:33 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C1922BC@dbde02.ent.ti.com>
References: <1299671118-20839-1-git-send-email-mythripk@ti.com>
 <1299671118-20839-2-git-send-email-mythripk@ti.com>
 <1299671118-20839-3-git-send-email-mythripk@ti.com>
 <1299671118-20839-4-git-send-email-mythripk@ti.com>
 <1299671118-20839-5-git-send-email-mythripk@ti.com>
 <1299671118-20839-6-git-send-email-mythripk@ti.com>
 <1299671118-20839-7-git-send-email-mythripk@ti.com>
 <1299671118-20839-8-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39569 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228Ab1CIPyo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Mar 2011 10:54:44 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p29FsddI021387
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 9 Mar 2011 09:54:41 -0600
In-Reply-To: <1299671118-20839-8-git-send-email-mythripk@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of K, Mythri P
> Sent: Wednesday, March 09, 2011 5:15 PM
> To: linux-omap@vger.kernel.org; Valkeinen, Tomi
> Cc: K, Mythri P
> Subject: [PATCH v4 7/9] OMAP4 : DSS : HDMI: Call to HDMI module init to
> register driver.
> 
> calling the platform registration of HDMI driver from core
> during initialization.

[sp] Contrary to the subject, patch adds calls for both init and uninit
     functions.

     Shouldn't this be included in same patch where init and uninit are
     being defined?

[snip]...[snip]
