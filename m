From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] one kernel panic fix for v3.3-rc7
Date: Tue, 13 Mar 2012 15:49:54 -0700
Message-ID: <CAOesGMi+ySz9QZNZAZYRBD8J8i5TzmfVd+fBrpvSFsHOOQ3_aA@mail.gmail.com>
References: <20120313183352.GN12083@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35645 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227Ab2CMWtz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Mar 2012 18:49:55 -0400
Received: by yhmm54 with SMTP id m54so1139610yhm.19
        for <linux-omap@vger.kernel.org>; Tue, 13 Mar 2012 15:49:54 -0700 (PDT)
In-Reply-To: <20120313183352.GN12083@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Mar 13, 2012 at 11:33 AM, Tony Lindgren <tony@atomide.com> wrot=
e:
> Hi Olof,
>
> Here's one more kernel panic fix that I dropped from last weeks
> fixes as it was still being discussed.
>
> This is a fix for the regression caused by fixing an earlier
> regression for smsc911x fixed regulators :(
>
> Turns out that we have more than one smsc911x on some boards,
> and the earlier fix causes a kernel panic for board trying to
> register second smsc911x instance, even if the second smsc911x
> is on an add-on board that is not connected.
>
> Note that the boards with second smsc911x will also need to be
> patched later on to provide their own regulators.
>
> Regards,
>
> Tony
>
>
> The following changes since commit fde7d9049e55ab85a390be7f415d74c9f6=
2dd0f9:
> =A0Linus Torvalds (1):
> =A0 =A0 =A0 =A0Linux 3.3-rc7
>
> are available in the git repository at:
>
> =A0git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fi=
x-smsc911x-regulator
>
> Kevin Hilman (1):
> =A0 =A0 =A0ARM: OMAP2+: gpmc-smsc911x: only register regulator for fi=
rst instance

Thanks, pulled.


-Olof
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
