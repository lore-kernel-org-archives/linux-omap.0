From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] TVP514x Driver with Review comments fixed
Date: Fri, 28 Nov 2008 08:26:42 -0800
Message-ID: <200811280826.43017.david-b@pacbell.net>
References: <hvaibhav@ti.com> <1227876228-16553-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:24563 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750899AbYK1Q0p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Nov 2008 11:26:45 -0500
In-Reply-To: <1227876228-16553-1-git-send-email-hvaibhav@ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: hvaibhav@ti.com
Cc: video4linux-list@redhat.com, davinci-linux-open-source-bounces@linux.davincidsp.com, linux-omap@vger.kernel.org, Brijesh Jadav <brijesh.j@ti.com>, Hardik Shah <hardik.shah@ti.com>, Manjunath Hadli <mrh@ti.com>, R Sivaraj <sivaraj@ti.com>, Karicheri Muralidharan <m-karicheri2@ti.com>

On Friday 28 November 2008, hvaibhav@ti.com wrote:
> +static int tvp514x_read_reg(struct i2c_client *client, u8 reg, u8 *v=
al)
> +{
> +=A0=A0=A0=A0=A0=A0=A0int err;
> +=A0=A0=A0=A0=A0=A0=A0struct i2c_msg msg[2];
> +=A0=A0=A0=A0=A0=A0=A0u8 data;
> +
> +=A0=A0=A0=A0=A0=A0=A0if (!client->adapter)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -ENODEV;
> +
> +=A0=A0=A0=A0=A0=A0=A0/* [MSG1] fill the register address data */
> +=A0=A0=A0=A0=A0=A0=A0data =3D reg;
> +=A0=A0=A0=A0=A0=A0=A0msg[0].addr =3D client->addr;
> +=A0=A0=A0=A0=A0=A0=A0msg[0].len =3D 1;
> +=A0=A0=A0=A0=A0=A0=A0msg[0].flags =3D 0;
> +=A0=A0=A0=A0=A0=A0=A0msg[0].buf =3D &data;
> +
> +=A0=A0=A0=A0=A0=A0=A0/* [MSG2] fill the data rx buffer */
> +=A0=A0=A0=A0=A0=A0=A0msg[1].addr =3D client->addr;
> +=A0=A0=A0=A0=A0=A0=A0msg[1].len =3D 1;=A0=A0=A0=A0=A0=A0=A0=A0=A0/* =
only 1 byte */
> +=A0=A0=A0=A0=A0=A0=A0msg[1].flags =3D I2C_M_RD;=A0=A0=A0=A0=A0=A0=A0=
=A0/* Read the register values */
> +=A0=A0=A0=A0=A0=A0=A0msg[1].buf =3D val;
> +=A0=A0=A0=A0=A0=A0=A0err =3D i2c_transfer(client->adapter, msg, 2);

Better:

	err =3D i2c_smbus_read_byte_data(client, reg);
	if (err >=3D 0) {
		*val =3D err;
		err =3D 0;
	}
	return err;

Though maybe the calling convention should be simplified,
And of course, probe() should verify that the adapter can
support the SMBus byte_data operations.


> +=A0=A0=A0=A0=A0=A0=A0if (err >=3D 0)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return 0;
> +
> +=A0=A0=A0=A0=A0=A0=A0v4l_dbg(1, debug, client,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"read from device 0x%.2=
x, offset 0x%.2x error %d\n",
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0client->addr, reg, err)=
;
> +
> +=A0=A0=A0=A0=A0=A0=A0return err;
> +}
> +
> +/*
> + * Write a value to a register in an TVP5146/47 decoder device.
> + * Returns zero if successful, or non-zero otherwise.
> + */
> +static int tvp514x_write_reg(struct i2c_client *client, u8 reg, u8 v=
al)
> +{
> +=A0=A0=A0=A0=A0=A0=A0int err;
> +=A0=A0=A0=A0=A0=A0=A0int retry =3D 0;
> +=A0=A0=A0=A0=A0=A0=A0struct i2c_msg msg[1];
> +=A0=A0=A0=A0=A0=A0=A0u8 data[2];
> +
> +=A0=A0=A0=A0=A0=A0=A0if (!client->adapter)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -ENODEV;
> +
> +again:
> +=A0=A0=A0=A0=A0=A0=A0data[0] =3D reg;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/=
* Register offset */
> +=A0=A0=A0=A0=A0=A0=A0data[1] =3D val;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/=
* Register value */
> +=A0=A0=A0=A0=A0=A0=A0msg->addr =3D client->addr;
> +=A0=A0=A0=A0=A0=A0=A0msg->len =3D 2;
> +=A0=A0=A0=A0=A0=A0=A0msg->flags =3D 0;=A0=A0=A0=A0=A0=A0=A0=A0=A0/* =
write operation */
> +=A0=A0=A0=A0=A0=A0=A0msg->buf =3D data;
> +
> +=A0=A0=A0=A0=A0=A0=A0err =3D i2c_transfer(client->adapter, msg, 1);
> +=A0=A0=A0=A0=A0=A0=A0if (err >=3D 0)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return 0;

Likewise:

again:
	err =3D i2c_smbus_write_byte_data(client, reg, val);
	if (err =3D=3D 0)
		return 0;
	/* else retry */

By the way, while I applaud actually *having* fault handling in
I2C driver code -- faults can happen, and pathetically few Linux
drivers tolerate them from I2C -- I'm curious why only the write
path handles them, not the read path.


> +
> +=A0=A0=A0=A0=A0=A0=A0v4l_dbg(1, debug, client,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"wrote 0x%.2x to offset=
 0x%.2x error %d\n", val, reg, err);
> +=A0=A0=A0=A0=A0=A0=A0if (retry <=3D I2C_RETRY_COUNT) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0v4l_warn(client, "retry=
 ... %d\n", retry);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0retry++;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0schedule_timeout(msecs_=
to_jiffies(20));
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto again;
> +=A0=A0=A0=A0=A0=A0=A0}
> +=A0=A0=A0=A0=A0=A0=A0return err;
> +}


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
