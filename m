From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH 3/6] arm: omap4: support pmu
Date: Wed, 16 May 2012 18:12:06 +0800
Message-ID: <CACVXFVNsniPK0-5bU8+8iZeA1JD5WD1refn37nnArq6cGs5=MA@mail.gmail.com>
References: <1336599350-10944-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:58097 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759918Ab2EPKMK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 May 2012 06:12:10 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1SUbDE-00012I-7x
	for linux-omap@vger.kernel.org; Wed, 16 May 2012 10:12:08 +0000
Received: by dady13 with SMTP id y13so778677dad.19
        for <linux-omap@vger.kernel.org>; Wed, 16 May 2012 03:12:06 -0700 (PDT)
In-Reply-To: <1336599350-10944-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Woodruff Richard <r-woodruff2@ti.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>

On Thu, May 10, 2012 at 5:35 AM, Jon Hunter <jon-hunter@ti.com> wrote:

> +
> + =A0 =A0 =A0 /*configure CTI0 for pmu irq routing*/
> + =A0 =A0 =A0 cti_init(&omap4_cti[0], base0, OMAP44XX_IRQ_CTI0, 6);
> + =A0 =A0 =A0 cti_unlock(&omap4_cti[0]);
> + =A0 =A0 =A0 cti_map_trigger(&omap4_cti[0], 1, 6, 2);
> +
> + =A0 =A0 =A0 /*configure CTI1 for pmu irq routing*/
> + =A0 =A0 =A0 cti_init(&omap4_cti[1], base1, OMAP44XX_IRQ_CTI1, 6);
> + =A0 =A0 =A0 cti_unlock(&omap4_cti[1]);
> + =A0 =A0 =A0 cti_map_trigger(&omap4_cti[1], 1, 6, 2);

As pointed in another thread, the above line should be changed to below=
:

             cti_map_trigger(&omap4_cti[1], 1, 6, 3);

which can avoid irq flood issue at high frequency sample mode.
=46or detailed description about the issue and fix, see below link:

      http://permalink.gmane.org/gmane.linux.linaro.devel/10532


Thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
