From: Mark Jackson <mpfj-list@mimc.co.uk>
Subject: Re: AM335x pinctrl error -19 (-ENODEV)
Date: Fri, 01 Mar 2013 13:06:54 +0000
Message-ID: <5130A7EE.9020701@mimc.co.uk>
References: <512E29D9.2020003@mimc.co.uk> <331ABD5ECB02734CA317220B2BBEABC13EB168F4@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mercuryimc.plus.com ([80.229.200.144]:49654 "EHLO
	centos1.newflow.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750758Ab3CANG4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Mar 2013 08:06:56 -0500
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EB168F4@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 01/03/13 05:49, AnilKumar, Chimata wrote:
> On Wed, Feb 27, 2013 at 21:14:25, Mark Jackson wrote:
>> I've specified an I2C bus and all 6 UARTs in the dts file for my custom cpu board, as follows:-
>>
>> 	ocp {
>> 		uart1: serial@44e09000 {
>> 			pinctrl-names = "default";
> 
> Hi Mark,
> 
> Specify "pinctrl-0" property with pinmux/conf node.
> Refer http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/139223.html

Thanks ... I just worked it out myself before your reply.

Regards
Mark J.
