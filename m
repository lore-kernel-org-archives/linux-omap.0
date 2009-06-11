From: halli manjunatha <hallimanju@gmail.com>
Subject: Re: DSS2 TV settings
Date: Thu, 11 Jun 2009 17:49:06 +0530
Message-ID: <ca6476860906110519o45ac9320n7a9c4297ab5fda76@mail.gmail.com>
References: <4A2FEAC5.1060107@mlbassoc.com> <1244700527.8293.4.camel@tubuntu>
	 <ca6476860906110309wa9d0c76sf9022ee379972205@mail.gmail.com>
	 <4A30EF7C.1030809@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f214.google.com ([209.85.217.214]:55171 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510AbZFKMTF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jun 2009 08:19:05 -0400
Received: by gxk10 with SMTP id 10so2179288gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 11 Jun 2009 05:19:06 -0700 (PDT)
In-Reply-To: <4A30EF7C.1030809@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: tomi.valkeinen@nokia.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Jun 11, 2009 at 5:20 PM, Gary Thomas<gary@mlbassoc.com> wrote:
> halli manjunatha wrote:
>> Hi Thomas,
>>
>>>> [not 100% related] The documentation says that TI is working on
>>>> the V4L2 support. =A0Do you know the status of this? =A0where I mi=
ght
>>>> find it?
>>> I cannot help you with this. There have been mails about it on
>>> linux-omap and v4l2 lists, so you could search those archives.
>>
>> There is a public repository representing the V4L2 driver on the
>> Tomi's DSS patches. =A0Here is the link to that.
>>
>> http://arago-project.org/git/people/vaibhav/ti-psp-omap-video.git?p=3D=
people/vaibhav/ti-psp-omap-video.git;a=3Dshortlog;h=3Drefs/heads/ti_dis=
play
>>
>
> Thanks for the pointer.
>
> Which board(s) has this been tested with (so I can look at the config=
s)?
> What are you using to test it with?

I have tested this on omap3 evm it's working fine. i just used some
v4l2 test apps to test the
video output

>
> I noticed that your tree is 2.6.30-rc7, Tomi's is -rc8. =A0There are =
quite
> a few differences (> 1MB patch file). =A0How can I reconcile what you=
've
> changed with my working tree (which is based on Tomi's 2.6.30-rc8 tre=
e)?
>
> Thanks for any help
>
>> On Thu, Jun 11, 2009 at 11:38 AM, Tomi
>> Valkeinen<tomi.valkeinen@nokia.com> wrote:
>>> Hi,
>>>
>>> On Wed, 2009-06-10 at 19:17 +0200, ext Gary Thomas wrote:
>>>> Tomi,
>>>>
>>>> I'm running your latest DSS2 tree and have some questions about
>>>> the TV settings. =A0The timings, as published, don't work all that
>>>> well on our TV sets. =A0When I display a frame buffer to the TV
>>>> (using the recipe from the Documentation directory), some of
>>>> the actual frame buffer does not show on the screen. =A0In particu=
lar,
>>>> if I have "tux" from the default system console framebuffer
>>>> showing, the top of his head is chopped off, as is a fair
>>>> amount of his left side. =A0Further tests show that some amount
>>>> of the frame buffer is not present on all margins.
>>>>
>>>> Is this to be expected?
>>>> Can the timings be adjusted so that the whole frame buffer shows?
>>> That is to be expected. I'm not an expert on analog TVs, but I thin=
k
>>> analog TVs always have non-visible areas. Some TVs show more of the
>>> total frame, and some show less.
>>>
>>> You need to adjust the overlay position and size so that it's fully
>>> visible on the TV. I guess there are some sane defaults that are mo=
re or
>>> less ok for every TV out there, and omapfb could use those defaults=
, but
>>> I haven't really had time to study the TV out.
>>>
>>>> [not 100% related] The documentation says that TI is working on
>>>> the V4L2 support. =A0Do you know the status of this? =A0where I mi=
ght
>>>> find it?
>>> I cannot help you with this. There have been mails about it on
>>> linux-omap and v4l2 lists, so you could search those archives.
>
> --
> ------------------------------------------------------------
> Gary Thomas =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0Consulting for the
> MLB Associates =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0Embedded world
> ------------------------------------------------------------
>



--=20
Regards
Manjunatha H
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
