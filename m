From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH 1/2] staging: tidspbridge: rmgr/node.c code cleanup
Date: Wed, 22 Dec 2010 12:07:39 -0600
Message-ID: <AANLkTim77Y6VZW7Dec2cWn3gGNwbSK0ufs2CH9SsSysM@mail.gmail.com>
References: <1291931258-30744-1-git-send-email-ionut.nicu@mindbit.ro>
	<1291931258-30744-2-git-send-email-ionut.nicu@mindbit.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:59521 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753315Ab0LVSHk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Dec 2010 13:07:40 -0500
Received: by mail-gx0-f170.google.com with SMTP id 20so3161519gxk.15
        for <linux-omap@vger.kernel.org>; Wed, 22 Dec 2010 10:07:40 -0800 (PST)
In-Reply-To: <1291931258-30744-2-git-send-email-ionut.nicu@mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ionut Nicu <ionut.nicu@gmail.com>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Sapiens Rene <rene.sapiens@ti.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Ionut Nicu <ionut.nicu@mindbit.ro>

On Thu, Dec 9, 2010 at 3:47 PM, Ionut Nicu <ionut.nicu@gmail.com> wrote=
:
> Reorganized some code in rmgr/node.c to increase its
> readability. Most of the changes reduce the code
> indentation level and simplifiy the code. No functional
> changes were done.
>
> Signed-off-by: Ionut Nicu <ionut.nicu@mindbit.ro>
> ---
> =A0drivers/staging/tidspbridge/rmgr/node.c | =A0607 ++++++++++++++---=
-------------
> =A01 files changed, 283 insertions(+), 324 deletions(-)

Pushed to dspbridge.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
