From: "Jesko Schwarzer" <jesko.schwarzer@jena-optronik.de>
Subject: AW: Problems configuring OMAP35x ISP driver
Date: Tue, 14 Jul 2009 18:58:26 +0200
Message-ID: <"4430.36201247590721.hermes.jena-optronik.de*"@MHS>
References: <15157053.23861247590158808.JavaMail.root@mailx.crc.ricoh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <15157053.23861247590158808.JavaMail.root@mailx.crc.ricoh.com>
Content-Disposition: inline
Sender: linux-media-owner@vger.kernel.org
To: 'Zach LeRoy' <zleroy@rii.ricoh.com>
Cc: 'linux-media' <linux-media@vger.kernel.org>, 'linux-omap' <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hello Zach,

unfortunately I cannot help you, but maybe you can tell me what driver =
you
use? Where I can find it?

Thanks in advance
/Jesko

-----Urspr=FCngliche Nachricht-----
Von: linux-media-owner@vger.kernel.org
[mailto:linux-media-owner@vger.kernel.org] Im Auftrag von Zach LeRoy
Gesendet: Dienstag, 14. Juli 2009 18:49
An: Aguirre Rodriguez, Sergio
Cc: linux-media; linux-omap
Betreff: Problems configuring OMAP35x ISP driver

Hello Sergio,

I spoke with you earlier about using the ISP and omap34xxcam drivers wi=
th a
micron mt9d111 SOC sensor.  I have since been able to take pictures, bu=
t the
sensor data is not making it through the ISP data-path correctly.  I kn=
ow
the problem is in the ISP data-path because I am configuring the sensor=
 the
exact same way as I have been on my working PXA system.  I am expecting
4:2:2 packed YUV data, but all of the U and V data is no more than 2 bi=
ts
where it should be 8.  I know the ISP has a lot of capabilities, but al=
l I
want to use it for is grabbing 8-bit data from my sensor and putting it=
 in a
buffer untouched using the CCDC interface (and of course clocking and
timing).  What are the key steps to take to get this type of configurat=
ion?


Other Questions:

Is there any processing done on YUV data in the ISP driver by default t=
hat I
am missing?
Has any one else experienced similar problems while adding new sensor
support?

Any help here would be greatly appreciated.

Thank you,

Zach LeRoy
--
To unsubscribe from this list: send the line "unsubscribe linux-media" =
in
the body of a message to majordomo@vger.kernel.org More majordomo info =
at
http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-media" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
