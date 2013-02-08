From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: OMAP baseline test results for v3.8-rc6
Date: Fri, 08 Feb 2013 15:00:21 +0100
Message-ID: <87ehgqlxca.fsf@dell.be.48ers.dk>
References: <alpine.DEB.2.00.1302062333270.12769@utopia.booyaka.com>
	<20130207083217.GA15462@arwen.pp.htv.fi>
	<79CD15C6BA57404B839C016229A409A83EC06CEA@DBDE01.ent.ti.com>
	<alpine.DEB.2.00.1302081306230.11464@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:59520 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758353Ab3BHOAZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Feb 2013 09:00:25 -0500
Received: by mail-wi0-f172.google.com with SMTP id ez12so877433wid.17
        for <linux-omap@vger.kernel.org>; Fri, 08 Feb 2013 06:00:24 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1302081306230.11464@utopia.booyaka.com> (Paul
	Walmsley's message of "Fri, 8 Feb 2013 13:13:17 +0000 (UTC)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

>>>>> "Paul" == Paul Walmsley <paul@pwsan.com> writes:

Hi,

 Paul> So what I'd like to know is why it doesn't work with >= v3.8-rc1
 Paul> with an appended DTB:

 Paul> http://www.pwsan.com/omap/testlogs/test_v3.8-rc1/20121228031713/boot/am335xbone/am335xbone_log.txt

 Paul> The point is to try to minimize bootloader dependencies.

 Paul> Haven't had the chance to try Felipe's suggestion yet re fdt_high.

That shouldn't matter when using appended dtb.

-- 
Bye, Peter Korsgaard
