From: Matthias Schwarz <matthias.schw@googlemail.com>
Subject: Question on ISPs CFA interpolation coefficients
Date: Thu, 27 Aug 2009 22:40:10 +0200
Message-ID: <4A96EF2A.9090204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f206.google.com ([209.85.219.206]:44924 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588AbZH0UkN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Aug 2009 16:40:13 -0400
Received: by ewy2 with SMTP id 2so1586197ewy.17
        for <linux-omap@vger.kernel.org>; Thu, 27 Aug 2009 13:40:14 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi all,

i just wondered how the camera interface's, especially the previewer=20
module's CFA coefficients are setup on OMAP3530.

The TRM also does not give too much information about it:
> In the generic mode, CFA interpolation is implemented using=20
> programmable filter coefficients that operate
> on a 5x5 grid:
> =B7 Each coefficient is coded in S8Q6 format.
> =B7 Each output color , G, and B) has its own set of coefficients.
> =B7 There are 4 phases. Each pixel is associated with a phase.
> =B7 Different sets of filter coefficients are provided, depending on =
the=20
> tendency (gradient in the data:
> horizontal, vertical, or neutral).
> =B7 So there are 3 color x 4 phase x 3 tendencies x 16 taps =3D 576=20
> coefficients (each coefficient is 8 bits
> wide).
> Note: Coefficients are based on sensor type. However, users can use a=
=20
> different methods of
> defining an optimal coefficient set.

Also drivers/media/video/isp/cfa_coef_table.h does not provide=20
information on what the inserted values mean and how they are arrenged.

My question now is: is there anyone on the list who would provide me=20
with information on how to compose these coefficients correctly?

Thank you very much,
Matthias
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
