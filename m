From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 2/2 v4] OMAP2+: hwmod: Add API to check IO PAD wakeup status
Date: Mon, 4 Jul 2011 10:38:55 +0530
Message-ID: <CAAL8m4xRe7z3N=2t2o=JpXC6kLXU9WGsr4ujdHBCp_Uno2f1xg@mail.gmail.com>
References: <1309603946-25395-1-git-send-email-govindraj.raja@ti.com>
 <1309603946-25395-3-git-send-email-govindraj.raja@ti.com> <alpine.DEB.2.00.1107021037040.8874@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34586 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944Ab1GDFJQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Jul 2011 01:09:16 -0400
Received: by bwd5 with SMTP id 5so3798992bwd.19
        for <linux-omap@vger.kernel.org>; Sun, 03 Jul 2011 22:09:15 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1107021037040.8874@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Tero Kristo <t-kristo@ti.com>

On Sat, Jul 2, 2011 at 10:07 PM, Paul Walmsley <paul@pwsan.com> wrote:
> On Sat, 2 Jul 2011, Govindraj.R wrote:
>
>> +int omap_hmwod_pad_get_wakeup_status(struct omap_hwmod *oh)
> =A0 =A0 =A0 =A0 =A0 =A0^^^^^
>
> should be "hwmod"

corrected and re-posted both patches.

http://permalink.gmane.org/gmane.linux.ports.arm.omap/60250

http://permalink.gmane.org/gmane.linux.ports.arm.omap/60252

--
Thanks,
Govindraj.R


>
>
> - Paul
>
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
