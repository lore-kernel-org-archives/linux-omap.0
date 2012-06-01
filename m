From: Kevin Hilman <khilman@ti.com>
Subject: Re: [linux-pm] [RFC PATCH 07/11] mfd: omap: control: usb-phy: introduce the ctrl-module usb driver
Date: Fri, 01 Jun 2012 07:07:08 -0700
Message-ID: <87txyvt9bn.fsf@ti.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
	<1337934361-1606-8-git-send-email-eduardo.valentin@ti.com>
	<20120601113853.GO12766@atomide.com>
	<20120601132056.GR12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:60859 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758182Ab2FAOHI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jun 2012 10:07:08 -0400
Received: by dajt11 with SMTP id t11so3206035daj.24
        for <linux-omap@vger.kernel.org>; Fri, 01 Jun 2012 07:07:07 -0700 (PDT)
In-Reply-To: <20120601132056.GR12766@atomide.com> (Tony Lindgren's message of
	"Fri, 1 Jun 2012 06:20:57 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, balbi@ti.com, kishon@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Tony Lindgren <tony@atomide.com> [120601 04:43]:
>> * Eduardo Valentin <eduardo.valentin@ti.com> [120525 01:31]:
>> > +int omap4_usb_phy_power(struct device *dev, int on)
>> > +{
>> > +	u32 val;
>> > +	int ret;
>> > +
>> > +	if (on) {
>> > +		ret = omap_control_readl(dev, CONTROL_DEV_CONF, &val);
>> > +		if (!ret && (val & PHY_PD)) {
>> > +			ret = omap_control_writel(dev, ~PHY_PD,
>> > +						  CONTROL_DEV_CONF);
>> > +			/* XXX: add proper documentation for this delay */
>> > +			mdelay(200);
>> > +		}
>> > +	} else {
>> > +		ret = omap_control_writel(dev, PHY_PD, CONTROL_DEV_CONF);
>> > +	}
>> > +
>> > +	return ret;
>> > +}
>> > +EXPORT_SYMBOL_GPL(omap4_usb_phy_power);
>> 
>> I'm not quite convinced that we should export omap_control_read/write
>> to drivers. If there's a clear register area this USB phy driver can
>> manage, then ioremaping it separately makes sense. If it's just one
>> register, then exporting something like omap_control_usb_phy_set()
>> might be better for ensuring that drivers don't mess up things for
>> other drivers.
>
> After chatting with Benoit a bit we came to the conclusion that the
> clock and powerdomain state needs to be managed for the children by
> the SCM core driver so the children can't be completely independent.
>
> But rather than exporting omap_control_read/write, maybe you can
> register the usb/bandgap whatever children with SCM core driver,
> then have the runtime PM calls from children be passthrough calls
> to the parent?
>
> Maybe Kevin has some better ideas here?

Handling this with parent/child relationships is the way to go for
runtime PM.  

In MFD, are all sub-devices always children of the core device in the
LDM?  If so, it seems relatively easy to handle.  If the parent/child
relationships are modeled correctly in the LDM, then the children do not
have to know anything about their parent, the runtime PM core will handle
this (parent will not be runtime suspended until all the children are.)

Kevin
