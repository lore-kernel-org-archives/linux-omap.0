From: Nishanth Menon <nm@ti.com>
Subject: Re: Nokia N900: musb is in wrong state after boot
Date: Fri, 10 Jun 2016 12:04:43 -0500
Message-ID: <575AF32B.2090705@ti.com>
References: <201601091616.04193@pali> <86213272.dICX26rd7d@saturn>
 <20160610155940.GB28283@uda0271908> <2592499.y1ehgT9o2a@saturn>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2592499.y1ehgT9o2a@saturn>
Sender: linux-kernel-owner@vger.kernel.org
To: joerg Reisenweber <joerg@openmoko.org>, Bin Liu <b-liu@ti.com>
Cc: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Felipe Balbi <balbi@kernel.org>
List-Id: linux-omap@vger.kernel.org

On 06/10/2016 11:15 AM, joerg Reisenweber wrote:

Sorry for butting in...

> On Fri 10 June 2016 10:59:40 Bin Liu wrote:
>> The musb ug says the testmde is not used in normal operation, so my
>> opinion is force_host should not be used for hacking n900 host mode if
>> this is for real product development or support.
> 
> You're aware N900 OS aka maemo is a) FOSS, and b) EOL at least from Nokia's 
> POV? So there's neither "product development" nor any _'official'_ support 
> involved.
> And c) we (community) already _did_ use it since it was the only chance to 
> make hostmode sort of work for N900, it's not like we could redesign N900 
> hardware to support regular hostmode, we need to work with what RL gave us. 
> It evades me why you discourage resp reject this established solution. 
> Just Nokia not supporting hostmode evidently doesn't mean we can't get 
> anything done, and I don't see why we should refrain from doing so.

I think there was some unfortunately choice of words used in the
thread. It is TI intention to support community effort and we are very
appreciative of the work and effort done by the N900 community. Please
do not misunderstand that we dont care for FOSS community, in fact, we
are part of the FOSS community as well and a significant investment is
done to ensure that "upstream first" approach is taken to benefit
everyone.

Hopefully with that out of the way, on this specific topic, based on a
quick chat with Bin, I think Bin meant to indicate that as per Mentor
vendor documentation, the option is a test mode meant for silicon
validation purposes - typically many vendor hardware blocks have these
"test mode" bits and options meant to help silicon validation
software, unfortunately these modes do not tend to be well tested and
the typical "official disclaimer" is "Not for 'production device
usage' and 'user might be on  his/her own' " - That does not mean it
cannot work, but it may not always be working OR can have reliability
issues/open up unknown silicon issues that has not been well covered
by SoC and/or IP vendor. In this case specifically, I think Bin's
experience of having had tried to get this working in AM335x and had
failed makes him a little more skeptical.

I think Bin has accepted this patch, but anyways, it is always good to
highlight potential risk. I assume Bin can elaborate more as needed.

Post Note: We all do appreciate all the creative ways folks do use TI
SoCs, it is important we try and continue do that to leverage every
single transistor that the SoC has, but we should also just keep a
watch for any potential risks we might have to face with these options
we exploit.

-- 
Regards,
Nishanth Menon
