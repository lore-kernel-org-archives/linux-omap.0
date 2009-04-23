From: "Alejandro Blanca G." <alex.blanca@gmail.com>
Subject: Re: trouble with alsa, wolfson, and TI OMAP35xx McBSP
Date: Thu, 23 Apr 2009 11:50:25 -0500
Message-ID: <b6ab3a160904230950g61ae6e78mac2f02ada111c40c@mail.gmail.com>
References: <dbdb2ea60904221058w67b775f3occ07f55938fe4d03@mail.gmail.com>
	 <200904231220.14465.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:15349 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756032AbZDWQu0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Apr 2009 12:50:26 -0400
Received: by qw-out-2122.google.com with SMTP id 5so537961qwd.37
        for <linux-omap@vger.kernel.org>; Thu, 23 Apr 2009 09:50:26 -0700 (PDT)
In-Reply-To: <200904231220.14465.peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: ext twebb <taliaferro62@gmail.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, etorres@dextratech.com

Hi everyone.

We are working with bringing up another audio codec with the Beagle Boa=
rd.

Probably the issue we are seeing is related: we are having problems
when doing playback and observe that the information corresponding to
2 channels is being sent only through the left channel. We might have
some other problems too, since we are new to this kind of development,
but maybe our observations or yours could be useful to stabilize the
Beagle platform code.

Best regards,

Alex B.

On Thu, Apr 23, 2009 at 4:20 AM, Peter Ujfalusi
<peter.ujfalusi@nokia.com> wrote:
> On Wednesday 22 April 2009 20:58:01 ext twebb wrote:
>> Problem 2:
>> Test tone is being presented by the user application, providing a 1K=
hz
>> tone sampled at 44.1Khz. The data are S16_LE, right channel only. Le=
ft
>> channel is quiet. The data seems to slip back and forth from left to
>> right channel. This is reproducable and verified with a scope trace.
>>
>> Anybody have any ideas what might be going wrong here? =A0Traces for
>> codec reg dump and mcbsp are attached.
>
> As Jarkko already asked: are you seeing the channel switch while runn=
ing or is
> it happens on playback start?
>
> AFAIK this phenomena can be also seen on Beagle board.
>
> I have done some investigation regarding to these, but so far I can n=
ot say
> that I know what causes it.
>
> BTW: these are separate issues (startup switch and runtime switch).
>
>> Thanks,
>> twebb
>
> --
> P=E9ter
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
