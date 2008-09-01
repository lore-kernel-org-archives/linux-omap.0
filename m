From: Zou Tao <zoutao51@gmail.com>
Subject: omap zoom lpd board clk init problem when booting "Clock cam_ick
 didn't enable in 100000 tries"
Date: Mon, 01 Sep 2008 17:13:28 +0800
Message-ID: <48BBB238.9070804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.185]:23117 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029AbYIAJNg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Sep 2008 05:13:36 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1334607fkq.5
        for <linux-omap@vger.kernel.org>; Mon, 01 Sep 2008 02:13:34 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi:
When board reboot, driver tried to reset camera, there is error:
kernel version is v2.6.26-ti-07252008. Does anyone see it before?
> console [ttyS2] enabled
> brd: module loaded
> loop: module loaded
> eth0: LAN9211 (rev 0) at 0xc8908000 IRQ 312
> eth0: Ethernet addr: 00:08:ee:02:53:22
> eth0: LAN911x Internal PHY
> Linux video capture interface: v2.00
> omap24xxvout: registered device video1 [v4l2]
> omap24xxvout: registered device video2 [v4l2]
> Clock cam_ick didn't enable in 100000 tries
> Clock cam_mclk didn't enable in 100000 tries
> isp_af_init
I have tried to open /dev/video/0, but there is no such device.
and I add some debug info in isp_get call, and found that content of
register cm_fclken_cam is 03, and content of cm_icklen_cam is 0,but
cm_idlest_cam is 0x1, so clk init failed. For the kernel option I have=20
choiced:
>           [*]   Enable advanced debug=20
> functionality                                                       =E2=
=94=82 =E2=94=82
>   =E2=94=82 =E2=94=82                          [*]   Autoselect perti=
nent=20
> encoders/decoders and other helper chips                             =
=E2=94=82 =E2=94=82
>   =E2=94=82 =E2=94=82                          < >   Virtual Video=20
> Driver                                                               =
      =20
> =E2=94=82 =E2=94=82
>   =E2=94=82 =E2=94=82                          < >   SAA5246A, SAA528=
1 Teletext=20
> processor                                                      =E2=94=
=82 =E2=94=82
>   =E2=94=82 =E2=94=82                          < >   SAA5249 Teletext=
=20
> processor                                                            =
   =20
> =E2=94=82 =E2=94=82
>   =E2=94=82 =E2=94=82                                OMAP2/OMAP3 V4L2=
 drivers =20
> --->                                                            =E2=94=
=82 =E2=94=82
>   =E2=94=82 =E2=94=82                          <*>   OMAP 3 Camera=20
> support                                                              =
      =20
> =E2=94=82 =E2=94=82
>   =E2=94=82 =E2=94=82                          <*>   OMAP ISP=20
> Driver                                                               =
           =20
> =E2=94=82 =E2=94=82
>   =E2=94=82 =E2=94=82                          <*>     omap isp=20
> previewer                                                            =
         =20
> =E2=94=82 =E2=94=82
>   =E2=94=82 =E2=94=82                          <*>     omap isp=20
> resizer                                                              =
         =20
> =E2=94=82 =E2=94=82
>   =E2=94=82 =E2=94=82                          < >   OMAP 2 Camera su=
pport=20
> (EXPERIMENTAL)                                                      =E2=
=94=82 =E2=94=82
>   =E2=94=82 =E2=94=82                          [ ]   V4L USB devices =
=20
> --->                                                                 =
   =20
> =E2=94=82 =E2=94=82
>   =E2=94=82 =E2=94=82                          < >   SoC camera suppo=
rt     =20



even there is some clk error report, but isp_get return successfully.
1. why there  is no such device?
2. do you know the sensor name of sensor module? and datasheet?
3. what's the interface used by ldp board to connect sensor? serial or=20
parallel port?

Any suggestion will be appreciated.

B.R
Tao

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
