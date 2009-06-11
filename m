From: halli manjunatha <hallimanju@gmail.com>
Subject: Re: DSS2 TV settings
Date: Thu, 11 Jun 2009 15:39:35 +0530
Message-ID: <ca6476860906110309wa9d0c76sf9022ee379972205@mail.gmail.com>
References: <4A2FEAC5.1060107@mlbassoc.com> <1244700527.8293.4.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f214.google.com ([209.85.217.214]:54275 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757081AbZFKKJe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jun 2009 06:09:34 -0400
Received: by gxk10 with SMTP id 10so2086127gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 11 Jun 2009 03:09:35 -0700 (PDT)
In-Reply-To: <1244700527.8293.4.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: ext Gary Thomas <gary@mlbassoc.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Thomas,

>> [not 100% related] The documentation says that TI is working on
>> the V4L2 support.  Do you know the status of this?  where I might
>> find it?
>
> I cannot help you with this. There have been mails about it on
> linux-omap and v4l2 lists, so you could search those archives.

There is a public repository representing the V4L2 driver on the
Tomi's DSS patches.  Here is the link to that.

http://arago-project.org/git/people/vaibhav/ti-psp-omap-video.git?p=3Dp=
eople/vaibhav/ti-psp-omap-video.git;a=3Dshortlog;h=3Drefs/heads/ti_disp=
lay


On Thu, Jun 11, 2009 at 11:38 AM, Tomi
Valkeinen<tomi.valkeinen@nokia.com> wrote:
> Hi,
>
> On Wed, 2009-06-10 at 19:17 +0200, ext Gary Thomas wrote:
>> Tomi,
>>
>> I'm running your latest DSS2 tree and have some questions about
>> the TV settings. =A0The timings, as published, don't work all that
>> well on our TV sets. =A0When I display a frame buffer to the TV
>> (using the recipe from the Documentation directory), some of
>> the actual frame buffer does not show on the screen. =A0In particula=
r,
>> if I have "tux" from the default system console framebuffer
>> showing, the top of his head is chopped off, as is a fair
>> amount of his left side. =A0Further tests show that some amount
>> of the frame buffer is not present on all margins.
>>
>> Is this to be expected?
>> Can the timings be adjusted so that the whole frame buffer shows?
>
> That is to be expected. I'm not an expert on analog TVs, but I think
> analog TVs always have non-visible areas. Some TVs show more of the
> total frame, and some show less.
>
> You need to adjust the overlay position and size so that it's fully
> visible on the TV. I guess there are some sane defaults that are more=
 or
> less ok for every TV out there, and omapfb could use those defaults, =
but
> I haven't really had time to study the TV out.
>
>>
>> [not 100% related] The documentation says that TI is working on
>> the V4L2 support. =A0Do you know the status of this? =A0where I migh=
t
>> find it?
>
> I cannot help you with this. There have been mails about it on
> linux-omap and v4l2 lists, so you could search those archives.
>
> =A0Tomi
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Regards
Manjunatha H
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
