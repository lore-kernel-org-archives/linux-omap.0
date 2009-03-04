From: twebb <taliaferro62@gmail.com>
Subject: Re: omap35x mmc support
Date: Wed, 4 Mar 2009 09:00:39 -0500
Message-ID: <dbdb2ea60903040600k5e6464d9o9fefd8ab2796680f@mail.gmail.com>
References: <dbdb2ea60903030751u773b8a82x1ec9b8a5886b0672@mail.gmail.com>
	 <200903031559.26946.david-b@pacbell.net> <49AE4791.2080202@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:57461 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbZCDOAm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Mar 2009 09:00:42 -0500
Received: by qw-out-2122.google.com with SMTP id 5so4944770qwi.37
        for <linux-omap@vger.kernel.org>; Wed, 04 Mar 2009 06:00:40 -0800 (PST)
In-Reply-To: <49AE4791.2080202@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: David Brownell <david-b@pacbell.net>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, Grazvydas Ignotas <notasas@gmail.com>

>
> For MMC3 this patch:
>
> =A0 http://lkml.org/lkml/2009/1/27/101
>
> seems to be missing.
>

Thanks.  Would this patch be applicable whether MMC3 is functioning as
SD or MMC or SDIO interface?

And on a bit of a tangent (but relevant to the link you provided),
what's the logic behind so many OMAP24XX references being used in
OMAP34XX (and even 35xx) code?  I'm sure there's a good reason; but
being new to using an OMAP processor (35xx), I'm just curious what it
is.  It gets confusing, particularly without knowing the reasoning
behind it.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
