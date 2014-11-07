From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: N900 modem support in 3.18-rc1
Date: Fri, 07 Nov 2014 09:04:52 +0200
Message-ID: <545C6F14.8050303@gmail.com>
References: <20141104205117.GA17606@amd> <20141106180335.GA21513@earth.universe> <20141106225005.GA14002@amd> <201411070001.46481@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201411070001.46481@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, freemangordon@abv.bg
List-Id: linux-omap@vger.kernel.org



On  7.11.2014 01:01, Pali Roh=C3=A1r wrote:

>
> For voice calls you need:
> * kernel driver cmt-speech (or it has some new name)
> * cmt-speech userspace library (communication with kernel)
> * pulseaudio modules which are using that library
>
> Freemangordon (Ivaylo Dimitrov, CCed) should know more about it,
> specially about pulseaudio modules...
>

I have a patch for cmt-speech on top of nokia-modem driver living=20
somewhere on my HDD, but I guess it is better Sebastian to make such a=20
patch (Sebastian, no?).

About the pulseaudio stuff - we're still in process of REing it, so far=
=20
there are 2 out of 3 closed Nokia modules ready=20
(https://gitorious.org/pulseaudio-nokia), but the last one, which is th=
e=20
one used for voice calls is still not ready and will take it a while :)=
=2E

Regards,
Ivo
