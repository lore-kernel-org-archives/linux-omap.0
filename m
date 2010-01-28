From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: RE: [PATCH] omap3: pm: cpufreq: populate l3 opp1 again
Date: Thu, 28 Jan 2010 14:47:54 +0100
Message-ID: <74583B8642AB8841B30447520659FCA9E76853B4@dnce01.ent.ti.com>
References: <1264657260-12310-1-git-send-email-nm@ti.com>
 <4B6134EB.8040202@ti.com>
 <74583B8642AB8841B30447520659FCA9E768536D@dnce01.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E22B41EC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58190 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932208Ab0A1Nsa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jan 2010 08:48:30 -0500
Content-Class: urn:content-classes:message
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E22B41EC@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dasgupta, Romit" <romit@ti.com>, "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Andrew Murray <amurray@mpc-data.co.uk>, Kevin Hilman <khilman@deeprootsystems.com>

>From: Dasgupta, Romit
>Sent: Thursday, January 28, 2010 2:43 PM
>To: Cousson, Benoit; Menon, Nishanth
>Cc: linux-omap; Andrew Murray; Kevin Hilman
>Subject: RE: [PATCH] omap3: pm: cpufreq: populate l3 opp1 again
>
>> >IMHO the best way to unconfuse readers is to remove the entry.
>>
>> The confusion is due to a mismatch between public TRM/white paper and
>> current code, so maybe a simple comment on top of the
>> omap34xx_l3_rate_table will be enough.
>>
>But why do we want to keep an OPP that will never be used?

I don't want to keep it. I just want to document it in order to explain why the code is not aligned with the public doc.

Andrew did ask the question so the answer might be useful for others as well, hence a small comment on top of the CORE OPP list.

Benoit

Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920



