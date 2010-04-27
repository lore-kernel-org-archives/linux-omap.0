From: Juha Kuikka <juha.kuikka@gmail.com>
Subject: Re: OMAP3: Linux Without a Boot Loader?
Date: Mon, 26 Apr 2010 17:22:49 -0700
Message-ID: <i2ra46a26fd1004261722sd0c56aafj90275e805502e9db@mail.gmail.com>
References: <4BD61F7D.3060208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36969 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266Ab0D0AWu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 20:22:50 -0400
Received: by gyg13 with SMTP id 13so6497915gyg.19
        for <linux-omap@vger.kernel.org>; Mon, 26 Apr 2010 17:22:50 -0700 (PDT)
In-Reply-To: <4BD61F7D.3060208@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Greg Ungerer <gerg@snapgear.com>

On Mon, Apr 26, 2010 at 4:19 PM, Nishanth Menon <nm@ti.com> wrote:
>
> The final image looks as follows:
> =A0 =A0 =A0 =A0+---------------------+
> =A0 =A0 =A0 =A0| Configuration =A0 =A0 =A0 |
> =A0 =A0 =A0 =A0| Header =A0 =A0 =A0 =A0 =A0 =A0 =A0|
> =A0 =A0 =A0 =A0+---------------------+
> =A0 =A0 =A0 =A0| "Sty" =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
> =A0 =A0 =A0 =A0+---------------------+
> =A0 =A0 =A0 =A0| kernel piggy =A0 =A0 =A0 =A0|
> =A0 =A0 =A0 =A0| bzImage =A0 =A0 =A0 =A0 =A0 =A0 |
> =A0 =A0 =A0 =A0+---------------------+
>
Looks very interesting! I was thinking of trying something like this
after ELC but unfortunately real work got the better of me.

This Configuration Header stuff looks very similar to what TI's
Davinci-chips use. They call it AIS but from a short dive into
omap-u-boot-utils it is very similar, encoded commands to mask ROM
code to initialize HW and load image(s).

Now I need to find some time to do this with the Beagle.

This may be a stupid question but is the CH format documented somewhere=
?

- Juha
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
