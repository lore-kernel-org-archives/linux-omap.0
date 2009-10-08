From: Juha Kuikka <juha.kuikka@gmail.com>
Subject: Re: [ANNOUNCE] updated PM branch, based on 2.6.32-rc1
Date: Thu, 8 Oct 2009 15:09:40 -0700
Message-ID: <a46a26fd0910081509u426b0f9fraa24ea8c99a5717e@mail.gmail.com>
References: <87iqezdmas.fsf@deeprootsystems.com>
	 <87eipgnmfh.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f172.google.com ([209.85.221.172]:35672 "EHLO
	mail-qy0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757433AbZJHWKR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 18:10:17 -0400
Received: by qyk2 with SMTP id 2so6041934qyk.21
        for <linux-omap@vger.kernel.org>; Thu, 08 Oct 2009 15:09:40 -0700 (PDT)
In-Reply-To: <87eipgnmfh.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Tue, Oct 6, 2009 at 4:16 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
>
> Kevin Hilman <khilman@deeprootsystems.com> writes:
>
> > Hello,
> >
> > I've rebased/updated the PM branch based on current linux-omap mast=
er
> > branch (2.6.32-rc1 based.)
> >
> > I've also updated the OMAP Power Management wiki, and the 'Current
> > version' section highlights the changes, supported platforms as wel=
l
> > as the features that have made it into mainline.
> >
> > =A0 =A0 =A0http://elinux.org/OMAP_Power_Management#Current_version
> >
>
> FYI... I just rebased the PM branch onto current omap/master.
>
> Some important user-visible changes: The /sys/power/* options are
> moving into debugfs. =A0For mainline, these primarily debug options n=
eed
> to move to debugfs so I've moved them there. =A0So, if you're missing
> some flag under /sys/power, it's now under /debug/pm_debug.
>
> I've updated the 'Using the PM branch' seciont of PM wiki[1] with
> the new filenames.
>
> Kevin
>
> [1] http://elinux.org/OMAP_Power_Management
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html

Hi,

I build and tried this latest on Beagleboard (C2). Booting from MMC
using ramdisk image. I changed the LL console to the 3rd UART.

The issue I have is that after the system boots up it works for as
long as I keep actively using it but if I leave it idle for a short
time (~5s) it stops responding. I have tried waking it up using both
UART and "USER" button on the board. This is with the default PM
configuration.

If I put the board into suspend (retention) it wakes up without any iss=
ues.

Also, if I enable "/debug/pm_debug/sleep_while_idle" board wakes up
without issues. Well the first couple characers on the console seem to
go missing but I guess without CTS/RTS that is expected?

Any pointers would be appreciated.

 - Juha

--
Madness takes it's toll. Please have exact change.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
