From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: dmtimer: cleanup fclk usage
Date: Wed, 18 Apr 2012 13:49:52 +0530
Message-ID: <CAC83ZvLSjXSGd4hviMp7jdGi_8MBkU2NpD1dYJyLGx_MaiUx+g@mail.gmail.com>
References: <1334579125-15566-1-git-send-email-tarun.kanti@ti.com>
	<1334579125-15566-4-git-send-email-tarun.kanti@ti.com>
	<alpine.DEB.2.00.1204161034290.29048@utopia.booyaka.com>
	<4F8C864B.4090101@ti.com>
	<CAC83ZvJ=TsDvs-pVZP1PyLFQY=nLh48tDE8SYQFxrLOUD-3aHQ@mail.gmail.com>
	<alpine.DEB.2.00.1204180213330.29048@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:41533 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751202Ab2DRITy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Apr 2012 04:19:54 -0400
Received: by qcsd16 with SMTP id d16so4451333qcs.28
        for <linux-omap@vger.kernel.org>; Wed, 18 Apr 2012 01:19:52 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1204180213330.29048@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, santosh.shilimkar@ti.com, rnayak@ti.com

On Wed, Apr 18, 2012 at 1:45 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi Tarun
>
> On Wed, 18 Apr 2012, DebBarma, Tarun Kanti wrote:
>
>> That' right, I confirmed that clk_get(NULL, "fck") does not work.
>
> Yes, you and Beno=EEt are right, I should have looked more closely at=
 what
> was being patched.
>
>> For this to work we need the dev pointer in place of NULL.
>> What is your alternate suggestion? Thanks.
>
> Rather than accessing the struct omap_hwmod field directly,
> please, in a separate patch against omap_hwmod.c, create a function t=
o
> return the main clock. =A0Something like "omap_hwmod_get_main_clk()".
Sure. Thanks you.
--
Tarun
>
>
> - Paul
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
