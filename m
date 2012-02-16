From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2] OMAPDSS: HACK: Ensure DSS clock domain gets out of
 idle when HDMI is enabled
Date: Thu, 16 Feb 2012 11:16:42 +0100
Message-ID: <4F3CD78A.9000905@ti.com>
References: <1328854552-30714-1-git-send-email-archit@ti.com>  <1329220678.1845.68.camel@deskari> <4F3A5A5D.4020906@ti.com>  <1329225311.1845.109.camel@deskari> <4F3A61EF.4030803@ti.com>  <4F3A809E.3070508@ti.com> <4F3B9E8F.1020002@ti.com> <4F3BA6A2.60604@ti.com>  <1329310317.1892.60.camel@deskari> <4F3BAD41.1020102@ti.com>  <87fweb98bs.fsf@ti.com> <1329380536.1951.26.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48440 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649Ab2BPKQ7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Feb 2012 05:16:59 -0500
In-Reply-To: <1329380536.1951.26.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-fbdev@vger.kernel.org

On 2/16/2012 9:22 AM, Tomi Valkeinen wrote:
> On Wed, 2012-02-15 at 11:59 -0800, Kevin Hilman wrote:
>> "Cousson, Benoit"<b-cousson@ti.com>  writes:
>
>>> Kevin,
>>>
>>> Do we still need to set the dev.parent to omap_device_parent?
>>
>> Nope.
>>
>>> I guess the default&platform_bus parent is good enough and
>>> potentially the DSS children should be able to overwrite that.
>>
>> Yes, now that we use PM domains, we don't need it.  I just sent a patch
>> to remove omap_device_parent.
>
> But it's still not possible to create a custom parent-child hierarchy
> with omap_devices. Or can I change the parent of a platform_device after
> it has been created? (doesn't sound very clean even if I can)

Nope, it has to be done before platform_device_add.

Thanks to Ohad patch [1] that Tony has just resent, you can use the 
internal omap_device API and thus will be able to change the parent 
before the registration.

Benoit

[1] ARM: OMAP: omap_device: Expose omap_device_{alloc, delete, register}
