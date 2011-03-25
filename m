From: David Cohen <dacohen@gmail.com>
Subject: Re: OMAP 3430 Camera/ISP out of memory error
Date: Fri, 25 Mar 2011 16:34:57 +0200
Message-ID: <BANLkTik5MCZXWT5mAeAyL8Uh5eGE85-Ynw@mail.gmail.com>
References: <1301050377.25083.2.camel@kaas>
	<4D8C7B62.9010701@maxwell.research.nokia.com>
	<1301052893.25083.3.camel@kaas>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57168 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059Ab1CYOe6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 10:34:58 -0400
Received: by iwn34 with SMTP id 34so1119602iwn.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 07:34:57 -0700 (PDT)
In-Reply-To: <1301052893.25083.3.camel@kaas>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Patrick Radius <info@notoyota.nl>
Cc: linux-omap@vger.kernel.org

Hi,

On Fri, Mar 25, 2011 at 1:34 PM, Patrick Radius <info@notoyota.nl> wrot=
e:
> Ok, thanks!
> However, I'm also quite curious about peoples thoughts about it from
> here.
> Since I think what's happing is quite OMAP specific.
> For example, I was wondering where omap34xxcam.c gets it's memory it
> should allocate from.
> Is it the 'main' memory? Or does it share memory with a framebuffer
> (overlay)? Or memory from the (M-4MO) sensor?
> Is it possible I should allocate memory for it as boot argument? simi=
lar
> like vmem=3D16M omapfb.vram=3D0:8M
>
> I can't find much information about this all...

You're using an old version of the driver. Please, use the newer one
available in mainline.

Regards,

David Cohen

>
> On vr, 2011-03-25 at 13:24 +0200, Sakari Ailus wrote:
>> Patrick Radius wrote:
>> > Hi,
>>
>> Hi Patrick,
>>
>> I think this question will get better answered in the linux-media li=
st.
>> Cc it.
>>
>> > i'm trying to get camera support working on a relatively new Andro=
id
>> > port to an OMAP 3430 based phone (Samsung GT-i8320 a.k.a. Samsung =
H1).
>> > However calls to VIDIOC_REQBUFS fail with a -12 (OUT OF MEMORY).
>> > As far as I can see this return error isn't even supposed to exist=
,
>> > according to the V4L2 spec.
>> > I'm using the code from Android on the Zoom2.
>> > The sensor is a Fujitsu M-4MO.
>> >
>> > Any ideas on what could be wrong with the out of memory result?
>>
>> First of all, which version of the driver are you using, i.e. is it =
the
>> current one going to upstream?
>>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
