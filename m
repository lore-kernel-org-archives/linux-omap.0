From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] ARM:omap2: using strlcpy instead of strncpy
Date: Wed, 06 Feb 2013 10:05:22 +0800
Message-ID: <5111BA62.8050908@asianux.com>
References: <51090829.1010109@asianux.com> <20130201224546.GG22517@atomide.com> <510F78AB.4000602@ti.com> <20130204181844.GP22517@atomide.com> <51106BF2.7080203@asianux.com> <20130205185648.GM25185@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:37490 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757050Ab3BFCFa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Feb 2013 21:05:30 -0500
In-Reply-To: <20130205185648.GM25185@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

=D3=DA 2013=C4=EA02=D4=C206=C8=D5 02:56, Tony Lindgren =D0=B4=B5=C0:
> * Chen Gang <gang.chen@asianux.com> [130204 18:22]:
>> >   Does it mean: we need not sync MAINTAINERS file for twl-*, recen=
tly ?
>> >=20
>> >   :-)
> No we should still do it.
>=20
> Tony
>=20

  ok, thanks.

  if necessary (no other members do it), I should perform.
  if really should I do:

    requirements:
      A) I should succeed provide at least 3 valuable patches to twl-*
           (or I am not qualified to provide the sync MAINTAINERS patch=
)

      B) relative member need give strictly checking for the patch.
           (so can evaluate whether I have been qualified)

      C) it is necessary to be monitored by the relative mailing lists.

    I should try:
      A) need mainly focus on the omap2, specially for twl-*

      B) the patch type should be for bug fixing:
           (I am not familiar with omap2, so can not for new features)
          i. memory override.
         ii. resource management.
        iii. others (compiling issue, type cast, ...)

      C) should provide 3 twl-* valuable patches within 1 month.
           (have finished one: strlcpy, in Jan 30 2013)
           (so need finish the other 2 patches, before Feb 28 2013)

    hope I can succeed.

    welcome any members to provide suggestions and completions.


  thanks.

  :-)

--=20
Chen Gang

Asianux Corporation
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
