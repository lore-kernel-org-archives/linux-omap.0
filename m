From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] omap fixes for v3.4-rc1
Date: Thu, 5 Apr 2012 10:48:39 -0700
Message-ID: <CAOesGMg7DWDH4ix30fh23YZ1hg207S7oQ05njrfEBkaYPjKWDQ@mail.gmail.com>
References: <20120405004256.GB10780@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:34666 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765Ab2DERsk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Apr 2012 13:48:40 -0400
Received: by gghe5 with SMTP id e5so861475ggh.19
        for <linux-omap@vger.kernel.org>; Thu, 05 Apr 2012 10:48:39 -0700 (PDT)
In-Reply-To: <20120405004256.GB10780@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi,

On Wed, Apr 4, 2012 at 5:42 PM, Tony Lindgren <tony@atomide.com> wrote:
> Hi Arnd & Olof,
>
> Please pull omap fixes from:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes
>
> Note that this also contains a set of fixes that are not regressions
> or oopses to properly deal with the smsc911x regulator issue.
>
> Basically the regulators must be per board file as the regulators
> can also come from drivers, such as twl4030. So it's best to dumb
> down gpmc-smsc911x.c to not even care about the regulators.
>
> Regards,
>
> Tony
>
>
> The following changes since commit dd775ae2549217d3ae09363e3edb305d0f=
a19928:
> =A0Linus Torvalds (1):
> =A0 =A0 =A0 =A0Linux 3.4-rc1
>
> are available in the git repository at:
>
> =A0git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fi=
xes


Thanks, pulled.

=46eel free to start sending these as signed tags with the above in the
tag description, so it's carried forward in the git history without
any work for us. :-)


-Olof
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
