From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: RE: [PATCH] OMAP3: hwmod: Adding flag to prevent caching of
 sysconfig register.
Date: Tue, 12 Jan 2010 17:08:38 +0100
Message-ID: <74583B8642AB8841B30447520659FCA9E73BD934@dnce01.ent.ti.com>
References: <1260098674-27143-1-git-send-email-thara@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB031DF2E171@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1001051730230.21295@utopia.booyaka.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB031E1D6B7B@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1001111515080.8534@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45730 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751445Ab0ALQI6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jan 2010 11:08:58 -0500
Content-Class: urn:content-classes:message
In-Reply-To: <alpine.DEB.2.00.1001111515080.8534@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Paul Walmsley' <paul@pwsan.com>, "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Paul,

>
Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920

-----Original Message-----

>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of Paul Walmsley
>Sent: Monday, January 11, 2010 11:21 PM
>To: Gopinath, Thara
>Cc: linux-omap@vger.kernel.org
>Subject: RE: [PATCH] OMAP3: hwmod: Adding flag to prevent caching of
>sysconfig register.
>
>On Thu, 7 Jan 2010, Gopinath, Thara wrote:
>
>> >>-----Original Message-----
>> >>From: Paul Walmsley [mailto:paul@pwsan.com]
>> >>Sent: Wednesday, January 06, 2010 6:02 AM
>> >>To: Gopinath, Thara
>> >>Cc: linux-omap@vger.kernel.org
>> >>Subject: RE: [PATCH] OMAP3: hwmod: Adding flag to prevent caching of
>sysconfig register.
>> >>
>> >>On Wed, 23 Dec 2009, Gopinath, Thara wrote:
>> >>
>> >>> Hi Paul,Kevin.. Does this patch look ok?
>> >>
>> >>Hello Thara,
>> >>
>> >>looking over this patch.  Nice job on the descriptive patch comment;
>> >>it explains the problem well.  What do you think about a slightly
>> >>different approach -- that is, to add a hook to the hwmod code to
>> >>invalidate the cache if the module's powerdomain has lost context?
>>
>> It should be possible but I feel it is a bit cumbersome. Couple of
>> reasons I have.
>> a. Some modules like smartreflex does not have any power domain
>> associated with it.
>
>Aren't the SmartReflex modules in their own powerdomain that changes with
>the CORE powerdomain?

Yes, both SR1 and SR2 are inside a "tactical" power domain, without any SW control. It follows the CORE power domain state.
This is in fact not very well explained in the TRM.

Regards,
Benoit

>
>> b. Invalidating the cache is not needed for all modules even if the
>> module powerdomain context is lost. This is needed only for modules
>> which employ always restore mechanism. All other modules will do
>> explicit context save and restore of its registers
>
>I think we'll want to move all SYSCONFIG manipulation into the hwmod
>layer, once it is in place.
>
>> c. Getting whether power domain context is lost or not is not very
>> straight forward. If I am not mistaken the only way is to keep tab of
>> the powerdomain counters through omap_pm_get_dev_context_loss_count. I
>> might be mistaken.
>
>Yeah.  Getting the hook in will take a little bit of work.
>
>Anyway, for the time being, we can take this patch.  But the other reason
>that this approach doesn't appeal is that this new flag doesn't have
>anything to do with the hardware -- it's just a software workaround for
>device driver code.  Ideally, all of these flags should be generatable
>based on hardware data only.  Flags that pertain to how the device driver
>works belong in a different place.  Perhaps they should still be connected
>to the hwmod code, but they should exist separately from the hwmod data.
>
>Queued for .33-rc (fixes).
>
>
>- Paul
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

