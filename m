From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: DSS2 on 36xx with 2.6.34-rc6
Date: Mon, 10 May 2010 21:51:58 -0700
Message-ID: <AANLkTin63iXBhoXpQPzJeKHCbx8Wb-R5NKhrCZhQc4PH@mail.gmail.com>
References: <AANLkTiljBOjnB4QZ6Df2IRu3Tw79rIZaGX3pkZ3X91cB@mail.gmail.com>
	 <19F8576C6E063C45BE387C64729E7394044E4049C6@dbde02.ent.ti.com>
	 <AANLkTilqVb-gc6TEyuS3pKuDEIzSJ9X6oRO-GR0YRAKJ@mail.gmail.com>
	 <19F8576C6E063C45BE387C64729E7394044E4049DE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f183.google.com ([209.85.221.183]:47963 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559Ab0EKEv7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 00:51:59 -0400
Received: by qyk13 with SMTP id 13so7475128qyk.1
        for <linux-omap@vger.kernel.org>; Mon, 10 May 2010 21:51:58 -0700 (PDT)
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044E4049DE@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, linux-omap@vger.kernel.org

On Mon, May 10, 2010 at 10:26 AM, Hiremath, Vaibhav <hvaibhav@ti.com> w=
rote:

>> Obviously this patch needs to be updated for the current tree. =A0Do=
es
>> TI intend to re-base and submit the patches in the arago repo to thi=
s
>> list?
>>
> [Hiremath, Vaibhav] We are submitting all the patches to the linux-om=
ap, we do have list of patches and also following up regularly.
>
> I hope you understand the business need also here, sometime due to so=
me high priority issues we could not able to follow up that aggressivel=
y.
>
> So you can expect patches anytime in the near future.

I understand.

Perhaps we could prioritize the patches required to get things
functional on 36XX/37XX.  I spent some time on this today and found
that a relatively small number of patches were required to get
2.6.34-rc6 running on the xM.

My working branch contains the patches required:

http://www.sakoman.com/cgi-bin/gitweb.cgi?p=3Dlinux-omap-2.6.git;a=3Dsh=
ortlog;h=3Drefs/heads/omap3-2.6.34

I've tested the resulting kernel with a GNOME user space and was able
to browse with Firefox using the xM's ethernet port, play youtube
videos, play DVD movies, and do native compiles.

I haven't yet tried SGX and DSP functionality, but suspect that those
will require a bunch more work.  As will PM . . . :-)

Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
