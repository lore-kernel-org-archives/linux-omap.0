From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: Get rid of of_have_populated_dt() usage
Date: Wed, 11 Apr 2012 15:54:28 +0530
Message-ID: <4F855BDC.9070103@ti.com>
References: <1334138593-9692-1-git-send-email-rnayak@ti.com> <20120411100956.GT12064@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:35079 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755974Ab2DKKYg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Apr 2012 06:24:36 -0400
Received: by obbuo13 with SMTP id uo13so1106448obb.6
        for <linux-omap@vger.kernel.org>; Wed, 11 Apr 2012 03:24:35 -0700 (PDT)
In-Reply-To: <20120411100956.GT12064@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: cjb@laptop.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, b-cousson@ti.com, Balaji TK <balajitk@ti.com>, Rob Herring <rob.herring@calxeda.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

On Wednesday 11 April 2012 03:39 PM, Felipe Balbi wrote:
> On Wed, Apr 11, 2012 at 03:33:13PM +0530, Rajendra Nayak wrote:
>> @@ -1564,7 +1564,7 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>   			 * can't be allowed when booting with device
>>   			 * tree.
>>   			 */
>> -			(!of_have_populated_dt())) {
>> +			!host->dev->of_node) {
>
> won't compile
>
why? compiles fine for me.
