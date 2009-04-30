From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: dss2 and dsi
Date: Thu, 30 Apr 2009 12:54:35 +0300
Message-ID: <6ed0b2680904300254u271520f6uf623e6bc261f1305@mail.gmail.com>
References: <aed62de90904291024s3b90dae5v742c72c4b8bdbe3@mail.gmail.com>
	 <aed62de90904291026t6c18908ax86abfb8343f68a0e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:54915 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762415AbZD3Jyg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Apr 2009 05:54:36 -0400
Received: by fxm2 with SMTP id 2so1703230fxm.37
        for <linux-omap@vger.kernel.org>; Thu, 30 Apr 2009 02:54:35 -0700 (PDT)
In-Reply-To: <aed62de90904291026t6c18908ax86abfb8343f68a0e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rebecca Schultz Zavin <rebecca@android.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

On Wed, Apr 29, 2009 at 8:26 PM, Rebecca Schultz Zavin
<rebecca@android.com> wrote:
> I have a question on the intended use of pan_display v. the
> update_window ioctl in dss2. =A0I'm using a dsi panel and it seems li=
ke
> the only way I can get new data out to the display is by calling
> display->update. =A0The only place that seems to be called is from a
> couple of the ioctls, mainly update_window. =A0Is the intention that =
you
> use update_window to compose the screen? =A0Android uses pan_display =
to
> flip between a front and back copy of the frame buffer, and if it's
> available on the hardware, to send a partial update. =A0On the dss2
> framework those calls never cause anything to be sent to the dsi
> panel. =A0Should we be calling the update_window ioctl?

I think Tomi asked to CC him (added) when mailing about DSS2 issues.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
