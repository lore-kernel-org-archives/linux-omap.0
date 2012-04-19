From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] omap fixes for v3.4-rc3
Date: Wed, 18 Apr 2012 21:24:48 -0700
Message-ID: <CAOesGMjD22nqUg6k=e-U9Dbs_ueE2o-_cfvaZMDv34SZE9U-=Q@mail.gmail.com>
References: <20120418182349.GM21106@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61258 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834Ab2DSEYs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Apr 2012 00:24:48 -0400
Received: by yhmm54 with SMTP id m54so4162545yhm.19
        for <linux-omap@vger.kernel.org>; Wed, 18 Apr 2012 21:24:48 -0700 (PDT)
In-Reply-To: <20120418182349.GM21106@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Wed, Apr 18, 2012 at 11:23 AM, Tony Lindgren <tony@atomide.com> wrot=
e:
> Hi Arnd & Olof,
>
> Here are some fixes for the -rc cycle. The biggest change is to
> remove bad muxing for serial ports that was causing random oopses
> with at least zoom3 and nfsroot.
>
> Now using a signed tag.
>
> Regards,
>
> Tony
>
>
> The following changes since commit 0034102808e0dbbf3a2394b82b1bb40b57=
78de9e:
>
> =A0Linux 3.4-rc2 (2012-04-07 18:30:41 -0700)
>
> are available in the git repository at:
>
> =A0git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap ta=
gs/omap-fixes-for-v3.4-rc3

Thanks, pulled.


-Olof
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
