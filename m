From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 2/7] OMAP2+: mux: Enable wakeup for wakeup enable
 requested pads
Date: Wed, 9 Mar 2011 17:36:12 +0530
Message-ID: <AANLkTin6kv7apsWtGUubDRcH5JAfL0Kx5cDi5GQjKU1q@mail.gmail.com>
References: <1299064343-28534-1-git-send-email-govindraj.raja@ti.com>
 <87lj0u8mrf.fsf@ti.com> <87tyfi49cs.fsf@ti.com> <AANLkTiknEQrqUt1-sY6-aDw4R5ZMP2uErSjRNB5Yex_v@mail.gmail.com>
 <alpine.DEB.2.00.1103081220140.10981@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37720 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932113Ab1CIMGe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Mar 2011 07:06:34 -0500
In-Reply-To: <alpine.DEB.2.00.1103081220140.10981@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, r.sricharan@ti.com, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>

On Wed, Mar 9, 2011 at 12:51 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> By the way, if your patch relies on OMAP_DEVICE_PAD_IDLE, you should
> probably sync up with Sricharan, who is apparently planning to remove=
 that
> flag:
>

currently I am dependent on OMAP_DEVICE_PAD_WAKEUP flag.
I am not using OMAP_DEVICE_PAD_IDLE as of now.

--
Thanks,
Govindraj.R


> =A0 http://www.mail-archive.com/linux-omap@vger.kernel.org/msg46296.h=
tml
>
>
> - Paul
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
