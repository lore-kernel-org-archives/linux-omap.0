From: Enrico <ebutera@users.sourceforge.net>
Subject: Re: YUV422 input to CPI?
Date: Mon, 23 Apr 2012 09:31:08 +0200
Message-ID: <CA+2YH7uMbYp4omUvCxHhaDdeeTWG064xaMBu8=zsjZzRoZZ-Ug@mail.gmail.com>
References: <E47FC7FC-B1CC-4E8A-9957-AEAF483DDAFA@pg.canterbury.ac.nz>
	<CA+2YH7vpCdXhJUQrsZ+3Tp=b5q=3su1K4TaEumWGeMeCZXpvyw@mail.gmail.com>
	<79CD15C6BA57404B839C016229A409A83E9F8032@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:33827 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753885Ab2DWHbJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Apr 2012 03:31:09 -0400
Received: by vcqp1 with SMTP id p1so7776441vcq.19
        for <linux-omap@vger.kernel.org>; Mon, 23 Apr 2012 00:31:08 -0700 (PDT)
In-Reply-To: <79CD15C6BA57404B839C016229A409A83E9F8032@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sun, Apr 22, 2012 at 4:11 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
> During one of the internal releases, I have added YUV (BT656) support, it is
> based on 2.6.37 based kernel, but still it will give you pointer and help
> you to change the code to get support for the same.
>
> I have created separate, clean and independent patches for
> adding support for BT656 YUV support.
>
> http://arago-project.org/git/projects/?p=linux-omap3.git;a=history;f=drivers/media/video/isp;hb=20c003f2f024d9f50f59edf9f1b8f5f035fb15b8

>From the known issue:

"- stream on works with interlaced artifacts on screen"

Do you know if it's possible to do something in hardware for this?
Right now i'm doing software deinterlacing, maybe something can be
done in omap3 isp or tvp5151?

Enrico
