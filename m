From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/2] GPIO: OMAP: move to drivers/gpio
Date: Fri, 27 May 2011 08:46:26 -0700
Message-ID: <87pqn4404t.fsf@ti.com>
References: <1305898868-9188-1-git-send-email-khilman@ti.com>
	<1305898868-9188-3-git-send-email-khilman@ti.com>
	<20110527073529.GF31953@ponder.secretlab.ca>
	<BANLkTinqEM-iDhgSMAnMB5uehkt=V1Qq+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:53009 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754682Ab1E0Pq3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 May 2011 11:46:29 -0400
Received: by pvh21 with SMTP id 21so886737pvh.29
        for <linux-omap@vger.kernel.org>; Fri, 27 May 2011 08:46:28 -0700 (PDT)
In-Reply-To: <BANLkTinqEM-iDhgSMAnMB5uehkt=V1Qq+w@mail.gmail.com> (Grant
	Likely's message of "Fri, 27 May 2011 02:25:33 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, linux-arm-kernel@lists.infradead.org

Grant Likely <grant.likely@secretlab.ca> writes:

> On Fri, May 27, 2011 at 1:35 AM, Grant Likely <grant.likely@secretlab=
=2Eca> wrote:
>> On Fri, May 20, 2011 at 03:41:08PM +0200, Kevin Hilman wrote:
>>> Move OMAP GPIO driver to drivers/gpio. =C2=A0Builds whenever
>>> CONFIG_ARCH_OMAP=3Dy.
>>>
>>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>>
>> Patch unfortunately doesn't apply cleanly to Linus' tree. =C2=A0Ther=
e's
>> been some changes to gpio.c compared to the tree this patch was
>> prepared against.
>>
>> Also, if you use the -M flag when preparing the patch, then I'll be
>> able to see what the changes are during the move, and fix things up
>> intelligently if anything breaks.
>>
>> Can you respin and repost the series quickly?
>
> While you're at it, can you name the moved file
> drivers/gpio/gpio-omap.c?  ('-' instead of '_'.  Why, yes, I am a
> nitpicker.)

OK, I rebased onto RMK's for-linus branch (already pulled by Linus),
which contained some other changes touching gpio.c.    I also s/_/-/ in
the filename.

Below is pull request.

Thanks,

Kevin


The following changes since commit 9a55d9752d8abfc62f1ab05ccc790d22a0c8=
e7c0:

  Merge branch 'devel-stable' into for-linus (2011-05-23 19:28:04 +0100=
)

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-p=
m.git for_2.6.40/gpio-move

Kevin Hilman (2):
      GPIO: OMAP: move register offset defines into <plat/gpio.h>
      GPIO: OMAP: move to drivers/gpio

 arch/arm/plat-omap/Makefile                        |    2 +-
 arch/arm/plat-omap/include/plat/gpio.h             |  103 ++++++++++++=
+++++++
 drivers/gpio/Makefile                              |    1 +
 .../plat-omap/gpio.c =3D> drivers/gpio/gpio-omap.c   |  105 ----------=
----------
 4 files changed, 105 insertions(+), 106 deletions(-)
 rename arch/arm/plat-omap/gpio.c =3D> drivers/gpio/gpio-omap.c (93%)


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
