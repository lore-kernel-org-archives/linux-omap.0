From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH RFC 1/5] omap3: add platform init code for OHCI driver
Date: Tue, 23 Mar 2010 15:05:29 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032221A5B6@dbde02.ent.ti.com>
References: <1269171123-9874-1-git-send-email-gadiyar@ti.com>
 <1269171123-9874-2-git-send-email-gadiyar@ti.com>
 <A24693684029E5489D1D202277BE89445428C1CF@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47567 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753781Ab0CWJff convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Mar 2010 05:35:35 -0400
In-Reply-To: <A24693684029E5489D1D202277BE89445428C1CF@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre, Sergio" <saaguirre@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Aguirre, Sergio wrote:
> > +static void setup_ohci_io_mux(enum ohci_omap3_port_mode *port_mode)
> > +{
> > +	/* REVISIT: these need to be tailored for each of the modes */
> > +	switch (port_mode[0]) {
> > +	case OMAP_OHCI_PORT_MODE_PHY_3PIN_DATSE0:
> > +	case OMAP_OHCI_PORT_MODE_PHY_4PIN_DPDM:
> > +		omap_mux_init_signal("mm1_rxdp",
> > +			OMAP_PIN_INPUT_PULLDOWN);
> > +		omap_mux_init_signal("mm1_rxdm",
> > +			OMAP_PIN_INPUT_PULLDOWN);
> > +		omap_mux_init_signal("mm1_txse0",
> > +			OMAP_PIN_INPUT_PULLDOWN);
> > +		omap_mux_init_signal("mm1_rxrcv",
> > +			OMAP_PIN_INPUT_PULLDOWN);
> > +		omap_mux_init_signal("mm1_txdat",
> > +			OMAP_PIN_INPUT_PULLDOWN);
> > +		omap_mux_init_signal("mm1_txen_n", OMAP_PIN_OUTPUT);
> > +		break;
> > +	case OMAP_OHCI_PORT_MODE_UNUSED:
> > +	default:
> > +		/* FALLTHROUGH */
> 
> Is this the right place for the fall through comment? I guess you meant
> Between 'case OMAP_OHCI_PORT_MODE_UNUSED:' and "default:" lines...
> 

Ah yes, thanks for catching that.

By the way, I did sort out the 2/3/4/6-pin layout, so in the next version,
I'll be able to cover that cleanly.

- Anand
