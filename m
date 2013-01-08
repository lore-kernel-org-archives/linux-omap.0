From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH RESEND] ARM: dts: AM33XX: Rename I2C and GPIO nodes
Date: Tue, 8 Jan 2013 17:13:01 +0100
Message-ID: <50EC458D.9000408@ti.com>
References: <1353498737-21174-1-git-send-email-anilkumar@ti.com> <331ABD5ECB02734CA317220B2BBEABC13EAD4863@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38258 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756589Ab3AHQNN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jan 2013 11:13:13 -0500
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EAD4863@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Pantelis Antoniou <panto@antoniou-consulting.com>

Hi Anil,

On 01/02/2013 11:12 AM, AnilKumar, Chimata wrote:
> On Wed, Nov 21, 2012 at 17:22:17, AnilKumar, Chimata wrote:
>> Rename I2C and GPIO nodes according to AM33XX TRM. According to
>> AM33XX TRM device instances are starting from "0" like i2c0, i2c1
>> and i2c3.
>>
>> Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
>> [panto@antoniou-consulting.com: initial patch by pantelis's]
>> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
>> ---
>> Changes from first version:
>> 	- Updated pantelis's patch
>> 	  * Modified based on linux-omap/master
>> 	  * Added GPIO nodes renaming as well
> 
> Hi Tony/Benoit,
> 
> If there are no comments could you please pull this patch?

Yep, it is done.

The patch is available here:
git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.9/dts

Regards,
Benoit

