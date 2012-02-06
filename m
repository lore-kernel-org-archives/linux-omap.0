From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: Gumstix Overo: linux-omap newer than 2.6.36 does not boot
Date: Mon, 6 Feb 2012 18:08:50 +0200
Message-ID: <CANOLnONFXoGzs7ZpVf4J3-E-fdhFf8ygMWu68_qMN_OWRVGj=w@mail.gmail.com>
References: <4F2FF18F.2070801@uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60937 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755353Ab2BFQIv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Feb 2012 11:08:51 -0500
Received: by iacb35 with SMTP id b35so8694184iac.19
        for <linux-omap@vger.kernel.org>; Mon, 06 Feb 2012 08:08:50 -0800 (PST)
In-Reply-To: <4F2FF18F.2070801@uni-dortmund.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Klute <thomas2.klute@uni-dortmund.de>
Cc: linux-omap@vger.kernel.org

On Mon, Feb 6, 2012 at 5:28 PM, Thomas Klute
<thomas2.klute@uni-dortmund.de> wrote:
> Hi,
>
> I'm working with various Gumstix Overo boards (OMAP 35XX) and found t=
hat
> kernel versions from the linux-omap tree newer than 2.6.36 fail to bo=
ot
> on the Overo, as in no output after "Uncompressing Linux... done,
> booting the kernel." See attached for the complete serial console out=
put
> (latest 3.3 git version as of this writing, using omap2plus_defconfig=
).

OMAP serial driver changed around that time.
Do you pass correct console through bootags, like
console=3DttyO2,115200n8 (instead of ttyS*)?


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
