From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 4/5] gpio/omap: force restore if context loss is not detectable
Date: Wed, 10 Apr 2013 14:50:22 -0500
Message-ID: <5165C27E.1060704@ti.com>
References: <1365106576-31816-1-git-send-email-jon-hunter@ti.com> <1365106576-31816-5-git-send-email-jon-hunter@ti.com> <CACRpkdbeABuFXr0Gt6gRto3Pmo0m88AFn_xKJq14VonGg7Doww@mail.gmail.com> <5165C086.5010105@ti.com> <CACRpkdZciGZkWR-qxT96c9pO9UM4fPh_1BUJP9-b1fhjL6-uDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39862 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932945Ab3DJTuc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Apr 2013 15:50:32 -0400
In-Reply-To: <CACRpkdZciGZkWR-qxT96c9pO9UM4fPh_1BUJP9-b1fhjL6-uDg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 04/10/2013 02:44 PM, Linus Walleij wrote:
> On Wed, Apr 10, 2013 at 9:41 PM, Jon Hunter <jon-hunter@ti.com> wrote:
>> On 04/10/2013 02:39 PM, Linus Walleij wrote:
>>> On Thu, Apr 4, 2013 at 10:16 PM, Jon Hunter <jon-hunter@ti.com> wrote:
>>>
>>>> When booting with device-tree the function pointer for detecting context
>>>> loss is not populated. Ideally, the pm_runtime framework should be
>>>> enhanced to allow a means for reporting context/state loss and we could
>>>> avoid populating such function pointers altogether. In the interim until
>>>> a generic non-device specific solution is in place, force a restore of
>>>> the gpio bank when enabling the gpio controller.
>>>>
>>>> Adds a new device-tree property for the OMAP GPIO controller to indicate
>>>> if the GPIO controller is located in a power-domain that never loses
>>>> power and hence will always maintain its logic state.
>>>>
>>>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>>>
>>> In this case it'd be really helpful to get an ACK from somebody else.
>>> I have no clue whether this thing is doing what it should, and if
>>> you were the maintainer I'd apply it but now I'd like to hear from
>>> Kevin or Santosh first...
>>
>> Santosh gave the his ACK for 1-4 (see 0/5) and Kevin added his
>> reviewed-by for 1-4 (again see 0/5).
> 
> OK all in patch 0 how confusing #-)
> 
> All patches applied with Kevin's and Santosh's tags!

Thanks. Sorry for the confusion!

By the way, I am hoping you only took 1-4, per the cover-letter I was
planning to have Benoit take 5 through his DT branch as there could be
conflicts if you merge this with Benoit's branch. Again sorry if this is
even more confusing ;-)

Cheers
Jon
