From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: Shouldn't DT preserve pdev name and id to allow platform_match
 to work?
Date: Fri, 5 Aug 2011 14:19:11 +0200
Message-ID: <4E3BDFBF.10903@ti.com>
References: <4E396361.3060307@ti.com> <CACxGe6vg5NTyiDZqqztjtFEfb7si+-=Y7nEy1Y+YMgA5PVXScw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49050 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751979Ab1HEMT3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Aug 2011 08:19:29 -0400
In-Reply-To: <CACxGe6vg5NTyiDZqqztjtFEfb7si+-=Y7nEy1Y+YMgA5PVXScw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nayak, Rajendra" <rnayak@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "G, Manjunath Kondaiah" <manjugk@linaro.org>

On 8/3/2011 6:43 PM, Grant Likely wrote:
> On Wed, Aug 3, 2011 at 4:04 PM, Cousson, Benoit<b-cousson@ti.com>  wrote:
>> Hi Grant,
>>
>> Going further with the usage of OF_DEV_AUXDATA_ID, I realized that this is is not doing what I was expecting. My expectation might be silly, but in order to make platform_match to work without DT matching mechanism, you need to have the driver name in the pdev->name field:
>>
>>         /* fall-back to driver name match */
>>         return (strcmp(pdev->name, drv->name) == 0);
>>
>> Except that the of_device_add function is doing that:
>>         pdev->name = dev_name(&ofdev->dev);
>>         pdev->id = -1;
>
> Yes, I know.  It is written that way on purpose so that it doesn't get
> used to avoid adding a match table to the device driver because
> auxdata is a stop-gap solution.  It is *not* intended to be used long
> term (with one exception for passing platform callbacks when there is
> no other solution).

Outch... You guys are doing your best to make our life harder :-)

> auxdata passes platform_data and overrides the device name when there
> is no way easy way to make the driver work without it.  It handles the
> the current implementation of clocks and regulators which aren't yet
> populated from the device tree.  It will go away when clock&
> regulator bindings are implemented.
>
> By implementing it the way it is, it ensures that no drivers
> inadvertently depends on auxdata, and will thus break when the auxdata
> entries are removed.  Manjunath mentioned that there is a patch that
> allows the id to be set, but it still doesn't set the driver name in a
> way that will allow existing drivers to bind using the old method, and
> that is by design.
>
> I understand what you are asking for, but the DT matching mechanism is
> absolutely required.  Adding it to drivers is certainly not any more
> onerous that maintaining a bunch of auxdata tables for boards.

Fair enough.
Bottom line is that DT is a all inclusive pack, you cannot skip one part 
even if it is not necessarily needed right now :-(

I understand very well the final goal, I was just trying to spread the 
huge effort that DT migration will require to focus first on the stuff 
located in mach-omap, meaning all the board and devices init part.

I was hoping to let the drivers for the moment until the first phase is 
done. Since auxdata was already there to help the migration, I was just 
expecting it to be even more helpful.

> Besides, part of the point of the move to DT is to eliminate device
> and device data tables at the board file level, which is another
> reason why auxdata is a temporary solution.

Again, I got that point, it was not our intent to use that as a final 
solution.

Let's start hacking the OMAP drivers then...

Regards,
Benoit
