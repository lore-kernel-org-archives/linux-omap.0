From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 0/2] OMAP3 IOMMU fixes
Date: Mon, 13 Jun 2011 22:34:14 +0300
Message-ID: <BANLkTi=UNc-XyC4tVBkO0PQw8Tcy8xo=Yg@mail.gmail.com>
References: <1306759629-17232-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <201106081248.01793.laurent.pinchart@ideasonboard.com> <20110613134034.GE3352@atomide.com>
 <201106131841.08465.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37452 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443Ab1FMTef convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Jun 2011 15:34:35 -0400
Received: by wwa36 with SMTP id 36so5158288wwa.1
        for <linux-omap@vger.kernel.org>; Mon, 13 Jun 2011 12:34:34 -0700 (PDT)
In-Reply-To: <201106131841.08465.laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, teemu.tuominen@cybercom.com

On Mon, Jun 13, 2011 at 7:41 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> > > Laurent Pinchart (2):
=2E..
>> > > =A0 omap3: iovmm: Support non page-aligned buffers in iommu_vmap
=2E..
> OK. Ohad, could you please apply this patch to your tree and submit i=
t with
> the whole series for 3.1 ?

Sure I can. I'll make sure it goes in once we reach drivers/.

Thanks,
Ohad.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
