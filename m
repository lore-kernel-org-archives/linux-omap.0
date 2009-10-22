From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: RE: [PATCH] OMAP3: DVFS: No sdrc AC timing changes during core dvfs
Date: Thu, 22 Oct 2009 10:58:49 +0200
Message-ID: <74583B8642AB8841B30447520659FCA9DDD9D7E9@dnce01.ent.ti.com>
References: <1254835224-19500-1-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.0910201918230.22645@utopia.booyaka.com>
 <13B9B4C6EF24D648824FF11BE8967162039B3CF012@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55147 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754225AbZJVI6t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Oct 2009 04:58:49 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162039B3CF012@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>, Paul Walmsley <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Richard,

>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of Woodruff, Richard
>
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Paul Walmsley
>> Sent: Tuesday, October 20, 2009 8:21 PM
>
>> > This patch removes the SDRC AC timings changes done during core dvfs.
>> > Updating AC timing CTRL values for SDRC during DVFS is seen to be a
>risk,
>> > while the RFR CTRL value is safe to be updated.
>> >
>> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>>
>> just wanted to let you know, I haven't forgotten about this one. Am
>trying
>> to get an answer from others as to whether AC timing register changes are
>> completely unsafe, in which case your patch is probably the best way to
>> move forward; or whether we can make the changes when no initiators are
>> touching SDRAM.
>
>It is not guaranteed safe to write actim registers on the fly to an active
>part.  It is safe to do RFR as it is buffered and sent out at a safe time.

I think that what Paul is suggesting is to change the ACTIM after ensuring that the DDR is in self-refresh. In that case it is perfectly valid; it is just tricky to ensure that all initiators are in mute before doing that.

Regards,
Benoit

>A few years back before omap3 as part of omap2 lessons learned this issue
>was highlighted but design was not able to change.  Recently implementation
>review at rtl provided the above points.
>
>I'm not aware of anyone seeing a crash but recommendation for safety is to
>not.
>
>Regards,
>Richard W.
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html


Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920



