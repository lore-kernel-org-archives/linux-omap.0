From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v4 0/1] Put the OMAP2 SPI CS in inactive state when
 returning from suspend
Date: Fri, 12 Nov 2010 18:07:43 -0700
Message-ID: <AANLkTimH7_WYHpQAGuyM7j3kisU1N2Q1Vtcr-Si-Ktf0@mail.gmail.com>
References: <4CDDD14B.1010706@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63524 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474Ab0KMBIF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Nov 2010 20:08:05 -0500
Received: by iwn10 with SMTP id 10so4119098iwn.19
        for <linux-omap@vger.kernel.org>; Fri, 12 Nov 2010 17:08:03 -0800 (PST)
In-Reply-To: <4CDDD14B.1010706@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, spi-devel-general <spi-devel-general@lists.sourceforge.net>, David Brownell <dbrownell@users.sourceforge.net>, Kevin Hilman <khilman@deeprootsystems.com>

On Fri, Nov 12, 2010 at 4:44 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> We notice that when system wake up from OFF mode, then CS is in inact=
ive
> state until the first SPI transfer.
> For our design it lead to some conflict on this I/O.
> Inactive state for CS when there is no transfer should be the correct
> behavior: this is the purpose of these patches.
>
> * Change from v3:
> Patch clean-up according to Kevin Hilman and checkpatch.
> Now force CS to be in inactive state only if it was inactive when it =
was
> suspended.
>
> Gregory CLEMENT (1):
> =A0OMAP2: Spi: Force CS to be in inactive state after off-mode
> =A0 =A0transition
>
> =A0drivers/spi/omap2_mcspi.c | =A0 35 +++++++++++++++++++++++++++++++=
++++
> =A01 files changed, 35 insertions(+), 0 deletions(-)

Hi Gregory,

If you've only got one patch then please put all the explanation text
into the patch description.  Using a cover letter like this is only
useful when describing the context for a series (more than 1) of
patches.  Also, revision history should always be in patch
description, regardless of whether or not there is a cover letter (at
least for the subsystems that I maintain.  Otherwise, it is too easy
for vital information to get separated from the patch.

Thanks,
g.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
