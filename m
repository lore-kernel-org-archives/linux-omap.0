From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC] [PATCH 2/2] DSPBRIDGE: pm: use pm-wip-opp APIs for opp
 list
Date: Thu, 21 Jan 2010 01:59:55 -0600
Message-ID: <4B58097B.7040209@ti.com>
References: <1264025953-4620-1-git-send-email-nm@ti.com> <1264025953-4620-2-git-send-email-nm@ti.com> <1264025953-4620-3-git-send-email-nm@ti.com> <1264025953-4620-4-git-send-email-nm@ti.com> <4B580923.9070801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46585 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752533Ab0AUH77 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jan 2010 02:59:59 -0500
In-Reply-To: <4B580923.9070801@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dasgupta, Romit" <romit@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>

Dasgupta, Romit had written, on 01/21/2010 01:58 AM, the following:
> Menon, Nishanth wrote:
>> Use the PM-WIP-OPP branch apis for generating the opp list for DSP.
>> This allows for scaling accross 3430,3440,3450 and 3630 series.
>>
>> @@ -42,7 +56,90 @@ static struct dspbridge_platform_data dspbridge_pdata __initdata = {
>>  static int get_opp_table(struct dspbridge_platform_data *pdata)
>>  {
> Is get_opp_table used anywhere other than dspbridge_init? I dont see any usage
> outside this now.
it was not meant to be (static).
> 
> Can't you make this __init?
ack. duh to myself.

-- 
Regards,
Nishanth Menon
