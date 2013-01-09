From: Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: Re: [PATCH RESEND] ARM: dts: AM33XX: Rename I2C and GPIO nodes
Date: Wed, 9 Jan 2013 11:41:59 +0200
Message-ID: <E39A9A16-8F1D-4EB0-8947-A33D995CA6B6@antoniou-consulting.com>
References: <1353498737-21174-1-git-send-email-anilkumar@ti.com> <331ABD5ECB02734CA317220B2BBEABC13EAD4863@DBDE01.ent.ti.com> <50EC458D.9000408@ti.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from li42-95.members.linode.com ([209.123.162.95]:56328 "EHLO
	li42-95.members.linode.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756098Ab3AIJmH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Jan 2013 04:42:07 -0500
In-Reply-To: <50EC458D.9000408@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: "AnilKumar, Chimata" <anilkumar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

Hi Benoit,

On Jan 8, 2013, at 6:13 PM, Benoit Cousson wrote:

> Hi Anil,
> 
> On 01/02/2013 11:12 AM, AnilKumar, Chimata wrote:
>> On Wed, Nov 21, 2012 at 17:22:17, AnilKumar, Chimata wrote:
>>> Rename I2C and GPIO nodes according to AM33XX TRM. According to
>>> AM33XX TRM device instances are starting from "0" like i2c0, i2c1
>>> and i2c3.
>>> 
>>> Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
>>> [panto@antoniou-consulting.com: initial patch by pantelis's]
>>> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
>>> ---
>>> Changes from first version:
>>> 	- Updated pantelis's patch
>>> 	  * Modified based on linux-omap/master
>>> 	  * Added GPIO nodes renaming as well
>> 
>> Hi Tony/Benoit,
>> 
>> If there are no comments could you please pull this patch?
> 
> Yep, it is done.
> 
> The patch is available here:
> git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.9/dts
> 
> Regards,
> Benoit
> 

Note that when this lands in mainline, the DT patch bindings for DT overlays
must be converted to the correct form.

Regards

-- Pantelis

