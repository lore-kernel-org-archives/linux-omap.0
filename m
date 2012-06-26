From: jean-philippe francois <jp.francois@cynove.com>
Subject: Re: [RFC/PATCH 0/3] OMAP3 I2C/SCCB support
Date: Tue, 26 Jun 2012 16:49:35 +0200
Message-ID: <CAGGh5h3WLmQbDyoh8GbydxXQJ81DrVmeZK3Xh13HmHv4cxOs_g@mail.gmail.com>
References: <1340720229-30356-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f51.google.com ([209.85.213.51]:54394 "EHLO
	mail-yw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757756Ab2FZOtg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jun 2012 10:49:36 -0400
In-Reply-To: <1340720229-30356-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, Jean Delvare <khali@linux-fr.org>

2012/6/26 Laurent Pinchart <laurent.pinchart@ideasonboard.com>:
> Hi everybody,
>
> While trying to use an OV7725 camera sensor with an OMAP3 system I ra=
n into a
> couple of issues related to the sensor communication protocol. Instea=
d of
> using the obiquitous I2C protocol, Omnivision invited the SCCB commun=
ication
> bus, very similar to I2C but different enough not to be compatible.
>

I have been using omnivision sensor without being aware of this issue,
and without any i2c reliability issue either.

Here is typical code I use :

/* This function is used to read value from register for i2c client */
static int ov2710_read(struct i2c_client *client, unsigned short reg,
unsigned char *val)
{
    int err =3D 0;
    unsigned char outbuf[] =3D {(reg>>8)&0xff, reg&0xff};
    unsigned char inbuf[1];
    struct i2c_msg msg[] =3D {
        { .addr =3D client->addr, .flags =3D 0, .buf =3D outbuf, .len =3D=
 2 },
        { .addr =3D client->addr, .flags =3D I2C_M_RD, .buf =3D inbuf, =
=2Elen =3D 1 },
    };
    err =3D i2c_transfer(client->adapter, msg, 2);
    /* error handling and pass by ref handling */
    ....
}

Is the point of this patch to avoid writing such functions again and
again in every ov driver ?
What is solved in practice by this patch that is not solved by a
regular i2c transfer ?

Regards,
Jean-Philippe Fran=E7ois

> SCCB documentation is available at
> http://www.ovt.com/download_document.php?type=3Ddocument&DID=3D63. SC=
CB exists in
> two flavors, 3-wire and 2-wire. The 3-wire version is too different f=
rom I2C
> to be of interest here.
>
> SCCB is very close to SMBus. It supports two transactions, an 8-bit r=
egister
> read and an 8-bit register write. The write transaction transmits a 3=
-byte
> message (addr/w, reg, data). The read transaction transmits 2 2-byte =
messages
> (addr/w, reg, followed by addr/r, data).
>
> The two majors differences between I2C and SCCB are in the acknowledg=
ment bit
> and in the stop bit.
>
> SCCB devices generate no ack bit and don't take the ack bit generated=
 by the
> master into account. The ack bit is thus an unspecified bit, present =
in the
> transfer but whose value must be ignored. However, in practice, the S=
CCB
> components I've seen implement the ack bit in write transactions.
>
> The stop bit is handled as in I2C, except that a stop bit needs to be
> generated between the two messages that make the read transaction (as=
 opposed
> to SMBus, where no stop bit must be present between the two messages)=
=2E
>
> I need SCCB support in the I2C core and in the OMAP3 I2C driver and h=
ave two
> options. The OMAP3 I2C controller support SCCB natively. The interfac=
e exposed
> by the hardware is at the transaction level (smbus_xfer), while the i=
2c-omap
> driver exposes a message level interface (master_xfer). To use the na=
tive SCCB
> support, we would thus have to either allow i2c_smbus_xfer() to choos=
e between
> smbus_xfer and i2c_smbus_xfer_emulated based on the client type (I2C =
or SCCB),
> or export i2c_smbus_xfer_emulated() to use it as a fallback in the i2=
c-omap
> driver for I2C clients.
>
> Another option is not to use the hardware SCCB support, but to emulat=
e it
> through I2C. In that case the i2c-omap driver must generate a stop bi=
t after
> the first message of a read transaction, and ignore the ack bit. Two =
flags
> would then be necessary, one in the message to force the stop bit, an=
d one in
> the i2c_client to mark the device as using SCCB.
>
> Implementing support for the second option is required for I2C master=
s that
> have no hardware SCCB support. As the first option won't bring much b=
enefits,
> I've decided to skip it for now. The following three patches thus imp=
lement
> emulated SCCB support in the I2C core, with a small change in the i2c=
-omap
> driver to support the new I2C_M_STOP flag.
>
> Laurent Pinchart (3):
> =A0i2c: Add SCCB support
> =A0i2c: Fall back to emulated SMBus if the operation isn't supported
> =A0 =A0natively
> =A0i2c: omap: Add support for I2C_M_STOP message flag
>
> =A0drivers/i2c/busses/i2c-omap.c | =A0 =A02 ++
> =A0drivers/i2c/i2c-core.c =A0 =A0 =A0 =A0| =A0 22 +++++++++++++++++++=
---
> =A0include/linux/i2c.h =A0 =A0 =A0 =A0 =A0 | =A0 =A02 ++
> =A03 files changed, 23 insertions(+), 3 deletions(-)
>
> --
> Regards,
>
> Laurent Pinchart
>
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
