From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv5 8/8] ARM: OMAP4: PM: Added option for enabling OSWR
Date: Wed, 16 May 2012 11:03:45 -0700
Message-ID: <87d364f1fi.fsf@ti.com>
References: <1336989796-26594-1-git-send-email-t-kristo@ti.com>
	<1336989796-26594-9-git-send-email-t-kristo@ti.com>
	<87zk999ie4.fsf@ti.com> <1337159445.2149.355.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:51155 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760054Ab2EPSDt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 May 2012 14:03:49 -0400
Received: by dacx6 with SMTP id x6so1209741dac.3
        for <linux-omap@vger.kernel.org>; Wed, 16 May 2012 11:03:47 -0700 (PDT)
In-Reply-To: <1337159445.2149.355.camel@sokoban> (Tero Kristo's message of
	"Wed, 16 May 2012 12:10:45 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

> On Tue, 2012-05-15 at 15:41 -0700, Kevin Hilman wrote:
>> Tero Kristo <t-kristo@ti.com> writes:
>> 
>> > PM debug now contains a file that can be used to control OSWR support
>> > enable / disable on OMAP4. Also removed the off_mode_enable file for
>> > the same platform as it is unsupported.
>> >>
>> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> 
>> I'll gladly take a patch that makes enable_off_mode OMAP3-only, but I am
>> not interested managing another new flag for OSWR.
>> 
>> For OMAP4, this should just be the default, and any drivers that are
>> broken just need to be fixed either by implementing context save/restore
>> or by using constraints.
>
> Well, it is not flag as such, as it is static variable internal to
> pm-debug.c. I could drop this, however it is extremely useful as a
> testing feature. Without this, it is difficult to test CSWR / OSWR. 

I understand its usefulness for testing (and I will use it to test this
series), but IMO it should live out of tree.  Having this in tree makes
it possible for drivers to be merged that don't support off-mode.  I
added this flag to OMAP3 as a short-term feature hoping that drivers
would eventually be converted, and I was wrong.  We still have drivers
that don't support off-mode upstream.  I don't want to make that mistake
again.

> If you have taken a look at the device-off set, I am actually adding
> the flag back for omap4 there for enabling device off. If this flag is
> also dropped, the device will always just go to device off, in which
> case testing CSWR / OSWR becomes an issue again, and I don't think
> this is ideal.
>
> Speaking of enable_off_mode, it might be possible to change it also be
> static and remove all the references to it from code. Currently it is
> only used from cpuidle34xx.c.

I would prefer to get rid of all of these flags, and use the new sysfs
controls[1] for CPUidle C-states to disable/enable certain C-states for
debugging/testing.

Kevin

[1] Example shell snippet using new sysfs interface:

# CPUidle: disable everything but C1
cd /sys/devices/system/cpu/cpu0/cpuidle
for state in state[1-6]*; do
  if [ -e ${state} ]; then
    echo 1 > ${state}/disable
  fi
done

