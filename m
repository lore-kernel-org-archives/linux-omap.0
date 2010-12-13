From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: Re: Inconsistent lock state caused by omap_mbox_msg_send() called
 from tidspbridge
Date: Mon, 13 Dec 2010 14:59:42 -0600
Message-ID: <AANLkTi=mD2QjLzEHo02cLQCaXuGg9815BGvrTFLc7TNc@mail.gmail.com>
References: <201012121344.51245.laurent.pinchart@ideasonboard.com>
	<1292163339.2375.2.camel@atlantis.mindbit.ro>
	<AANLkTimKQmrk+zw_kO2pjYY_6Oz3DW8EQQhfUCYRkpNa@mail.gmail.com>
	<201012131745.54766.laurent.pinchart@ideasonboard.com>
	<AANLkTinrGm5q=ZDY=8AY0AW+wtvFS_zCXLjWoH-Xbt3o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:36755 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753086Ab0LMU7o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Dec 2010 15:59:44 -0500
Received: by mail-pv0-f177.google.com with SMTP id 7so1930539pvg.22
        for <linux-omap@vger.kernel.org>; Mon, 13 Dec 2010 12:59:43 -0800 (PST)
In-Reply-To: <AANLkTinrGm5q=ZDY=8AY0AW+wtvFS_zCXLjWoH-Xbt3o@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ionut Nicu <ionut.nicu@mindbit.ro>, linux-omap@vger.kernel.org

On Mon, Dec 13, 2010 at 2:49 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Mon, Dec 13, 2010 at 6:45 PM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> >> On Sun, Dec 12, 2010 at 4:15
> PM, Ionut Nicu <ionut.nicu@mindbit.ro> wrote:
>>> > I noticed this too, but this patch should fix it:
>>> >
>>> > https://patchwork.kernel.org/patch/365292/
>>>
>>> True. And in this patch the move to spin_lock_bh() is justifiable,
>>> too, since it adds a sending path which is parallel to the mailbox
>>> tasklet.
>>
>> Is this patch set ready for inclusion in the mainline kernel, or does it need
>> to be reworked ?
>
> Better let Hari answer this one.
>

Yes, it is set to go into mainline kernel.


Thank you,
Best regards,
Hari Kanigeri
