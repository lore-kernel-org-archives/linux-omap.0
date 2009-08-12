From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH 2/6] ARM: OMAP4: PM: PRM/CM module offsets for OMAP4
Date: Wed, 12 Aug 2009 11:11:01 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030605036C@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0306050331@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39445 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750940AbZHLFlS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 01:41:18 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0306050331@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "sakari.poussa@nokia.com" <sakari.poussa@nokia.com>

 

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org 
>[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Nayak, Rajendra
>Sent: Wednesday, August 12, 2009 10:39 AM
>To: Paul Walmsley; Shilimkar, Santosh
>Cc: linux-arm-kernel@lists.arm.linux.org.uk; 
>linux-omap@vger.kernel.org; Cousson, Benoit; sakari.poussa@nokia.com
>Subject: RE: [PATCH 2/6] ARM: OMAP4: PM: PRM/CM module offsets 
>for OMAP4
>
>Paul, 
>
>>-----Original Message-----
>>From: Paul Walmsley [mailto:paul@pwsan.com] 
>>Sent: Wednesday, August 12, 2009 10:17 AM
>>To: Shilimkar, Santosh
>>Cc: Nayak, Rajendra; linux-arm-kernel@lists.arm.linux.org.uk; 
>>linux-omap@vger.kernel.org; Cousson, Benoit; sakari.poussa@nokia.com
>>Subject: RE: [PATCH 2/6] ARM: OMAP4: PM: PRM/CM module offsets 
>>for OMAP4
>>
>>Hello Santosh,
>>
>>On Wed, 12 Aug 2009, Shilimkar, Santosh wrote:
>>
>>> > I'd also like to see the full names of the PRCM submodules, e.g.,
>>> > 
>>> > OMAP4430_CM2_RESTORE_CM2_MOD
>>> > 
>>> > rather than just
>>> > 
>>> > OMAP4430_CM2_RESTORE_MOD
>>> 
>>> Not sure what you mean by __full__ name here. You are adding 
>>a redundant CM2 in the name here.
>>
>>Yes, for the above example, it looks pretty redundant, doesn't 
>>it.  But 
>>what about:
>>
>>OMAP4430_PRM_WKUP_CM_MOD 
>
>There are only 2 such instances of these where in WKUP_CM and 
>EMU_CM and
>part of PRM module. There are no such instances in CM1 or CM2.
>To take care of 2 of these we would have 60 odd which would 
>look redundant
>and module names as along as this OMAP4430_PRM_ALWAYS_ON_PRM_MOD.

Just to be clear what I mean..

this is what it would look like with 2 exceptions
#define OMAP4430_PRM_OCP_SOCKET_MOD			0x0000
#define OMAP4430_PRM_CKGEN_MOD				0x0100
#define OMAP4430_PRM_MPU_MOD				0x0300
#define OMAP4430_PRM_DSP_MOD				0x0400
#define OMAP4430_PRM_ABE_MOD				0x0500
#define OMAP4430_PRM_ALWAYS_ON_MOD			0x0600
#define OMAP4430_PRM_CORE_MOD				0x0700
#define OMAP4430_PRM_IVAHD_MOD				0x0F00
#define OMAP4430_PRM_CAM_MOD				0x1000
#define OMAP4430_PRM_DSS_MOD				0x1100
#define OMAP4430_PRM_GFX_MOD				0x1200
#define OMAP4430_PRM_L3INIT_MOD				0x1300
#define OMAP4430_PRM_L4PER_MOD				0x1400
#define OMAP4430_PRM_CEFUSE_MOD				0x1600
#define OMAP4430_PRM_WKUP_MOD				0x1700
#define OMAP4430_PRM_WKUP_CM_MOD			0x1800 /* exception */
#define OMAP4430_PRM_EMU_MOD				0x1900
#define OMAP4430_PRM_EMU_CM_MOD				0x1A00 /* exception */
#define OMAP4430_PRM_DEVICE_MOD				0x1B00
#define OMAP4430_PRM_RESTORE_MOD			0x1E00
#define OMAP4430_PRM_INSTR_MOD				0x1F00

And this with your way of naming..
#define OMAP4430_PRM_OCP_SOCKET_PRM_MOD			0x0000 /* redundant */
#define OMAP4430_PRM_CKGEN_PRM_MOD			0x0100 /* redundant */
#define OMAP4430_PRM_MPU_PRM_MOD			0x0300 /* redundant */
#define OMAP4430_PRM_DSP_PRM_MOD			0x0400 /* redundant */
#define OMAP4430_PRM_ABE_PRM_MOD			0x0500 /* redundant */
#define OMAP4430_PRM_ALWAYS_ON_PRM_MOD			0x0600 /* redundant */
#define OMAP4430_PRM_CORE_PRM_MOD			0x0700 /* redundant */
#define OMAP4430_PRM_IVAHD_PRM_MOD			0x0F00 /* redundant */
#define OMAP4430_PRM_CAM_PRM_MOD			0x1000 /* redundant */
#define OMAP4430_PRM_DSS_PRM_MOD			0x1100 /* redundant */
#define OMAP4430_PRM_GFX_PRM_MOD			0x1200 /* redundant */
#define OMAP4430_PRM_L3INIT_PRM_MOD			0x1300 /* redundant */
#define OMAP4430_PRM_L4PER_PRM_MOD			0x1400 /* redundant */
#define OMAP4430_PRM_CEFUSE_PRM_MOD			0x1600 /* redundant */
#define OMAP4430_PRM_WKUP_PRM_MOD			0x1700 /* redundant */
#define OMAP4430_PRM_WKUP_CM_MOD			0x1800 
#define OMAP4430_PRM_EMU_PRM_MOD			0x1900 /* redundant */
#define OMAP4430_PRM_EMU_CM_MOD				0x1A00 
#define OMAP4430_PRM_DEVICE_PRM_MOD			0x1B00 /* redundant */
#define OMAP4430_PRM_RESTORE_PRM_MOD			0x1E00 /* redundant */
#define OMAP4430_PRM_INSTR_PRM_MOD			0x1F00 /* redundant */

And this is just for the PRM modules, there would be all modules in CM1 and CM2
with redundunt additional CM1/CM2 even though there are no exceptions there.

>
>If its really confusing and hard to remember that these belong 
>to PRM we can always 
>have exceptions in naming, and we have had exceptions in
>3430 as well. There are modules common to 2430/3430 which are 
>named differently
>as well as modules only in ES2 which are named differently.
>
>>
>>As my original message mentioned.
>>
>>Do you still feel that is redundant?
>>
>>
>>- Paul
>>
>>--
>To unsubscribe from this list: send the line "unsubscribe 
>linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>