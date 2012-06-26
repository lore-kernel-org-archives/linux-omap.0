From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [RFC/PATCH 0/3] OMAP3 I2C/SCCB support
Date: Tue, 26 Jun 2012 18:36:14 +0200
Message-ID: <2180241.tDMasfKvry@avalon>
References: <1340720229-30356-1-git-send-email-laurent.pinchart@ideasonboard.com> <2898283.yhxlxrlhzg@avalon> <4FE9E296.4020905@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FE9E296.4020905-kIKI1E8EpGZWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gary Thomas <gary-kIKI1E8EpGZWk0Htik3J/w@public.gmane.org>
Cc: jean-philippe francois <jp.francois-JOfcSVQZ0GHQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Gary,

On Tuesday 26 June 2012 10:25:58 Gary Thomas wrote:
> On 2012-06-26 10:20, Laurent Pinchart wrote:
> > On Tuesday 26 June 2012 16:49:35 jean-philippe francois wrote:
> >> 2012/6/26 Laurent Pinchart<laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>:
> >>> Hi everybody,
> >>> 
> >>> While trying to use an OV7725 camera sensor with an OMAP3 system I ran
> >>> into a couple of issues related to the sensor communication protocol.
> >>> Instead of using the obiquitous I2C protocol, Omnivision invited the
> >>> SCCB communication bus, very similar to I2C but different enough not to
> >>> be compatible.
> >> 
> >> I have been using omnivision sensor without being aware of this issue,
> >> and without any i2c reliability issue either.
> >> 
> >> Here is typical code I use :
> >> 
> >> /* This function is used to read value from register for i2c client */
> >> static int ov2710_read(struct i2c_client *client, unsigned short reg,
> >> unsigned char *val)
> >> {
> >> 
> >>      int err = 0;
> >>      unsigned char outbuf[] = {(reg>>8)&0xff, reg&0xff};
> > 
> > According to the SCCB specification (or at least the version I've found)
> > register addresses are 8-bit. The OV2710 might just be I2C-compatible.
> > 
> >>      unsigned char inbuf[1];
> >>      struct i2c_msg msg[] = {
> >>      
> >>          { .addr = client->addr, .flags = 0, .buf = outbuf, .len = 2 },
> >>          { .addr = client->addr, .flags = I2C_M_RD, .buf = inbuf, .len =
> >>          1 },
> >> 
> >> };
> >> 
> >>      err = i2c_transfer(client->adapter, msg, 2);
> >>      /* error handling and pass by ref handling */
> >>      ....
> >> 
> >> }
> > 
> > The ov772x driver uses i2c_smbus_write_byte_data() and
> > i2c_smbus_read_byte_data(). The later calls
> > 
> > i2c_smbus_xfer(client->adapter, client->addr, client->flags,
> > 
> >                 I2C_SMBUS_READ, I2C_SMBUS_BYTE_DATA,&data);
> > 
> > which calls i2c_smbus_xfer_emulated() for hosts that don't support SMBus
> > transfers natively, and that's pretty much equivalent to your above code
> > (except for the 8/16 bit register address).
> > 
> > It might be a good idea to implement i2c_smbus_*-like functions for 16-bit
> > register addresses in the I2C core, they could be reused across drivers.
> > 
> >> Is the point of this patch to avoid writing such functions again and
> >> again in every ov driver ?
> > 
> > No, but that's a good idea as well :-)
> > 
> >> What is solved in practice by this patch that is not solved by a regular
> >> i2c transfer ?
> > 
> > The above code will not ignore acks/nacks and will not generate a stop
> > condition between the two messages. The SCCB specification states that
> > acks/nacks must be ignored and that a stop condition must be generated.
> > The OV7725 handles acks/nacks correctly, but chokes if no stop condition
> > is generated. The point of this patch set is to fix both problems
> > (although the acks/nacks issue might be theoretical only).
> 
> How does it "choke"?  I've had success talking to the OV8820 using the
> normal I2C driver as well.

With the patches applied:

[   23.277893] omap3isp omap3isp: Revision 15.0 found
[   23.283721] omap-iommu omap-iommu.0: isp: version 1.1
[   25.244079] ov772x 2-0021: ov7725 Product ID 77:21 Manufacturer ID 7f:a2

Without the patches applied:

[   23.505493] omap3isp omap3isp: Revision 15.0 found
[   23.511138] omap-iommu omap-iommu.0: isp: version 1.1
[   25.552246] omap_i2c omap_i2c.2: Arbitration lost
[   26.583160] omap_i2c omap_i2c.2: timeout waiting for bus ready
[   27.598785] omap_i2c omap_i2c.2: timeout waiting for bus ready
[   28.614196] omap_i2c omap_i2c.2: timeout waiting for bus ready
[   28.623260] isp_register_subdev_group: Unable to register subdev ov772x

-- 
Regards,

Laurent Pinchart
