From: "Gross, Andy" <andy.gross@ti.com>
Subject: RE: [PATCH 2/2] ARM: OMAP2+: Remove dmm device creation
Date: Wed, 20 Mar 2013 06:28:45 +0000
Message-ID: <4025DD7A6AB7F549B52938BC369C2CD9E4E43B@DFLE12.ent.ti.com>
References: <1363754624-5209-1-git-send-email-andy.gross@ti.com>
 <1363754624-5209-3-git-send-email-andy.gross@ti.com>
 <51494F89.4050308@ti.com> <51495441.1000606@ti.com>,<514955AF.6020406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51556 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751020Ab3CTG2t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Mar 2013 02:28:49 -0400
In-Reply-To: <514955AF.6020406@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Taneja, Archit" <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Menon, Nishanth" <nm@ti.com>

Yes ill fix it up and move the doc to the other patch and send a v2


________________________________________
From: Shilimkar, Santosh
Sent: Wednesday, March 20, 2013 1:22 AM
To: Taneja, Archit
Cc: Gross, Andy; linux-omap@vger.kernel.org; Cousson, Benoit; devicetree-discuss@lists.ozlabs.org; Menon, Nishanth
Subject: Re: [PATCH 2/2] ARM: OMAP2+: Remove dmm device creation

On Wednesday 20 March 2013 11:46 AM, Archit Taneja wrote:
> On Wednesday 20 March 2013 11:26 AM, Santosh Shilimkar wrote:
>> On Wednesday 20 March 2013 10:13 AM, Andy Gross wrote:
>>> Remove DMM device creation via the hwmod entry.  The DMM device will
>>> now be enumerated as part of the device tree information for the
>>> processor.
>>>
>>> Signed-off-by: Andy Gross <andy.gross@ti.com>
>>> ---
>> OMAP4 is still not made DT only so I suggest you to hold on for this patch
>> till that happens.
>
> Wouldn't we need to at least prevent building the platform device using omap_device_build() when we are using DT?
>
Yes. I assumed Andy will do that once he decides to keep the
non-dt support :)

Regards,
Santosh

