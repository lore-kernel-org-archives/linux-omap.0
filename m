From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RFC/PATCH 0/3] OMAP3 I2C/SCCB support
Date: Tue, 26 Jun 2012 18:20:33 +0200
Message-ID: <2898283.yhxlxrlhzg@avalon>
References: <1340720229-30356-1-git-send-email-laurent.pinchart@ideasonboard.com> <CAGGh5h3WLmQbDyoh8GbydxXQJ81DrVmeZK3Xh13HmHv4cxOs_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:37228 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758002Ab2FZQUc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jun 2012 12:20:32 -0400
In-Reply-To: <CAGGh5h3WLmQbDyoh8GbydxXQJ81DrVmeZK3Xh13HmHv4cxOs_g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean-philippe francois <jp.francois@cynove.com>
Cc: linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, Jean Delvare <khali@linux-fr.org>

Hi Jean-Philippe,

On Tuesday 26 June 2012 16:49:35 jean-philippe francois wrote:
> 2012/6/26 Laurent Pinchart <laurent.pinchart@ideasonboard.com>:
> > Hi everybody,
> > 
> > While trying to use an OV7725 camera sensor with an OMAP3 system I ran
> > into a couple of issues related to the sensor communication protocol.
> > Instead of using the obiquitous I2C protocol, Omnivision invited the SCCB
> > communication bus, very similar to I2C but different enough not to be
> > compatible.
> I have been using omnivision sensor without being aware of this issue,
> and without any i2c reliability issue either.
> 
> Here is typical code I use :
> 
> /* This function is used to read value from register for i2c client */
> static int ov2710_read(struct i2c_client *client, unsigned short reg,
> unsigned char *val)
> {
>     int err = 0;
>     unsigned char outbuf[] = {(reg>>8)&0xff, reg&0xff};

According to the SCCB specification (or at least the version I've found) 
register addresses are 8-bit. The OV2710 might just be I2C-compatible.

>     unsigned char inbuf[1];
>     struct i2c_msg msg[] = {
>         { .addr = client->addr, .flags = 0, .buf = outbuf, .len = 2 },
>         { .addr = client->addr, .flags = I2C_M_RD, .buf = inbuf, .len = 1 },
> };
>     err = i2c_transfer(client->adapter, msg, 2);
>     /* error handling and pass by ref handling */
>     ....
> }

The ov772x driver uses i2c_smbus_write_byte_data() and 
i2c_smbus_read_byte_data(). The later calls

i2c_smbus_xfer(client->adapter, client->addr, client->flags,
               I2C_SMBUS_READ, I2C_SMBUS_BYTE_DATA, &data);

which calls i2c_smbus_xfer_emulated() for hosts that don't support SMBus 
transfers natively, and that's pretty much equivalent to your above code 
(except for the 8/16 bit register address).

It might be a good idea to implement i2c_smbus_*-like functions for 16-bit 
register addresses in the I2C core, they could be reused across drivers.

> Is the point of this patch to avoid writing such functions again and again
> in every ov driver ?

No, but that's a good idea as well :-)

> What is solved in practice by this patch that is not solved by a regular i2c
> transfer ?

The above code will not ignore acks/nacks and will not generate a stop 
condition between the two messages. The SCCB specification states that 
acks/nacks must be ignored and that a stop condition must be generated. The 
OV7725 handles acks/nacks correctly, but chokes if no stop condition is 
generated. The point of this patch set is to fix both problems (although the 
acks/nacks issue might be theoretical only).

-- 
Regards,

Laurent Pinchart

