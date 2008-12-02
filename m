From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] TVP514x Driver with Review comments fixed [V4]
Date: Tue, 2 Dec 2008 11:44:27 -0800
Message-ID: <200812021144.28738.david-b@pacbell.net>
References: <hvaibhav@ti.com> <1228232142-11934-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:48503 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752507AbYLBTob (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Dec 2008 14:44:31 -0500
In-Reply-To: <1228232142-11934-1-git-send-email-hvaibhav@ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: hvaibhav@ti.com
Cc: video4linux-list@redhat.com, linux-omap@vger.kernel.org, davinci-linux-open-source-bounces@linux.davincidsp.com, Brijesh Jadav <brijesh.j@ti.com>, Hardik Shah <hardik.shah@ti.com>, Manjunath Hadli <mrh@ti.com>, R Sivaraj <sivaraj@ti.com>, Karicheri Muralidharan <m-karicheri2@ti.com>

Yep, nice to see an I2C driver that actually tries to cope
with errors when reading/writing registers.  :)

I expect that I'll have some more comments later.


On Tuesday 02 December 2008, hvaibhav@ti.com wrote:
> +void tvp514x_reg_dump(struct tvp514x_decoder *decoder)

"static void" ... there probably shouldn't be any symbols
exported from this driver, except the ones handling module
init (which are in a section that's removed ASAP).


> +/*
> + * TVP5146 Init/Power on Sequence
> + */
> +static struct tvp514x_reg tvp5146_init_reg_seq[] =3D {
> +=A0=A0=A0=A0=A0=A0=A0{TOK_WRITE, REG_VBUS_ADDRESS_ACCESS1, 0x02},
> +=A0=A0=A0=A0=A0=A0=A0{TOK_WRITE, REG_VBUS_ADDRESS_ACCESS2, 0x00},
> +=A0=A0=A0=A0=A0=A0=A0{TOK_WRITE, REG_VBUS_ADDRESS_ACCESS3, 0x80},
> +=A0=A0=A0=A0=A0=A0=A0{TOK_WRITE, REG_VBUS_DATA_ACCESS_NO_VBUS_ADDR_I=
NCR, 0x01},
> +=A0=A0=A0=A0=A0=A0=A0...
> +};
> +static struct tvp514x_init_seq tvp5146_init =3D {
> +=A0=A0=A0=A0=A0=A0=A0.no_regs =3D ARRAY_SIZE(tvp5146_init_reg_seq),
> +=A0=A0=A0=A0=A0=A0=A0.init_reg_seq =3D tvp5146_init_reg_seq,
> +};

I suggest making all of those be "static const", along
with their friends  :)


> +=A0=A0=A0=A0=A0=A0=A0{"tvp5146", (unsigned int)&tvp5146_init},

As I noted earlier, best if this were "unsigned long".

I'm surprised you're only using the driver_data to hold
a pointer to a tvp514x_init_seq structure.  That would
be the natural place to store other chip-specific
data ... like whatever is needed to ensure that this
driver never tries to access a '46-specific register
on a '47 chip.

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
