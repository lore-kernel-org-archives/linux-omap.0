From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: OMAP 3530 McBSP Frame Sync errors
Date: Mon, 13 Sep 2010 12:07:20 +0300
Message-ID: <AANLkTik9ULkprMe9=qGAZj8P0HdaFq9TPfNUGxmBmcwc@mail.gmail.com>
References: <4C8903CA.9090501@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:63560 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754481Ab0IMJHV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Sep 2010 05:07:21 -0400
Received: by qyk33 with SMTP id 33so5007829qyk.19
        for <linux-omap@vger.kernel.org>; Mon, 13 Sep 2010 02:07:20 -0700 (PDT)
In-Reply-To: <4C8903CA.9090501@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Sep 9, 2010 at 6:56 PM, Gary Thomas <gary@mlbassoc.com> wrote:
> I'm trying to use McBSP4 with an external CODEC which is a
> slave device (i.e. the OMAP generates the Frame Sync pulses)
> In this mode, the BSP is purely the master of these signals.
>
> What can it possibly mean to get Frame Sync errors in this case
> (I'm reading from the external CODEC)?
>
> FYI, my registers look like this:
> =A0PCR0: 0x00000f0f
> =A0RCR1: 0x00000040, RCR2: 0x00008041
> =A0XCR1: 0x00000040, XCR2: 0x00008041
> =A0SRGR1: 0x00000f07, SRGR2: 0x0000101f
>
> Any ideas or help?

Have you set the right McBSP source clock? It's in DEVCONF1/2 registers=
=2E

>
> --
> ------------------------------------------------------------
> Gary Thomas =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0Consulting for the
> MLB Associates =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0Embedded world
> ------------------------------------------------------------
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
