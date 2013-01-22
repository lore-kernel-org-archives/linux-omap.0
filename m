From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: OMAP baseline test results for v3.8-rc4
Date: Tue, 22 Jan 2013 13:19:33 +0100
Message-ID: <878v7l5s16.fsf@dell.be.48ers.dk>
References: <alpine.DEB.2.00.1301202136290.31667@utopia.booyaka.com>
	<50FD6D8D.6030106@mimc.co.uk> <20130121164510.GA18905@kahuna>
	<f36acfaf128c4844b8f696ea4440e253@DLEE74.ent.ti.com>
	<20130121182419.GE10020@beef> <87boci9str.fsf@dell.be.48ers.dk>
	<alpine.DEB.2.00.1301220213390.25789@utopia.booyaka.com>
	<1358846666.3996.3.camel@coredoba.hi.pengutronix.de>
	<87ham95zdt.fsf@dell.be.48ers.dk>
	<20130122095218.GD2637@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:61998 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917Ab3AVMTi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jan 2013 07:19:38 -0500
Received: by mail-bk0-f47.google.com with SMTP id jc3so401435bkc.6
        for <linux-omap@vger.kernel.org>; Tue, 22 Jan 2013 04:19:37 -0800 (PST)
In-Reply-To: <20130122095218.GD2637@n2100.arm.linux.org.uk> (Russell King's
	message of "Tue, 22 Jan 2013 09:52:18 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jan =?utf-8?Q?L=C3=BCbbe?= <jlu@pengutronix.de>, "Menon, Nishanth" <nm@ti.com>, Matt Porter <mporter@ti.com>, Paul Walmsley <paul@pwsan.com>, Richard Cochran <richardcochran@gmail.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Mark Jackson <mpfj-list@mimc.co.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

>>>>> "Russell" == Russell King <- ARM Linux <linux@arm.linux.org.uk>> writes:

 Russell> Don't rely on that.  Remember, if the compressed image
 Russell> occupies the same location as the decompressed kernel, the
 Russell> decompressor will copy the data to a different location in RAM
 Russell> first - I think at RAM offset + 32K + decompressed kernel
 Russell> size.

Ok, but this is with the exact same kernel image loaded at the same
address for the two cases. The only difference is U-Boot version.

 Russell> So yes, please try the patch in the link above.

I did. No visible difference. Also not with changing the uImage load
address (2M/16M/32M from start of RAM).

-- 
Bye, Peter Korsgaard
