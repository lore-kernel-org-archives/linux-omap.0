From: Suresh Rajashekara <suresh@mistralsolutions.com>
Subject: Re: Problem in Flashing uboot on OSK5912c
Date: Thu, 26 Mar 2009 11:54:47 -0700
Message-ID: <deb0f030903261154l1376c542w681de12c44e8f590@mail.gmail.com>
References: <1237981895-9269-1-git-send-email-Hiroshi.DOYU@nokia.com>
	 <20090326.142359.186318746.Hiroshi.DOYU@nokia.com>
	 <1264B6775E17104A8413A429BBA3A4A96570813E66@SINPUNMBX001.TechMahindra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:51905 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879AbZCZSyt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Mar 2009 14:54:49 -0400
Received: by wf-out-1314.google.com with SMTP id 29so835902wff.4
        for <linux-omap@vger.kernel.org>; Thu, 26 Mar 2009 11:54:47 -0700 (PDT)
In-Reply-To: <1264B6775E17104A8413A429BBA3A4A96570813E66@SINPUNMBX001.TechMahindra.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manoj Kotnala <kotnala@techmahindra.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Try this
http://omap.spectrumdigital.com/osk5912/factoryconfig/

Suresh

On Thu, Mar 26, 2009 at 6:24 AM, Manoj Kotnala <kotnala@techmahindra.co=
m> wrote:
>
> Hi Experts,
>
> Sorry this query is not specific to the kernel but to the OMAP/OSK so=
 am posting it here.
>
> I am having OSK5912 board (rev C).
> I am not getting any boot messages on it.
> I tried the Flash Recovery Utility for OMAP from http://www.celinuxfo=
rum.org/CelfPubWiki/FlashRecoveryUtility
> But I am not able to install the respective driver in WinXP.
> I also tried OSTBoot ver 2.5 from
> http://focus.ti.com/download/wtbu/OSTTools_NoSource_v2_5.zip
> but couldn't succeed.
> It is waiting at "Waiting for USB device to connect" message.
>
> Next I tried the (Open source) OMAP Flash Loader =A0omapfl from
> http://www.celinuxforum.org/CelfPubWiki/FlashRecoveryUtility?action=3D=
AttachFile&do=3Dview&target=3Domapfl-1.0.tar.gz
>
> Again Failed.
>
> I inserted debug messages in omapfl source
> It seems that OSK Board is not even throwing/publishing VendorID and =
Product ID from the board.
>
> Could anyone tell me how recover the board from this stage?
>
> Thanks in Advance,
>
> Manoj Kotnala
>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>
>
> Disclaimer:
>
> This message and the information contained herein is proprietary and =
confidential and subject to the Tech Mahindra policy statement, you may=
 review the policy at <a href=3D"http://www.techmahindra.com/Disclaimer=
=2Ehtml">http://www.techmahindra.com/Disclaimer.html</a> externally and=
 <a href=3D"http://tim.techmahindra.com/Disclaimer.html">http://tim.tec=
hmahindra.com/Disclaimer.html</a> internally within Tech Mahindra.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
