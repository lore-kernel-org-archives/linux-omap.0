From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: dmtimer: cleanup fclk usage
Date: Wed, 18 Apr 2012 02:15:41 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204180213330.29048@utopia.booyaka.com>
References: <1334579125-15566-1-git-send-email-tarun.kanti@ti.com> <1334579125-15566-4-git-send-email-tarun.kanti@ti.com> <alpine.DEB.2.00.1204161034290.29048@utopia.booyaka.com> <4F8C864B.4090101@ti.com>
 <CAC83ZvJ=TsDvs-pVZP1PyLFQY=nLh48tDE8SYQFxrLOUD-3aHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-449549567-1334736941=:29048"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39006 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072Ab2DRIPm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Apr 2012 04:15:42 -0400
In-Reply-To: <CAC83ZvJ=TsDvs-pVZP1PyLFQY=nLh48tDE8SYQFxrLOUD-3aHQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, santosh.shilimkar@ti.com, rnayak@ti.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-449549567-1334736941=:29048
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Tarun

On Wed, 18 Apr 2012, DebBarma, Tarun Kanti wrote:

> That' right, I confirmed that clk_get(NULL, "fck") does not work.

Yes, you and Beno=EEt are right, I should have looked more closely at what=
=20
was being patched.

> For this to work we need the dev pointer in place of NULL.
> What is your alternate suggestion? Thanks.

Rather than accessing the struct omap_hwmod field directly,=20
please, in a separate patch against omap_hwmod.c, create a function to=20
return the main clock.  Something like "omap_hwmod_get_main_clk()".


- Paul
--155748971-449549567-1334736941=:29048--
