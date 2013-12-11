From: Nishanth Menon <nm@ti.com>
Subject: Re: need help to configure IRQ on gpio 139 pandaboard using device
 tree
Date: Wed, 11 Dec 2013 11:32:17 -0600
Message-ID: <52A8A1A1.9090104@ti.com>
References: <52A8768C.5070103@st.com> <CAGo_u6p9D_rkzte_nxy9EsNyW1ouDPt2eP4zhrYBRjmd8+VHUA@mail.gmail.com> <52A89206.8080605@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42710 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387Ab3LKRcV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Dec 2013 12:32:21 -0500
In-Reply-To: <52A89206.8080605@st.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Denis CIOCCA <denis.ciocca@st.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 12/11/2013 10:25 AM, Denis CIOCCA wrote:
> 
> BUT, now I've checked the client->irq in an i2c driver and the value is 
> still 0...

I missed this:
> 
> and it works, but I don't know how I can set the interrupt using:
> interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>; /* example */
<snip>
> 
> What I have to check?
since your interrupt is an GPIO, as an example (probably wont match
your case):
 interrupt-parent = <&gpio4>; /* '4' is the GPIO BANK */
 interrupts = <11 0>;	/* '11' maps to the gpio number, '0' (bits -
interrupt-type */
[...]
see
Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
(hint: b) two cells)

> 
> On 12/11/2013 04:39 PM, menon.nishanth@gmail.com wrote:

For a future note, please avoid top-posting in mailing lists :)

-- 
Regards,
Nishanth Menon
