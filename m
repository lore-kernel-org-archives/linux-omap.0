From: Juha Kuikka <juha.kuikka@gmail.com>
Subject: Re: [ANNOUNCE] updated PM branch, based on 2.6.32-rc1
Date: Mon, 12 Oct 2009 11:37:53 -0700
Message-ID: <a46a26fd0910121137j6d86dfjf1df52612dcb88f1@mail.gmail.com>
References: <87iqezdmas.fsf@deeprootsystems.com>
	 <87eipgnmfh.fsf@deeprootsystems.com>
	 <a46a26fd0910081509u426b0f9fraa24ea8c99a5717e@mail.gmail.com>
	 <87ab014iun.fsf@deeprootsystems.com>
	 <87bpkgwk3t.fsf@deeprootsystems.com>
	 <87bpkgut1u.fsf@deeprootsystems.com>
	 <87zl80te9t.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f186.google.com ([209.85.221.186]:49888 "EHLO
	mail-qy0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757662AbZJLSqE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Oct 2009 14:46:04 -0400
Received: by qyk16 with SMTP id 16so2590307qyk.15
        for <linux-omap@vger.kernel.org>; Mon, 12 Oct 2009 11:45:26 -0700 (PDT)
In-Reply-To: <87zl80te9t.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Fri, Oct 9, 2009 at 3:04 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
>
> Kevin Hilman <khilman@deeprootsystems.com> writes:
>
> > Kevin Hilman <khilman@deeprootsystems.com> writes:
> >
> >> Kevin Hilman <khilman@deeprootsystems.com> writes:
> >>
> >>> Juha Kuikka <juha.kuikka@gmail.com> writes:
> >>>
> >>>> On Tue, Oct 6, 2009 at 4:16 PM, Kevin Hilman
> >>>> <khilman@deeprootsystems.com> wrote:
> >>>>>
> >>>>> Kevin Hilman <khilman@deeprootsystems.com> writes:
> >>>>>
> >>>>> > Hello,
> >>>>> >
> >>>>> > I've rebased/updated the PM branch based on current linux-oma=
p master
> >>>>> > branch (2.6.32-rc1 based.)
> >>>>> >
> >>>>> > I've also updated the OMAP Power Management wiki, and the 'Cu=
rrent
> >>>>> > version' section highlights the changes, supported platforms =
as well
> >>>>> > as the features that have made it into mainline.
> >>>>> >
> >>>>> > =A0 =A0 =A0http://elinux.org/OMAP_Power_Management#Current_ve=
rsion
> >>>>> >
> >>>>>
> >>>>> FYI... I just rebased the PM branch onto current omap/master.
> >>>>>
> >>>>> Some important user-visible changes: The /sys/power/* options a=
re
> >>>>> moving into debugfs. =A0For mainline, these primarily debug opt=
ions need
> >>>>> to move to debugfs so I've moved them there. =A0So, if you're m=
issing
> >>>>> some flag under /sys/power, it's now under /debug/pm_debug.
> >>>>>
> >>>>> I've updated the 'Using the PM branch' seciont of PM wiki[1] wi=
th
> >>>>> the new filenames.
> >>>>>
> >>>>> Kevin
> >>>>>
> >>>>> [1] http://elinux.org/OMAP_Power_Management
> >>>>> --
> >>>>> To unsubscribe from this list: send the line "unsubscribe linux=
-omap" in
> >>>>> the body of a message to majordomo@vger.kernel.org
> >>>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info=
=2Ehtml
> >>>>
> >>>> Hi,
> >>>
> >>> Hi Juha,
> >>>
> >>>> I build and tried this latest on Beagleboard (C2). Booting from =
MMC
> >>>> using ramdisk image. I changed the LL console to the 3rd UART.
> >>>>
> >>>> The issue I have is that after the system boots up it works for =
as
> >>>> long as I keep actively using it but if I leave it idle for a sh=
ort
> >>>> time (~5s) it stops responding. I have tried waking it up using =
both
> >>>> UART and "USER" button on the board. This is with the default PM
> >>>> configuration.
> >>>
> >>> Thanks for testing, and reporting your problem. =A0I have noticed
> >>> exactly the same problem and am still investigating it.
> >>>
> >>>> If I put the board into suspend (retention) it wakes up without =
any issues.
> >>>>
> >>>> Also, if I enable "/debug/pm_debug/sleep_while_idle" board wakes=
 up
> >>>> without issues. Well the first couple characers on the console s=
eem to
> >>>> go missing but I guess without CTS/RTS that is expected?
> >>>
> >>> Yes, the loss of the first character is expected.
> >>>
> >>>> Any pointers would be appreciated.
> >>>
> >>> I also noticed that it works when 'sleep_while_idle' is enabled, =
and
> >>> this has led me to suspect a bug in that serial timout path, but =
I
> >>> have yet to debug further.
> >>
> >> FYI...
> >>
> >> I haven't figured out exactly why yet, but this patch gets things
> >> working again.
> >>
> >> Basically, I'm just leaving smart-idle disabled all the time.
> >>
> >
> > I've discovered that this is only needed when using the older u-boo=
t
> > binary I was downloading from beagleboard.org. =A0I've had lots of =
PM
> > headaches when using this u-boot and I had forgotten that I had
> > (re)flashed with it.
> >
> > If I build and use a u-boot from the u-boot-ti repo[1], I don't hav=
e
> > this problem anymore.
>
> Scratch that. =A0Operator error. =A0Actually, I still do have this
> particular problem, but upgrading u-boot solved some other unrelated
> problems.
>
> Sorry for the noise.

Hi,

I updated both x-loader and u-boot. And I also pulled the latest
omap-pm and did a fresh build. I noticed there is a commit that should
fix the serial port issue.

Unfortunately I am still plagued by it.

X-Loader 1.41
U-Boot 2009.08 (Oct 09 2009 - 15:59:45)
Latest omap-om git pull (b7ecc865c5f0885fae4c4401fa78a24084f45c40).

 / Juha
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
