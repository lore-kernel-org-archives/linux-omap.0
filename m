From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCHv2 09/15] OMAP: DSS2: HDMI: implement detect()
Date: Wed, 14 Sep 2011 13:57:07 +0530
Message-ID: <CAP5A+B9uDj4kCowbEKgX1J74zWvBarp64Cn4YVom-a8BYtab4w@mail.gmail.com>
References: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com>
 <1315818818-18733-10-git-send-email-tomi.valkeinen@ti.com>
 <CAP5A+B9_Jsg23oR49q2bkBGVLDWHBiBZj_=_G1SRf7ftrMt_iw@mail.gmail.com>
 <CAF6AEGuhjZgH9zFuigjfvHGM9r7jSLY2TTCD0LjZbT+Ubrb12A@mail.gmail.com>
 <CAP5A+B87w6Hir-0+SNnckQaDcO=ixgq-U8pFo2U42dwQgtUrZQ@mail.gmail.com> <1315984468.2172.10.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:59366 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752811Ab1INI12 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Sep 2011 04:27:28 -0400
In-Reply-To: <1315984468.2172.10.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rob Clark <robdclark@gmail.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com

On Wed, Sep 14, 2011 at 12:44 PM, Tomi Valkeinen <tomi.valkeinen@ti.com=
> wrote:
> On Wed, 2011-09-14 at 11:04 +0530, K, Mythri P wrote:
>> Hi,
>>
>> On Mon, Sep 12, 2011 at 10:16 PM, Rob Clark <robdclark@gmail.com> wr=
ote:
>> > On Mon, Sep 12, 2011 at 8:24 AM, K, Mythri P <mythripk@ti.com> wro=
te:
>> >>> +bool ti_hdmi_4xxx_detect(struct hdmi_ip_data *ip_data)
>> >>> +{
>> >>> + =A0 =A0 =A0 int r;
>> >>> +
>> >>> + =A0 =A0 =A0 void __iomem *base =3D hdmi_core_sys_base(ip_data)=
;
>> >>> +
>> >>> + =A0 =A0 =A0 /* HPD */
>> >>> + =A0 =A0 =A0 r =3D REG_GET(base, HDMI_CORE_SYS_SYS_STAT, 1, 1);
>> >>> +
>> >>> + =A0 =A0 =A0 return r =3D=3D 1;
>> >>> +}
>> >>> +
>> >> For HPD the probe should also be on the core interrupt first , an=
d the
>> >> detect should be dynamic, ie based on the cable connect and disco=
nnect
>> >> event.So this approach for HPD is not really the way.
>> >> Also that should be based on the GPIO(63) , I am planning to push=
 a
>> >> patch on that shortly.
>> >
>> >
>> > Fwiw, we do still need a dssdrv->detect() function from omapdrm
>> > driver.. =A0if there is another way to implement that function, su=
ch as
>> > with a GPIO, that is great. =A0But somehow or another we need the =
detect
>> > function. =A0The implementation can always change later.
>> Yes we still need a detect , but the implementation would be differe=
nt
>> , from the prior experience with the Hot-plug detection it wad found
>> that the interrupt based way to handle HPD was not the best ,but if
>> this is just to poll the status then it should be fine.
>
> I'm not sure I understood. First you say the implementation should be
> different, but then you say this should be fine. So is this a valid
> implementation for detect() or is there a better way to do it?
>
There is a better way to handle Hot-plug detection and notification..
But depends on what is the purpose of this function, Ideally a detect
would be the case to dynamically detect whether the cable is connected
on not , But all this function does is to see the state of the HPD bit
in core state statically.
So I said if the purpose of this function is only to check for the HPD
state bit it is fine.

Thanks and regards,
Mythri.
> =A0Tomi
>
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
