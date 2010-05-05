From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCHv3 18/22] OMAP3: PM: Optional reset of voltage during
 Smartreflex disable.
Date: Wed, 5 May 2010 16:33:18 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0322BA9749@dbde02.ent.ti.com>
References: <1271408597-3066-1-git-send-email-thara@ti.com>
	<1271408597-3066-2-git-send-email-thara@ti.com>
	<1271408597-3066-3-git-send-email-thara@ti.com>
	<1271408597-3066-4-git-send-email-thara@ti.com>
	<1271408597-3066-5-git-send-email-thara@ti.com>
	<1271408597-3066-6-git-send-email-thara@ti.com>
	<1271408597-3066-7-git-send-email-thara@ti.com>
	<1271408597-3066-8-git-send-email-thara@ti.com>
	<1271408597-3066-9-git-send-email-thara@ti.com>
	<1271408597-3066-10-git-send-email-thara@ti.com>
	<1271408597-3066-11-git-send-email-thara@ti.com>
	<1271408597-3066-12-git-send-email-thara@ti.com>
	<1271408597-3066-13-git-send-email-thara@ti.com>
	<1271408597-3066-14-git-send-email-thara@ti.com>
	<1271408597-3066-15-git-send-email-thara@ti.com>
	<1271408597-3066-16-git-send-email-thara@ti.com>
	<1271408597-3066-17-git-send-email-thara@ti.com>
	<1271408597-3066-18-git-send-email-thara@ti.com>
	<1271408597-3066-19-git-send-email-thara@ti.com>
 <87vdbchfmn.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56438 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753024Ab0EELDW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 07:03:22 -0400
In-Reply-To: <87vdbchfmn.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Wednesday, April 28, 2010 12:45 AM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Cousson, Benoit; Sripathy, Vishwanath; Sawant, Anand
>>Subject: Re: [PATCHv3 18/22] OMAP3: PM: Optional reset of voltage during Smartreflex disable.
>>
>>Thara Gopinath <thara@ti.com> writes:
>>
>>> Currently whenever smartreflex is disabled the voltage for the
>>> particular VDD is reset to the non-smartreflex compensated level.
>>> This step is unnecessary during dvfs because anyways in the next couple
>>> of steps before re-enabling smartreflex , the voltage level is changed.
>>>
>>> This patch adds the flexibility in the smartreflex framework for the user
>>> to specify whether or not a voltage reset is required after disabling
>>> of smartrefelx. The smartreflex driver just passes on this info
>>> to the smartreflex class driver, which ultimately takes the
>>> decision to reset the voltage or not.
>>>
>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>
>>I don't think this option should be a decision made for each call to
>>omap_smartreflex_[en|dis]able().  Rather it should be an init time
>>option.
Hello Kevin,

Why do you say this? Anytime we do a disable of smartreflex auto compensation  from user space we need a reset of the voltage is required. During dvfs during smartreflex disable a reset of the voltage is not required. And in both these scenarios it is the same class API that gets called. So the only way for the API to know whether to reset the voltage or not is through this parameter. Also IMHO keeping it parameter based allows more flexibility in the framework for voltage reset. 

Regards
Thara

>>
>>Kevin
