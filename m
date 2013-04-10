From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 4/5] gpio/omap: force restore if context loss is not detectable
Date: Wed, 10 Apr 2013 21:44:53 +0200
Message-ID: <CACRpkdZciGZkWR-qxT96c9pO9UM4fPh_1BUJP9-b1fhjL6-uDg@mail.gmail.com>
References: <1365106576-31816-1-git-send-email-jon-hunter@ti.com>
	<1365106576-31816-5-git-send-email-jon-hunter@ti.com>
	<CACRpkdbeABuFXr0Gt6gRto3Pmo0m88AFn_xKJq14VonGg7Doww@mail.gmail.com>
	<5165C086.5010105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f177.google.com ([209.85.210.177]:58608 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763884Ab3DJTox (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Apr 2013 15:44:53 -0400
Received: by mail-ia0-f177.google.com with SMTP id w33so748770iag.36
        for <linux-omap@vger.kernel.org>; Wed, 10 Apr 2013 12:44:53 -0700 (PDT)
In-Reply-To: <5165C086.5010105@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Wed, Apr 10, 2013 at 9:41 PM, Jon Hunter <jon-hunter@ti.com> wrote:
> On 04/10/2013 02:39 PM, Linus Walleij wrote:
>> On Thu, Apr 4, 2013 at 10:16 PM, Jon Hunter <jon-hunter@ti.com> wrote:
>>
>>> When booting with device-tree the function pointer for detecting context
>>> loss is not populated. Ideally, the pm_runtime framework should be
>>> enhanced to allow a means for reporting context/state loss and we could
>>> avoid populating such function pointers altogether. In the interim until
>>> a generic non-device specific solution is in place, force a restore of
>>> the gpio bank when enabling the gpio controller.
>>>
>>> Adds a new device-tree property for the OMAP GPIO controller to indicate
>>> if the GPIO controller is located in a power-domain that never loses
>>> power and hence will always maintain its logic state.
>>>
>>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>>
>> In this case it'd be really helpful to get an ACK from somebody else.
>> I have no clue whether this thing is doing what it should, and if
>> you were the maintainer I'd apply it but now I'd like to hear from
>> Kevin or Santosh first...
>
> Santosh gave the his ACK for 1-4 (see 0/5) and Kevin added his
> reviewed-by for 1-4 (again see 0/5).

OK all in patch 0 how confusing #-)

All patches applied with Kevin's and Santosh's tags!

Yours,
Linus Walleij
