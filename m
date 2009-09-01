From: matthias schwarz <matthias.schw@googlemail.com>
Subject: Re: Question on ISPs CFA interpolation coefficients
Date: Tue, 1 Sep 2009 13:30:36 +0200
Message-ID: <a187869d0909010430s316d07fcoe2c0cb411e72b841@mail.gmail.com>
References: <4A96EF2A.9090204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:35764 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753758AbZIALaf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Sep 2009 07:30:35 -0400
Received: by bwz19 with SMTP id 19so3439177bwz.37
        for <linux-omap@vger.kernel.org>; Tue, 01 Sep 2009 04:30:36 -0700 (PDT)
In-Reply-To: <4A96EF2A.9090204@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

2009/8/27 Matthias Schwarz <matthias.schw@googlemail.com>:
> Hi all,
>
> i just wondered how the camera interface's, especially the previewer
> module's CFA coefficients are setup on OMAP3530.
>
> The TRM also does not give too much information about it:
>>
>> In the generic mode, CFA interpolation is implemented using programm=
able
>> filter coefficients that operate
>> on a 5x5 grid:
>> =B7 Each coefficient is coded in S8Q6 format.
>> =B7 Each output color , G, and B) has its own set of coefficients.
>> =B7 There are 4 phases. Each pixel is associated with a phase.
>> =B7 Different sets of filter coefficients are provided, depending on=
 the
>> tendency (gradient in the data:
>> horizontal, vertical, or neutral).
>> =B7 So there are 3 color x 4 phase x 3 tendencies x 16 taps =3D 576
>> coefficients (each coefficient is 8 bits
>> wide).
>> Note: Coefficients are based on sensor type. However, users can use =
a
>> different methods of
>> defining an optimal coefficient set.
>
> Also drivers/media/video/isp/cfa_coef_table.h does not provide inform=
ation
> on what the inserted values mean and how they are arrenged.
>
> My question now is: is there anyone on the list who would provide me =
with
> information on how to compose these coefficients correctly?
>
> Thank you very much,
> Matthias
>

What i guess from no answers is that this part clearly lacks
information. I also created a thread in TI's e2e forums:
http://e2e.ti.com/forums/t/9565.aspx

Best regards,
Matthias
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
