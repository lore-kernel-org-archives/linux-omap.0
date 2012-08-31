From: "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v9 01/13] usb: musb: dsps: add phy control logic to glue
Date: Fri, 31 Aug 2012 18:51:04 +0530
Message-ID: <CAAe_U6LaCiEPB9ET26j2xjLtumKzJGu+CtW=fK_02d30Z-3BgQ@mail.gmail.com>
References: <1346411399-23964-1-git-send-email-ravibabu@ti.com>
	<1346411399-23964-2-git-send-email-ravibabu@ti.com>
	<20120831122342.GC24861@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120831122342.GC24861-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Aug 31, 2012 at 5:53 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> Hi,
>
> On Fri, Aug 31, 2012 at 04:39:47PM +0530, Ravi Babu wrote:
>> From: Santhapuri, Damodar <damodar.santhapuri-l0cyMroinI0@public.gmane.org>
>>
>> AM335x uses NOP transceiver driver and need to enable builtin PHY
>> by writing into usb_ctrl register available in system control
>> module register space. This is being added at musb glue driver
>> layer untill a separate system control module driver is available.
>>
>> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Santhapuri, Damodar <damodar.santhapuri-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>
>
> Kishon, you were adding a real phy driver for OMAP's internal phy logic
> on one of your patches and I believe this will conflict with your
> changes, right ?

Indeed. My final patch of that series removes some of the functions
from omap_phy_internal.c (which was taken care in the phy driver).
>
> How does this look to you ? Is this at least correct ? I suppose the
> correct way would be to actually have the system control module driver
> which we have been waiting, right ?

Correct. I think once we have the system control module driver in
place, we'll have everything wrt control module register writes
implemented in correct way.

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
