From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: [BUG] SIOCSIFFLAGS returns -EIO on SMSC LAN911x
Date: Fri, 30 Dec 2011 10:09:57 +0100
Message-ID: <CAAwP0s0xsXTW9M18mpSeYipLqT7v_LH6RyRK3wRYV1qYo0S01A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63689 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179Ab1L3JKT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Dec 2011 04:10:19 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-netdev@vger.kernel.org, linux-omap@vger.kernel.org, kernelnewbies <kernelnewbies@kernelnewbies.org>
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>, Herbert Valerio Riedel <hvr@gnu.org>

Hello,

We have an issue with the SMSC LAN911x driver with today linux-2.6 [1]
executing on an IGEPv2 [2] board using omap2plus_defconfig.

When I try to bring up the network interface, the ioctl set interface
flags command (SIOCSIFFLAGS)  fails returning -EIO:

root@igep00x0:~# ifconfig eth0 up
ifconfig: SIOCSIFFLAGS: Input/output error

But if I execute again it succeeds:

root@igep00x0:~# ifconfig eth0 up
[  832.465423] smsc911x smsc911x.0: eth0: SMSC911x/921x identified at
0xdb086000, IRQ: 336

We found that the problem is on the SMSC LAN911x driver
(drivers/net/ethernet/smsc/smsc911x.c) net_dev ndo_open function
handler smsc911x_open.

When the handler is called, it tries to software reset the device by
writing a bit to a self-clearing configuration register. According to
the data-sheet the hardware clears that bit to notify that the reset
was successfully:

 static int smsc911x_soft_reset(struct smsc911x_data *pdata)
{
        unsigned int timeout;
        unsigned int temp;

        /* Reset the LAN911x */
        smsc911x_reg_write(pdata, HW_CFG, HW_CFG_SRST_);
        timeout =3D 10;
        do {
                udelay(10);
                temp =3D smsc911x_reg_read(pdata, HW_CFG);
        } while ((--timeout) && (temp & HW_CFG_SRST_));

        if (unlikely(temp & HW_CFG_SRST_)) {
                SMSC_WARN(pdata, drv, "Failed to complete reset");
                return -EIO;
        }
        return 0;
}

The condition temp & HW_CFG_SRST_ is false so the error code -EIO is
returned and propagated to user-space.

By doing a git bisect we found that this strange behavior exists when
the Kconfig tristate compilation condition SMSC_PHY has the value yes
to be compiled built-in:

SMSC_PHY=3Dy

If this config symbol has the value module (m) or not build at all,
then bringing up the network interface never fails.

Did anyone have the same problem?

The problem is really strange to me, especially since we are sure that
all the requirements to software reset the device are meet in both
cases (with SMSC_PHY compiled built-in and without it)

[1]: HEAD on commit 371de6e4e0042adf4f9b54c414154f57414ddd37 drm/i915:
Disable RC6 on Sandybridge by default
[2]: https://wiki.linaro.org/Boards/Igep

Thank you and best regards,

--=20
Javier Mart=C3=ADnez Canillas
(+34) 682 39 81 69
Barcelona, Spain
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
