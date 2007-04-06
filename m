From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [RFC-PATCH] Move i2c adaptor speed from a module parameter
	toplatform device resource
Date: Fri, 6 Apr 2007 17:00:25 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47A19D34@dlee13.ent.ti.com>
References: <782515bb0704021714n18bb7e53ndac2047e1960b87d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <782515bb0704021714n18bb7e53ndac2047e1960b87d@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: nishanth menon <menon.nishanth@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Nishanth,

>-----Original Message-----
>From: linux-omap-open-source-bounces@linux.omap.com [mailto:linux-omap-
>open-source-bounces@linux.omap.com] On Behalf Of nishanth menon
>Sent: Monday, April 02, 2007 7:14 PM
>To: linux-omap-open-source@linux.omap.com
>Subject: [RFC-PATCH] Move i2c adaptor speed from a module parameter
>toplatform device resource
>
>Hi All,
>
>Please find attached patch to move the i2c speed parameter from module
>to bus specific resource.
>
>To Discuss:
>* Is IORESOURCE_IO the best way of defining speed for i2c bus?
>
I think we will be giving a different meaning to IORESOURCE_IO by doing
this. Other drivers mainly use this for IO space handling purposes.=20

I thought some I2C config structure would have been better, like one
available for SPI/MMC. I don't know if this gets formally approved.

The other option I thought was,=20

static int omap2_i2c2_clkrate =3D 400;

static struct platform_device omap_i2c_device2 =3D {
        .name           =3D "i2c_omap",
        .id             =3D 2,
        .num_resources  =3D ARRAY_SIZE(i2c_resources2),
        .resource       =3D i2c_resources2,
        .dev            =3D {
                .platform_data =3D &omap2_i2c2_clkrate,
        },
};

:),=20

>This, however, requires the following follow up patches:
>* Move i2c platform from plat-omap to respective board files.
>*    Reasoning: I2C speed at 100Khz is not always optimal for I2C1 by
>*      default (e.g. 3430).
>*    Impact: all board files will need to have it...but it will ensure
>*    that the i2c init is done in the proper sequence - 1 followed by
2.

We had discussed this before, but Tony was not "for" this approach.
http://linux.omap.com/pipermail/linux-omap-open-source/2006-November/008
398.html

>* Support FIFO mode of data transfer - this is supported on newer I2C
h/w
>*     revs
>*    Options: support all in a single driver/split them up? have
i2c-omap.c
>*     and i2c-omap2.c?

We can add all new functionality to existing i2c-omap.c.

>* Support High speed transfers at a bus level
>*    Will depend of FIFO implementation as polled/interrupt mode is too
>*     slow and causes underrun.


We can...

>* Support all known Erratas for i2c module.. make features
>*    i2c_module_hardware_revision based.
>* Support proper bus speed support
>*    Multiple devices on the same bus can have varied speed
requirements.
>*    Infact speed could be a parameter for i2c messages?
>*    Impact: I2c corelevel changes required.i2c list disc.

No specific comments as of now. This activity can be handled once we are
done with all of the above

>Regards,
>Nishanth Menon

Regards,
Khasim
