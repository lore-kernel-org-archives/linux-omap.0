From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH] staging: tidspbridge: use the right type for list_is_last
Date: Mon, 13 Dec 2010 21:50:11 -0600
Message-ID: <AANLkTikxLfYDYmqv=0vQ2U88XSn+ruLdyfxkAYorMx5w@mail.gmail.com>
References: <1291846823-31513-1-git-send-email-omar.ramirez@ti.com>
	<201012121302.07970.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:46965 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757038Ab0LNDuM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Dec 2010 22:50:12 -0500
Received: by gye5 with SMTP id 5so108361gye.4
        for <linux-omap@vger.kernel.org>; Mon, 13 Dec 2010 19:50:11 -0800 (PST)
In-Reply-To: <201012121302.07970.laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, Rene Sapiens <rene.sapiens@ti.com>, Ernesto Ramos <ernesto@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ionut Nicu <ionut.nicu@gmail.com>

On Sun, Dec 12, 2010 at 6:02 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Omar,
>
> On Wednesday 08 December 2010 23:20:23 Omar Ramirez Luna wrote:
>> Removes the following warning:
>>
>> =A0 CC [M] =A0drivers/staging/tidspbridge/rmgr/rmm.o
>> drivers/staging/tidspbridge/rmgr/rmm.c: In function 'rmm_alloc':
>> drivers/staging/tidspbridge/rmgr/rmm.c:147: warning: passing
>> =A0 =A0 =A0 argument 1 of 'list_is_last' from incompatible pointer t=
ype
>> include/linux/list.h:170: note: expected 'const struct list_head *'
>> =A0 =A0 =A0 but argument is of type 'struct rmm_ovly_sect *'
>
> I was about to send the same patch.
>
>> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Great, thanks Laurent, Ionut for the review.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
