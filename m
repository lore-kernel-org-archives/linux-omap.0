From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: omapfb: no driver for display
Date: Fri, 18 Feb 2011 11:46:55 +0800
Message-ID: <AANLkTikpCcpkjb8i_8Gk5ey1FtgsaUenmKNDhrtjLqon@mail.gmail.com>
References: <AANLkTi=f=SKE=QR97ttPnBrpW=2wNGd03+q4agmu6Uap@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46642 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780Ab1BRDrQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Feb 2011 22:47:16 -0500
Received: by iyj8 with SMTP id 8so3091111iyj.19
        for <linux-omap@vger.kernel.org>; Thu, 17 Feb 2011 19:47:15 -0800 (PST)
In-Reply-To: <AANLkTi=f=SKE=QR97ttPnBrpW=2wNGd03+q4agmu6Uap@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sung Hee Park <shpark7@stanford.edu>
Cc: linux-omap@vger.kernel.org, sumit.semwal@ti.com

Sung Hee,

Could you please try the patch I forwarded to L-O yesterday?
https://patchwork.kernel.org/patch/569501/

Thanks,
-Bryan

On Fri, Feb 18, 2011 at 11:17 AM, Sung Hee Park <shpark7@stanford.edu> =
wrote:
> Hi,
>
> I found my frame buffer is not working while I'm testing the linux
> kernel 2.6.38-rc5 on omap3evm, which used to work fine with 2.6.37.
>
> Kernel command line: mem=3D128M console=3DttyO0,115200n8 noinitrd rw
> root=3D/dev/mmcblk0p2 rootfstype=3Dext3 rootwait omapfb.rot
> ate=3D3 omapfb.vrfb=3Dy vram=3D8M earlyprintk=3Dserial,uart0,115200n8
> omapdss.debug=3D1 omapfb.debug=3D1
> OMAPFB: omapfb_init
> OMAPFB: omapfb_probe
> omapfb omapfb: no driver for display
> omapfb omapfb: failed to setup omapfb
>
> I found Kevin reported the similar issue here (
> http://www.spinics.net/lists/linux-omap/msg44384.html ), and wonderin=
g
> about whether I has been patched. Sumit, could you please let me know
> if one of your recent patches would solve this problem? If it does,
> which patches am I supposed to apply on 2.6.38-rc5?
>
>
> Regards,
> Sung Hee
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer =A0 =A0+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. =A0 =A0 =A0www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
