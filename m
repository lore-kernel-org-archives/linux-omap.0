From: David Cohen <dacohen@gmail.com>
Subject: Re: [PATCH 1/2] OMAP2+: IOMMU: change OMAP2+ error message to dev_dbg()
Date: Tue, 15 Feb 2011 16:08:32 +0200
Message-ID: <AANLkTim3+PFgJUU_-YqOt1M5NkSyHo6wUwF_XwC9MWSP@mail.gmail.com>
References: <1297776033-8579-1-git-send-email-dacohen@gmail.com>
	<1297776033-8579-2-git-send-email-dacohen@gmail.com>
	<4D5A81D8.2080800@ru.mvista.com>
	<AANLkTinQX59iyX1La=99Urgh5_JF0iZacBDqQz1VQfhi@mail.gmail.com>
	<20110215155948.32b564d5.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61983 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754809Ab1BOOIe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Feb 2011 09:08:34 -0500
Received: by wwa36 with SMTP id 36so216213wwa.1
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 06:08:33 -0800 (PST)
In-Reply-To: <20110215155948.32b564d5.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, tony@atomide.com, linux-omap@vger.kernel.org, Hiroshi.DOYU@nokia.com, linux-arm-kernel@lists.infradead.org

On Tue, Feb 15, 2011 at 3:59 PM, Jarkko Nikula <jhnikula@gmail.com> wro=
te:
> On Tue, 15 Feb 2011 15:44:27 +0200
> David Cohen <dacohen@gmail.com> wrote:
>
>> >> @@ -163,13 +163,13 @@ static u32 omap2_iommu_fault_isr(struct iom=
mu *obj,
>> >> u32 *ra)
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0da =3D iommu_read_reg(obj, MMU_FAULT_A=
D);
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0*ra =3D da;
>> >>
>> >> - =C2=A0 =C2=A0 =C2=A0 dev_err(obj->dev, "%s:\tda:%08x ", __func_=
_, da);
>> >> + =C2=A0 =C2=A0 =C2=A0 dev_dbg(obj->dev, "%s:\tda:%08x ", __func_=
_, da);
>> >
>> > =C2=A0 Note that dev_dbg() will only print something if either DEB=
UG or
>> > CONFIG_DYNAMIC_DEBUG are defined...
>>
>> That's my plan.
>>
> So it's sure that a developer won't need these error dumps when
> receiving an error report? I.e. IOMMU upper level errors give enough
> information to start doing own debugging?

Yes, developers do need this information.
But it's a bit useless tell only we've got an iommu fault, due to many
places might be causing it. My purpose is to let the debug
responsibility to IOMMU users. They have access to the iovmm layer as
well and can provide a much more useful information.
e.g. OMAP3 ISP has many submodules using IOMMU. With a fault callback,
it can dump all the iovm areas and the faulty 'da' too. It might
indicate which submodule was responsible for the issue.

Of course we can just let this debug messages the way they are and
print this redundant information. But IMO it's not necessary.

Regards,

David

>
> Just my 2 cents.
>
> --
> Jarkko
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
