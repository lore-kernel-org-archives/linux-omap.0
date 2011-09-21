From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 2/2] OMAP: omap_device: Add a method to build an omap_device from a DT node
Date: Wed, 21 Sep 2011 14:17:37 -0700
Message-ID: <87lith389a.fsf@ti.com>
References: <1316184199-12599-1-git-send-email-b-cousson@ti.com>
	<1316184199-12599-3-git-send-email-b-cousson@ti.com>
	<20110917161314.GV3523@ponder.secretlab.ca> <4E77421C.3000202@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:33067 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751041Ab1IUVRm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Sep 2011 17:17:42 -0400
Received: by mail-yx0-f181.google.com with SMTP id 30so1768794yxk.12
        for <linux-omap@vger.kernel.org>; Wed, 21 Sep 2011 14:17:41 -0700 (PDT)
In-Reply-To: <4E77421C.3000202@ti.com> (Benoit Cousson's message of "Mon, 19
	Sep 2011 15:22:36 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

"Cousson, Benoit" <b-cousson@ti.com> writes:

> On 9/17/2011 6:13 PM, Grant Likely wrote:
>> On Fri, Sep 16, 2011 at 04:43:19PM +0200, Benoit Cousson wrote:

[...]

>>> +}
>>> +
>>> +static int _omap_device_notifier_call(struct notifier_block *nb,
>>> +				      unsigned long event, void *dev)
>>
>> Nit: Why the preceding underscore?  Generally that is only done for
>> 'special' variants of public functions.  ie. for a variant that
>> expects a lock to already be held.
>
> Yeah, the convention in this file is not that strict, and it is used
> for internal static helper function as well.
> I'll let Kevin arbitrate that point :-)

The convention in this file is the leading '_' is used for internal
helper functions.

I'd prefer to keep it that way, and if we decide to change the coding
convention to match a coding convention elsewhere, we should do it all
at the same time.

Kevin
