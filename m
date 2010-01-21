From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH 3/8] OMAP2/3 PM: Adding powerdomain APIs for reading the
 next logic and mem state
Date: Thu, 21 Jan 2010 12:32:58 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB031E3F0BDA@dbde02.ent.ti.com>
References: <1264001442-20078-1-git-send-email-thara@ti.com>
 <1264001442-20078-2-git-send-email-thara@ti.com>
 <1264001442-20078-3-git-send-email-thara@ti.com>
 <1264001442-20078-4-git-send-email-thara@ti.com>
 <alpine.DEB.2.00.1001202308180.24456@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57335 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752886Ab0AUHDE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jan 2010 02:03:04 -0500
In-Reply-To: <alpine.DEB.2.00.1001202308180.24456@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>>-----Original Message-----
>>From: Paul Walmsley [mailto:paul@pwsan.com]
>>Sent: Thursday, January 21, 2010 11:43 AM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org
>>Subject: Re: [PATCH 3/8] OMAP2/3 PM: Adding powerdomain APIs for reading the next logic and mem state
>>
>>Hi Thara,
>>
>>some more comments:
>>
>>On Wed, 20 Jan 2010, Thara Gopinath wrote:
>>
>>> This patch adds APIs pwrdm_read_next_logic_pwrst and
>>
>>Shouldn't this be pwrdm_read_logic_retst(), to match the existing code's
>>pwrdm_set_logic_retst() ?
>>
>>> pwrdm_read_next_mem_pwrst
>>
>>and similarly, shouldn't this be pwrdm_read_next_mem_retst() to match the
>>existing code's pwrdm_read_mem_retst() ?

Hello Paul,

Yes agreed. I just looked at pwrdm_read_next_pwrst and implemented these. Will repost with correct API names.

Regards
Thara
