From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] regulator: core: if voltage scaling fails, restore
 original
Date: Thu, 13 Dec 2012 05:08:33 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1212130507470.25415@utopia.booyaka.com>
References: <1355312753-16514-1-git-send-email-paolo.pisati@canonical.com> <alpine.DEB.2.00.1212130501260.25415@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-814718820-1355375313=:25415"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1212130501260.25415@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paolo Pisati <paolo.pisati@canonical.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-814718820-1355375313=:25415
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 13 Dec 2012, Paul Walmsley wrote:

> Seems to me, na=EFvely, that in the above code, regulator->min_uV and=20
> regulator->max_uV should be set only after _regulator_do_set_voltage()=20
> succeeds?

Eh, never mind.  Looks like you took a similar strategy in the subsequent=
=20
patch you sent..


- Paul
--843723315-814718820-1355375313=:25415--
