From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: USB-ehci enumeration issue
Date: Tue, 17 May 2011 13:08:39 +0530
Message-ID: <BANLkTim04vsyPcKqGEgv1CUH_qOaFv7mpg@mail.gmail.com>
References: <BANLkTin1WEd0KeUb7kZ80GAYbEQC3SkezA@mail.gmail.com>
	<20110502095647.GU2529@legolas.emea.dhcp.ti.com>
	<BANLkTi=6gyWG3Dww_uY89vDW_P6zGV=N9w@mail.gmail.com>
	<20110516134109.GF11339@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:57831 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752624Ab1EQHil convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 May 2011 03:38:41 -0400
Received: by mail-bw0-f51.google.com with SMTP id 10so259984bwz.10
        for <linux-omap@vger.kernel.org>; Tue, 17 May 2011 00:38:40 -0700 (PDT)
In-Reply-To: <20110516134109.GF11339@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, linux-omap@vger.kernel.org

On Mon, May 16, 2011 at 7:11 PM, Felipe Balbi <balbi@ti.com> wrote:
>
> Hi,
>
> On Sun, May 15, 2011 at 06:21:31PM +0530, ABRAHAM, KISHON VIJAY wrote=
:
> > > > Does anyone else observe this issue?
> > >
> > > could be the regulators problem. Can you try with my hci branch ?
> > >
> > > git://gitorious.org/usb/usb.git hci
> > >
> >
> > =A0 =A0saw the issue even in this tree/branch.
>
> Keshava ? Do you have any patch fixing this ?
>

Kishon
please ensure that you have all the patches to make ehci /ohci to make
working omap4 and omap3 sdp boards.
you can find them here: =A0 git://gitorious.org/~kmg/mirrors/linux-ehci=
-ohci
get the latest branch : =A0kmg-39-rc6-omap4

~kmg/mirrors/linux-ehci-ohci:kmg-39-rc6-omap4

keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
