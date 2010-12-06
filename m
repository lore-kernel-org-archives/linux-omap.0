From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH v4 1/3] staging: tidspbridge: fix mgr_enum_node_info
Date: Mon, 6 Dec 2010 02:56:02 -0600
Message-ID: <AANLkTimTr6srsmuanwL6L68vo-UzGoos=CS-x_AMAnpq@mail.gmail.com>
References: <1288976510-25470-1-git-send-email-ionut.nicu@mindbit.ro>
	<1288976510-25470-2-git-send-email-ionut.nicu@mindbit.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:52791 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751643Ab0LFI4F convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Dec 2010 03:56:05 -0500
Received: by mail-iw0-f178.google.com with SMTP id 1so17016208iwn.37
        for <linux-omap@vger.kernel.org>; Mon, 06 Dec 2010 00:56:02 -0800 (PST)
In-Reply-To: <1288976510-25470-2-git-send-email-ionut.nicu@mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ionut Nicu <ionut.nicu@gmail.com>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

On Fri, Nov 5, 2010 at 12:01 PM, Ionut Nicu <ionut.nicu@gmail.com> wrot=
e:
> From: Felipe Contreras <felipe.contreras@gmail.com>
>
> The current code was always returning a non-zero status value
> to userspace applications when this ioctl was called.
>
> The error code was ENODATA, which isn't actually an error,
> it's always returned by dcd_enumerate_object() when it hits the
> end of list.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
> =A0drivers/staging/tidspbridge/rmgr/mgr.c | =A0 =A05 +++++
> =A01 files changed, 5 insertions(+), 0 deletions(-)


Pushed to dspbridge.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
