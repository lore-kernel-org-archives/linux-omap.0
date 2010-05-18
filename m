From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: dss2 for-next BUG at drivers/video/omap2/dss/core.c:323!
Date: Tue, 18 May 2010 20:12:10 +0300
Message-ID: <AANLkTikEouEjWyu9De6hAweyEGXx6drV4E18zWyC_CRg@mail.gmail.com>
References: <AANLkTinS0irEdEzttaHd0n_w5Cs3h6Q44e9sXgcbDmNH@mail.gmail.com>
	 <1274169334.2307.74.camel@tubuntu.research.nokia.com>
	 <AANLkTilySmQn2w0royR2UXltWt4Y94AAU-EYXvny9Se1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42923 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434Ab0ERRMM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 13:12:12 -0400
Received: by fxm10 with SMTP id 10so1359718fxm.19
        for <linux-omap@vger.kernel.org>; Tue, 18 May 2010 10:12:10 -0700 (PDT)
In-Reply-To: <AANLkTilySmQn2w0royR2UXltWt4Y94AAU-EYXvny9Se1@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Nelson <robertcnelson@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ville Syrjala <ville.syrjala@nokia.com>

On Tue, May 18, 2010 at 3:34 PM, Robert Nelson <robertcnelson@gmail.com=
> wrote:
> On Tue, May 18, 2010 at 2:55 AM, Tomi Valkeinen
> <tomi.valkeinen@nokia.com> wrote:
>> On Mon, 2010-05-17 at 16:30 +0200, ext Robert Nelson wrote:
>>> Hi Tomi,
>>>
>>> I've been using your dss2 branch with much success.
>>>
>>> http://gitorious.org/linux-omap-dss2/linux/commits/for-next
>>>
>>> I've just ran into a weird BUG that occurs on reboot on my headless
>>> beagles and wondering if you've ran into it too...
>>>
>>> The kernel I'm currently testing is 2.6.34-rc7 plus the 2.6.35 dss2
>>> for-next commits..
>>>
>>> I was assuming http://gitorious.org/linux-omap-dss2/linux/commit/89=
627989c6b4408c4578a41bcd5f9d04545797ad
>>> would fix it, but it hasn't fixed the Opps'ing...
>>>
>>> log on attempt to reboot:
>>>
>>> http://pastebin.com/iqAHMVD4
>>
>> It looks like there's a mismatch with clock enables and disables
>> somewhere... I haven't seen that.
>>
>> Can you tell me more details of your beagle? Does "headless" mean th=
at
>> it's standard beagle board, but no display is connected to it?
>
> Correct, just a beagle with no display connected..
>
> I upgraded to 2.6.34 final plus dss2 for-next and enabled omapfb.debu=
g
> and a generic modesetting to see if would make any difference in the
> bootargs. =C2=A0Same result..
>
> http://www.pastie.org/965380
>
> I should also mention, this only occurs after a small length of time
> (about 10 minutes).. I can't seem to trigger it after a frresh reboot
> (1-2 minutes)..
>
> config for reference:
> http://bazaar.launchpad.net/~beagleboard-kernel/+junk/2.6.34-devel/an=
notate/head:/patches/lucid-defconfig

I think I saw this bug yesterday, but didn't paid much attention.

CC'ing Ville who might have fixed this already.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
