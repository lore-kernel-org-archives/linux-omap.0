From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH v2 0/8] introduce 3630 boards
Date: Wed, 11 Nov 2009 21:02:15 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A705CAD@dbde02.ent.ti.com>
References: <1257893249-15467-1-git-send-email-vikram.pandita@ti.com>
  <5A47E75E594F054BAF48C5E4FC4B92AB030A705CA4@dbde02.ent.ti.com>
 <FCCFB4CDC6E5564B9182F639FC35608702FA5CBAB5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60465 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756348AbZKKPcO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 10:32:14 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nABFWHQR014519
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 09:32:19 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nABFWGI0022645
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 21:02:16 +0530 (IST)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702FA5CBAB5@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> >>
> >> I'm afraid current linux-omap master + these patches does not boot
> >> on my 3630SDP.
> 
> Yes you are right because its missing one patch for the 8250 driver.
> 
> Refer:
> git://dev.omapzoom.org/pub/scm/vikram/omap3.git zoom3
> 
> Patch: HACK: 8250: fix RX fifo access for 3630
> 
> I don't have a good implementation for this patch yet and
> hence I have kept it in my tree as a hack patch for now.
> 
> Once the board files are upstreamed, I plan to look into this 8250 patch.
> 8250 maintainer is not there (alan cox).
> Also the omap-serial patch is being worked in parallel, and does not have this crash issue.
> 
> So there are variables and reasons not to post that patch yet.
> 

Works great with this patch. Thanks.

- Anand
