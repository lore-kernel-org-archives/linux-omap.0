From: "Gross, Andy" <andy.gross@ti.com>
Subject: Re: [PATCH] omap2+: add drm device
Date: Thu, 24 May 2012 09:22:03 -0500
Message-ID: <CABT81Pio1Kyd1rXo-MQDK8MGbmwBHTEZsgZWV+nUno_AB2Nh5w@mail.gmail.com>
References: <1337803690-30116-1-git-send-email-andy.gross@ti.com>
	<1337839294.2764.7.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:51948 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932227Ab2EXOWJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 May 2012 10:22:09 -0400
Received: by lbok6 with SMTP id k6so7287173lbo.4
        for <linux-omap@vger.kernel.org>; Thu, 24 May 2012 07:22:03 -0700 (PDT)
In-Reply-To: <1337839294.2764.7.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, greg@kroah.com, rob@ti.com

On Thu, May 24, 2012 at 1:01 AM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
>> +struct omap_drm_platform_data {
>> + =A0 =A0 struct omap_kms_platform_data *kms_pdata;
>> +};
>
> This one is missing struct omap_dmm_platform_data *dmm_pdata, so you
> didn't just move the struct. Is that on purpose?

Good point.  I can clean that up.


Andy
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
