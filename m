From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: DSS2 on 36xx with 2.6.34-rc6
Date: Mon, 10 May 2010 09:42:42 -0700
Message-ID: <AANLkTilqVb-gc6TEyuS3pKuDEIzSJ9X6oRO-GR0YRAKJ@mail.gmail.com>
References: <AANLkTiljBOjnB4QZ6Df2IRu3Tw79rIZaGX3pkZ3X91cB@mail.gmail.com>
	 <19F8576C6E063C45BE387C64729E7394044E4049C6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64939 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754252Ab0EJQmq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 12:42:46 -0400
Received: by vws17 with SMTP id 17so239220vws.19
        for <linux-omap@vger.kernel.org>; Mon, 10 May 2010 09:42:45 -0700 (PDT)
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044E4049C6@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, May 10, 2010 at 9:24 AM, Hiremath, Vaibhav <hvaibhav@ti.com> wr=
ote:

>> The image works as expected on a 35xx based Beagle, but when run on
>> the Beagle xM results in a "HDMI: Out of Range" error from my monito=
r.
>> =A0Sadly the monitor won't give me the erroneous timing parameters.
>>
> [Hiremath, Vaibhav] For me it looks like Timing related issue only. A=
nd if I understand correctly I have seen some mail-threads which were t=
alking about successful bring-up on Beagle-XM board.
<snip>
> [Hiremath, Vaibhav] Steve,
>
> The AM/DM3730, which is exactly same as OMAP3630 has been supported w=
ith PSP releases. I would suggest you to refer to the Arago repo -
>
> http://arago-project.org/git/people/?p=3Dsriram/ti-psp-omap.git;a=3Ds=
ummary
>
> Please note that similar kind of testing/validation has been done on =
AM/DM3730 platform.

The Arago PSP kernel does indeed have functional DSS2 on the xM.  But
it is a 2.6.32 kernel with many, many patches that have not been
submitted to this list.  For many reasons I prefer to work with the
linux-omap branch.

Yes, I agree that it is a timing issue.  But it may be due to issues
in clock setup that are related to detecting the revision of the CPU.
In particular I notice that there are sections of clock setup code
that compare to ESX_X without checking for the CPU type.  So there are
likely ES1_0 workarounds intended for 34XX that are being done for
36XX ES1_0 CPU's.

In looking at the Arago PSP repo for 2.6.32 I see that there are
indeed patches for this issue, this one for example:

http://arago-project.org/git/projects/?p=3Dlinux-omap3.git;a=3Dcommitdi=
ff;h=3D9b6bdff1c68a42614bb1e06315d5c4be99c5c078

Obviously this patch needs to be updated for the current tree.  Does
TI intend to re-base and submit the patches in the arago repo to this
list?

Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
