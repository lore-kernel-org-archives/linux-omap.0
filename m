From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: drivers: usb: dwc3: A question...
Date: Thu, 9 Feb 2017 10:45:46 +0200
Message-ID: <e5742c34-170c-0e7b-f3bf-55fbf151b458@ti.com>
References: <20170209021430.Horde.n6IB1mLy0ToxSTvUHQXeRXx@gator4166.hostgator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170209021430.Horde.n6IB1mLy0ToxSTvUHQXeRXx-fU+oOHjIBR1LoJgMfuPDHBfZZeVsHd8q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gustavo A. R. Silva" <garsilva-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>, balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Senna Tschudin <peter.senna-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On 09/02/17 10:14, Gustavo A. R. Silva wrote:
> Hello everybody,
> 
> I ran into the following piece of code at drivers/usb/dwc3/dwc3-omap.c:218 (linux-next)
> 
> 218static void dwc3_omap_set_mailbox(struct dwc3_omap *omap,
> 219        enum omap_dwc3_vbus_id_status status)
> 220{
> 221        int     ret;
> 222        u32     val;
> 223
> 224        switch (status) {
> 225        case OMAP_DWC3_ID_GROUND:
> 226                if (omap->vbus_reg) {
> 227                        ret = regulator_enable(omap->vbus_reg);
> 228                        if (ret) {
> 229                                dev_err(omap->dev, "regulator enable failed\n");
> 230                                return;
> 231                        }
> 232                }
> 233
> 234                val = dwc3_omap_read_utmi_ctrl(omap);
> 235                val &= ~USBOTGSS_UTMI_OTG_CTRL_IDDIG;
> 236                dwc3_omap_write_utmi_ctrl(omap, val);
> 237                break;
> 238
> 239        case OMAP_DWC3_VBUS_VALID:
> 240                val = dwc3_omap_read_utmi_ctrl(omap);
> 241                val &= ~USBOTGSS_UTMI_OTG_CTRL_SESSEND;
> 242                val |= USBOTGSS_UTMI_OTG_CTRL_VBUSVALID
> 243                                | USBOTGSS_UTMI_OTG_CTRL_SESSVALID;
> 244                dwc3_omap_write_utmi_ctrl(omap, val);
> 245                break;
> 246
> 247        case OMAP_DWC3_ID_FLOAT:
> 248                if (omap->vbus_reg)
> 249                        regulator_disable(omap->vbus_reg);
> 250                val = dwc3_omap_read_utmi_ctrl(omap);
> 251                val |= USBOTGSS_UTMI_OTG_CTRL_IDDIG;
> 252                dwc3_omap_write_utmi_ctrl(omap, val);
> 253
> 254        case OMAP_DWC3_VBUS_OFF:
> 255                val = dwc3_omap_read_utmi_ctrl(omap);
> 256                val &= ~(USBOTGSS_UTMI_OTG_CTRL_SESSVALID
> 257                                | USBOTGSS_UTMI_OTG_CTRL_VBUSVALID);
> 258                val |= USBOTGSS_UTMI_OTG_CTRL_SESSEND;
> 259                dwc3_omap_write_utmi_ctrl(omap, val);
> 260                break;
> 261
> 262        default:
> 263                dev_WARN(omap->dev, "invalid state\n");
> 264        }
> 265}
> 
> The thing is that the case for OMAP_DWC3_ID_FLOAT is not terminated by a break statement, and it falls through to the next case OMAP_DWC3_VBUS_OFF.
> 
> My question here is if for any reason this code is intentional?
> 
> In case it is not, I will write a patch to fix this, but first it would be great to hear any comment about it.

You are right that it is a mistake. Thanks for pointing out.
I had already submitted a patch
https://patchwork.kernel.org/patch/9532195/

Felipe,
I think we should pick it up regardless of the rest of the series and mark for -stable.

Please do add
Reported-by: Gustavo A. R. Silva <garsilva-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>
Thanks :)

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
