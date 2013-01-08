From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH RESEND] ARM: dts: AM33XX: Rename I2C and GPIO nodes
Date: Tue, 08 Jan 2013 10:30:45 +0100
Message-ID: <8738ycaunu.fsf@dell.be.48ers.dk>
References: <1353498737-21174-1-git-send-email-anilkumar@ti.com>
	<331ABD5ECB02734CA317220B2BBEABC13EAD4863@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39724 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799Ab3AHJav (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jan 2013 04:30:51 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so97205bkw.5
        for <linux-omap@vger.kernel.org>; Tue, 08 Jan 2013 01:30:50 -0800 (PST)
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EAD4863@DBDE01.ent.ti.com>
	(Chimata AnilKumar's message of "Wed, 2 Jan 2013 10:12:29 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Pantelis Antoniou <panto@antoniou-consulting.com>

>>>>> "AnilKumar" == AnilKumar, Chimata <anilkumar@ti.com> writes:

 AnilKumar> On Wed, Nov 21, 2012 at 17:22:17, AnilKumar, Chimata wrote:
 >> Rename I2C and GPIO nodes according to AM33XX TRM. According to
 >> AM33XX TRM device instances are starting from "0" like i2c0, i2c1
 >> and i2c3.
 >> 
 >> Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
 >> [panto@antoniou-consulting.com: initial patch by pantelis's]
 >> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
 >> ---
 >> Changes from first version:
 >> - Updated pantelis's patch
 >> * Modified based on linux-omap/master
 >> * Added GPIO nodes renaming as well

 AnilKumar> Hi Tony/Benoit,

 AnilKumar> If there are no comments could you please pull this patch?

Yes, please do.

-- 
Bye, Peter Korsgaard
