From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [alsa-devel] Beep sound in the end of audio file
Date: Wed, 6 May 2009 10:03:37 -0400
Message-ID: <9e4733910905060703h48577780m8d99fb28101045b1@mail.gmail.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0305559FCC@dbde02.ent.ti.com>
	 <200905060833.10998.peter.ujfalusi@nokia.com>
	 <9e4733910905060701r33b7f3eaxf8d9da07f4bfd101@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f174.google.com ([209.85.218.174]:36864 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754851AbZEFODj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 May 2009 10:03:39 -0400
Received: by bwz22 with SMTP id 22so124957bwz.37
        for <linux-omap@vger.kernel.org>; Wed, 06 May 2009 07:03:38 -0700 (PDT)
In-Reply-To: <9e4733910905060701r33b7f3eaxf8d9da07f4bfd101@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "ext Aggarwal, Anuj" <anuj.aggarwal@ti.com>, alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, May 6, 2009 at 10:01 AM, Jon Smirl <jonsmirl@gmail.com> wrote:
> On Wed, May 6, 2009 at 1:33 AM, Peter Ujfalusi <peter.ujfalusi@nokia.=
com> wrote:
>> Hello,
>>
>> On Tuesday 05 May 2009 20:03:57 ext Aggarwal, Anuj wrote:
>>> Hi,
>>>
>>> After playing out any audio file on OMAP3 EVM, having TWL4030 codec=
,
>>> I am hearing a beep sound. I have also tried implementing a mute fu=
nction
>>> in which I disabled all the inputs/outputs but still that didn't he=
lp.
>>>
>>> Any idea how this can be avoided?
>>
>> I have not heard from this kind of problem so far, which does not me=
an, that
>> it does not exist ;)
>> Can you describe the beep sound?
>>
>> After a quick look I can not pin point the soc board file used with =
the
>> omap3evm board. Is it in the tree?
>>
>> Does the beep happens in these cases also (after stopping it with Ct=
rl+C):
>> aplay -f dat /dev/zero
>> aplay -f dat /dev/urandom
>
>
> I'm having this problem on PowerPC....
>
> Audio is played via multiple period buffers
> Am interrupt is generated on the end of each period
>
> The problem occurs at the end of the stream.
> The period containing the end of stream plays and generates an interr=
upt.
> ALSA then calls back with trigger(STOP)
>
> But I can't shut off the DMA fast enough on these slower CPUs (not
> 3Ghz) to prevent the next period from starting to play. This next
> period contains data from earlier in the stream. When a small amount
> of it plays it sounds like a short tone beep.
>
> The beep is only obvious if the last period being played mostly
> contains silence. In that case the silence will play, then you will b=
e
> able to hear the burst of noise separated from the rest of the stream=
=2E

PS - a simple way to see if this is your problem. In the ISR memset the=
 buffer
that just finished playing to zero. That will make the problem go away =
since the
stale data is now just silence.

>
> What I need to know is the address of the last valid sample in the
> stream. If I knew that I could just program the DMA hardware to stop
> after it played. I've been staring at ALSA core for a couple of days
> trying to figure out how to get the address for the end of the stream=
=2E
>
>
>
>
>>
>>
>> CC-ing alsa-devel...
>>
>>>
>>> Thanks and Regards,
>>> Anuj Aggarwal
>>>
>>> Platform Support Products
>>> Texas Instruments Incorporated
>>
>>
>> --
>> P=E9ter
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>
>
>
> --
> Jon Smirl
> jonsmirl@gmail.com
>



--=20
Jon Smirl
jonsmirl@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
