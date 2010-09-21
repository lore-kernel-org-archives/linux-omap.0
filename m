From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP: hwmod: Enable module wakeup if in smartidle
Date: Tue, 21 Sep 2010 13:09:32 -0700
Message-ID: <878w2uj1tv.fsf@deeprootsystems.com>
References: <1285079310-15888-1-git-send-email-rnayak@ti.com>
	<alpine.DEB.2.00.1009211400460.4677@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:61266 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131Ab0IUUJf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 16:09:35 -0400
Received: by pxi10 with SMTP id 10so1556967pxi.19
        for <linux-omap@vger.kernel.org>; Tue, 21 Sep 2010 13:09:35 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1009211400460.4677@utopia.booyaka.com> (Paul
	Walmsley's message of "Tue, 21 Sep 2010 14:02:48 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, Partha Basak <p-basak2@ti.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>

Paul Walmsley <paul@pwsan.com> writes:

> Hi Rajendra,
>
> On Tue, 21 Sep 2010, Rajendra Nayak wrote:
>
>> If a module's OCP slave port is programmed to be in smartidle,
>> its also necessary that they have module level wakeup enabled.
>> Update _sysc_enable in hwmod framework to do this.
>
> Thanks, queued for 2.6.37 with a slightly modified changelog.  One br=
ief=20
> comment:
>
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> Signed-off-by: Partha Basak <p-basak2@ti.com>
>> Signed-off-by: Beno????t Cousson <b-cousson@ti.com>
>
> Looks like something in your mail path is mangling 8-bit characters..=
=2E=20
> fixed in the queued version.
>
>
> - Paul
>
>
> From: Rajendra Nayak <rnayak@ti.com>
> Date: Tue, 21 Sep 2010 19:58:30 +0530
> Subject: [PATCH] OMAP: hwmod: Enable module wakeup if in smartidle
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> If a module's OCP slave port is programmed to be in smartidle,
> its also necessary that they have module level wakeup enabled.
> Update _sysc_enable in hwmod framework to do this.
>
> The thread "[PATCH 7/8] : Hwmod api changes" archived here:
>
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg34212.html
>
> has additional technical information on the rationale of this patch.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Partha Basak <p-basak2@ti.com>
> Signed-off-by: Beno=EEt Cousson <b-cousson@ti.com>
> [paul@pwsan.com: revised patch description]
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>

=46WIW

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

as I'm using this for testing the various hwmod conversions.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
