From: Aneesh V <aneesh@ti.com>
Subject: Re: [RFC v2 PATCH 2/3] dt: device tree bindings for TI's EMIF sdram
 controller
Date: Tue, 20 Dec 2011 12:49:29 +0530
Message-ID: <4EF03701.9090809@ti.com>
References: <1324303533-17458-1-git-send-email-aneesh@ti.com>	<1324303533-17458-3-git-send-email-aneesh@ti.com> <CAOesGMidr_orQ60wWrDkSPXZziZ6wuThTixmQj-idkkDjrMG0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:54614 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752047Ab1LTHTm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Dec 2011 02:19:42 -0500
Received: by yenl2 with SMTP id l2so4869091yen.22
        for <linux-omap@vger.kernel.org>; Mon, 19 Dec 2011 23:19:35 -0800 (PST)
In-Reply-To: <CAOesGMidr_orQ60wWrDkSPXZziZ6wuThTixmQj-idkkDjrMG0A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>

On Monday 19 December 2011 10:29 PM, Olof Johansson wrote:
> Oh wait, when I saw 3/3 I realized the following too:
>
> On Mon, Dec 19, 2011 at 6:05 AM, Aneesh V<aneesh@ti.com>  wrote:
>
>> +- phy-type     : string indicating the phy type. Should be one of the
>> +  following:
>> +
>> +  "phy-type-omap4"  : PHY used in OMAP4 family of SoCs
>> +
>> +  "phy-type-dm81xx" : PHY used in DM81XX family of SoCs
>
> No, again please don't define new string properties when a simple
> binary property will do just fine. Just use "phy-type-omap4" or
> "phy-type-dm81xx" as an empty property to indicate what phy is used.
> Or encode as an integer and list the valid values here.

Ok. I just got carried away by readability. Somebody told me that
something like #define will come to device-tree soon. Probably, I can
use that then.

Is binary property suitable in situations like this where "one and only
one" phy-type should be specified by the user?

>
> Every time you add a string to the device tree, the data structure
> grows, not to mention the fact that it adds a lot of string
> comparisons during setup. Please keep that in mind when defining
> bindings.

Understand.

Thanks,
Aneesh
