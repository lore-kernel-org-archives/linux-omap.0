From: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Subject: Re: [PATCH v9 01/13] usb: musb: dsps: add phy control logic to glue
Date: Fri, 31 Aug 2012 21:17:27 +0530
Message-ID: <CAAe_U6J7LHUkLDTbjDuHsNcKwPdSpN8RwgkZDLsOA9rdaz1LVQ@mail.gmail.com>
References: <1346411399-23964-1-git-send-email-ravibabu@ti.com>
	<1346411399-23964-2-git-send-email-ravibabu@ti.com>
	<20120831122342.GC24861@arwen.pp.htv.fi>
	<CAAe_U6LaCiEPB9ET26j2xjLtumKzJGu+CtW=fK_02d30Z-3BgQ@mail.gmail.com>
	<20120831131915.GA25341@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:43415 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754225Ab2HaPr3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Aug 2012 11:47:29 -0400
Received: by yenq11 with SMTP id q11so3929036yen.1
        for <linux-omap@vger.kernel.org>; Fri, 31 Aug 2012 08:47:28 -0700 (PDT)
In-Reply-To: <20120831131915.GA25341@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Ravi Babu <ravibabu@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, tony@atomide.com, Benoit Cousson <b-cousson@ti.com>

On Fri, Aug 31, 2012 at 6:49 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Fri, Aug 31, 2012 at 06:51:04PM +0530, ABRAHAM, KISHON VIJAY wrote:
>> Hi,
>>
>> On Fri, Aug 31, 2012 at 5:53 PM, Felipe Balbi <balbi@ti.com> wrote:
>> > Hi,
>> >
>> > On Fri, Aug 31, 2012 at 04:39:47PM +0530, Ravi Babu wrote:
>> >> From: Santhapuri, Damodar <damodar.santhapuri@ti.com>
>> >>
>> >> AM335x uses NOP transceiver driver and need to enable builtin PHY
>> >> by writing into usb_ctrl register available in system control
>> >> module register space. This is being added at musb glue driver
>> >> layer untill a separate system control module driver is available.
>> >>
>> >> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
>> >> Signed-off-by: Santhapuri, Damodar <damodar.santhapuri@ti.com>
>> >> Signed-off-by: Ravi Babu <ravibabu@ti.com>
>> >
>> > Kishon, you were adding a real phy driver for OMAP's internal phy logic
>> > on one of your patches and I believe this will conflict with your
>> > changes, right ?
>>
>> Indeed. My final patch of that series removes some of the functions
>> from omap_phy_internal.c (which was taken care in the phy driver).
>> >
>> > How does this look to you ? Is this at least correct ? I suppose the
>> > correct way would be to actually have the system control module driver
>> > which we have been waiting, right ?
>>
>> Correct. I think once we have the system control module driver in
>> place, we'll have everything wrt control module register writes
>> implemented in correct way.
>
> So $SUBJECT will pretty much be thrown away once we have SCM driver, in
> that case it's best to wait a bit longer and apply this series once SCM
> driver is available and after your series too... you agree ?

Yes. That would be better.

Thanks
Kishon
