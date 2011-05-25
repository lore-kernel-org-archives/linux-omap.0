From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: Self modifying code in ARM 11 architectures
Date: Wed, 25 May 2011 13:18:37 +0530
Message-ID: <BANLkTinrj-dkJShzTQuhYSOWkK4QSEnQgQ@mail.gmail.com>
References: <BANLkTi=mVsYiubqtJO2BmWvExMvUFRg6dg@mail.gmail.com> <BANLkTimyju7eEgtCpb_U6s8LNHk-_FGK4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33023 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755026Ab1EYHs6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 May 2011 03:48:58 -0400
In-Reply-To: <BANLkTimyju7eEgtCpb_U6s8LNHk-_FGK4Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ashok Babu <ashok3d@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

CC'ing correct ARM mailing list.

On Tue, May 24, 2011 at 3:48 PM, Ashok Babu <ashok3d@gmail.com> wrote:
> Hi All,
>
> I am no success in booting up the ARM1176 processor with the
> linux-2.6.32 kernel.
> While googling about the ARM=A0Harvard=A0architecture, I came to know=
 that
> we have to flush/invalidate the D-Cache and I-Cache
> when using the self modifying codes.
>
> So here my questions/doubts :
> 1) Is'nt it the kernel itself is self modifying code with lots of
> function pointers ?
> =A0 =A0 If yes, how is synchronization b/w d-cache and i-cache handle=
d in
> the kernel ?
> 2) Can this be the reason for the kernel not booting for me ?
> =A0 =A0 Because If i disable the I-Cache in the config, then the kern=
el
> boots up without any issues.
> Any pointers on this will be of great help.
>
> Thanks & Best Regards
> Ashok
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Regards,
Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
