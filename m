From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: Inconsistent lock state caused by omap_mbox_msg_send() called
 from tidspbridge
Date: Mon, 13 Dec 2010 22:49:24 +0200
Message-ID: <AANLkTinrGm5q=ZDY=8AY0AW+wtvFS_zCXLjWoH-Xbt3o@mail.gmail.com>
References: <201012121344.51245.laurent.pinchart@ideasonboard.com>
 <1292163339.2375.2.camel@atlantis.mindbit.ro> <AANLkTimKQmrk+zw_kO2pjYY_6Oz3DW8EQQhfUCYRkpNa@mail.gmail.com>
 <201012131745.54766.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f194.google.com ([209.85.214.194]:46289 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755376Ab0LMUtq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Dec 2010 15:49:46 -0500
Received: by iwn42 with SMTP id 42so3392896iwn.1
        for <linux-omap@vger.kernel.org>; Mon, 13 Dec 2010 12:49:46 -0800 (PST)
In-Reply-To: <201012131745.54766.laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: Ionut Nicu <ionut.nicu@mindbit.ro>, linux-omap@vger.kernel.org

On Mon, Dec 13, 2010 at 6:45 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> >> On Sun, Dec 12, 2010 at 4:15
PM, Ionut Nicu <ionut.nicu@mindbit.ro> wrote:
>> > I noticed this too, but this patch should fix it:
>> >
>> > https://patchwork.kernel.org/patch/365292/
>>
>> True. And in this patch the move to spin_lock_bh() is justifiable,
>> too, since it adds a sending path which is parallel to the mailbox
>> tasklet.
>
> Is this patch set ready for inclusion in the mainline kernel, or does=
 it need
> to be reworked ?

Better let Hari answer this one.

>
> --
> Regards,
>
> Laurent Pinchart
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
