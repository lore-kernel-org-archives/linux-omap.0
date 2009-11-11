From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH v2 0/8] introduce 3630 boards
Date: Wed, 11 Nov 2009 20:58:09 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FA5CBAB5@dbde02.ent.ti.com>
References: <1257893249-15467-1-git-send-email-vikram.pandita@ti.com>
  <5A47E75E594F054BAF48C5E4FC4B92AB030A705CA4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47870 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756217AbZKKP2z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 10:28:55 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id nABFSwkB012044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 09:29:00 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nABFSvri022180
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 20:58:57 +0530 (IST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A705CA4@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


>-----Original Message-----
>From: Gadiyar, Anand
>Sent: Wednesday, November 11, 2009 9:19 AM
>To: Pandita, Vikram; linux-omap@vger.kernel.org
>Subject: RE: [PATCH v2 0/8] introduce 3630 boards
>
>> Vikram,
>>
>> I'm afraid current linux-omap master + these patches does not boot
>> on my 3630SDP.

Yes you are right because its missing one patch for the 8250 driver.

Refer:
git://dev.omapzoom.org/pub/scm/vikram/omap3.git zoom3

Patch: HACK: 8250: fix RX fifo access for 3630

I don't have a good implementation for this patch yet and
hence I have kept it in my tree as a hack patch for now.

Once the board files are upstreamed, I plan to look into this 8250 patch.
8250 maintainer is not there (alan cox).
Also the omap-serial patch is being worked in parallel, and does not have this crash issue.

So there are variables and reasons not to post that patch yet.

>>
>> The bootargs used were:
>> mem=256M console=ttyS0,115200n8 noinitrd root=/dev/nfs rw
>> nfsroot=172.24.162.66:/vol/vol2/swcoe_omapsw_linux1/anand/targ
>> et,nolock,tcp
>> ip=172.24.190.229:172.24.162.66:172.24.188.1:255.255.252.0:myomap::off
>>
