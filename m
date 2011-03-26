From: David Cohen <dacohen@gmail.com>
Subject: Re: OMAP 3430 Camera/ISP out of memory error
Date: Sat, 26 Mar 2011 15:16:46 +0200
Message-ID: <AANLkTimizTZvkHk=FeSM3hN0O2E42q1wZQNM9NZ7s8AH@mail.gmail.com>
References: <1301050377.25083.2.camel@kaas>
	<4D8C7B62.9010701@maxwell.research.nokia.com>
	<1301052893.25083.3.camel@kaas>
	<BANLkTik5MCZXWT5mAeAyL8Uh5eGE85-Ynw@mail.gmail.com>
	<1301079693.25083.8.camel@kaas>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45174 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323Ab1CZNQr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 26 Mar 2011 09:16:47 -0400
Received: by wwa36 with SMTP id 36so2264646wwa.1
        for <linux-omap@vger.kernel.org>; Sat, 26 Mar 2011 06:16:46 -0700 (PDT)
In-Reply-To: <1301079693.25083.8.camel@kaas>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Patrick Radius <info@notoyota.nl>
Cc: linux-omap@vger.kernel.org

On Fri, Mar 25, 2011 at 9:01 PM, Patrick Radius <info@notoyota.nl> wrot=
e:
> Thanks,
>
> I'm looking at
> http://gitorious.org/linux-omap/mainline/trees/master/drivers/media/v=
ideo
>
> however, I can't seem to find the drivers I need.
> I only see omap24xxcam while I was using the omap34xxcam from Linux
> kernel 2.6.32.9.
> And I also don't see any M-4MO driver anymore.
> I'm probably looking at the wrong spot, but...

You need to get an up-to-date mainline kernel. The driver is in the
directory: drivers/media/video/omap3isp/
I don't recommend you to use 2.6.32, as it depends on some new V4L2
stuff which you won't natively find in such old kernel version. I also
suggest you to CC linux-media@vger.kernel.org as well in next
questions.

Br,

David

>
> As you can tell, I'm fairly new with OMAP programming.
>
> Thanks!
>
> Regards,
> Patrick
>
> On vr, 2011-03-25 at 16:34 +0200, David Cohen wrote:
>> Hi,
>>
>> On Fri, Mar 25, 2011 at 1:34 PM, Patrick Radius <info@notoyota.nl> w=
rote:
>> > Ok, thanks!
>> > However, I'm also quite curious about peoples thoughts about it fr=
om
>> > here.
>> > Since I think what's happing is quite OMAP specific.
>> > For example, I was wondering where omap34xxcam.c gets it's memory =
it
>> > should allocate from.
>> > Is it the 'main' memory? Or does it share memory with a framebuffe=
r
>> > (overlay)? Or memory from the (M-4MO) sensor?
>> > Is it possible I should allocate memory for it as boot argument? s=
imilar
>> > like vmem=3D16M omapfb.vram=3D0:8M
>> >
>> > I can't find much information about this all...
>>
>> You're using an old version of the driver. Please, use the newer one
>> available in mainline.
>>
>> Regards,
>>
>> David Cohen
>>
>> >
>> > On vr, 2011-03-25 at 13:24 +0200, Sakari Ailus wrote:
>> >> Patrick Radius wrote:
>> >> > Hi,
>> >>
>> >> Hi Patrick,
>> >>
>> >> I think this question will get better answered in the linux-media=
 list.
>> >> Cc it.
>> >>
>> >> > i'm trying to get camera support working on a relatively new An=
droid
>> >> > port to an OMAP 3430 based phone (Samsung GT-i8320 a.k.a. Samsu=
ng H1).
>> >> > However calls to VIDIOC_REQBUFS fail with a -12 (OUT OF MEMORY)=
=2E
>> >> > As far as I can see this return error isn't even supposed to ex=
ist,
>> >> > according to the V4L2 spec.
>> >> > I'm using the code from Android on the Zoom2.
>> >> > The sensor is a Fujitsu M-4MO.
>> >> >
>> >> > Any ideas on what could be wrong with the out of memory result?
>> >>
>> >> First of all, which version of the driver are you using, i.e. is =
it the
>> >> current one going to upstream?
>> >>
>> >
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-om=
ap" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info=
=2Ehtml
>> >
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
