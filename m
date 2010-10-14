From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [Patch] ADS7846: Changing chip detection channel due to improper detection
Date: Thu, 14 Oct 2010 14:14:35 +0300
Message-ID: <AANLkTikewuuZSTr_Fyfd=0c1YXGWEcteJUuCcC=53ebB@mail.gmail.com>
References: <8959501C0BAF9F40956CEBAD13FB297F17F38C759B@EINTMBX.einet.ad.eivd.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:50538 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752815Ab0JNLOn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Oct 2010 07:14:43 -0400
Received: by qyk5 with SMTP id 5so1751075qyk.19
        for <linux-omap@vger.kernel.org>; Thu, 14 Oct 2010 04:14:38 -0700 (PDT)
In-Reply-To: <8959501C0BAF9F40956CEBAD13FB297F17F38C759B@EINTMBX.einet.ad.eivd.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: GERBER Patrick <Patrick.Gerber@heig-vd.ch>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "imre.deak@nokia.com" <imre.deak@nokia.com>

On Wed, Oct 13, 2010 at 5:47 PM, GERBER Patrick
<Patrick.Gerber@heig-vd.ch> wrote:
> Hello,
>
> I am using the TSC2046 (newer ADS7846 silicon) on a custom design whe=
re the AUX input is not used and so pulled to GND.
> The ADS7846 =A0driver is using the value of the AUX input to detect i=
f a chip is connected or not. If the AUX value is 0x000 or 0xFFF the dr=
iver think that there is no chip.
> In my case due to the fact that the AUX input is =A0pulled to GND the=
 0x000 value is normal.
>
> Therefore I suggest to use the temp1 channel instead of the AUX chann=
el. The temperature will probably never be 0x000.

What kernel is this against?  Mainline doesn't seem to have this code.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
