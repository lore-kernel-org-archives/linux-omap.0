From: Denis CIOCCA <denis.ciocca@st.com>
Subject: need help to configure IRQ on gpio 139 pandaboard using device tree
Date: Wed, 11 Dec 2013 15:28:28 +0100
Message-ID: <52A8768C.5070103@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:35368 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751294Ab3LKO2e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Dec 2013 09:28:34 -0500
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 479D3BB
	for <linux-omap@vger.kernel.org>; Wed, 11 Dec 2013 14:27:53 +0000 (GMT)
Received: from Webmail-eu.st.com (safex1hubcas1.st.com [10.75.90.14])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 39738595B
	for <linux-omap@vger.kernel.org>; Wed, 11 Dec 2013 14:14:56 +0000 (GMT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi everybody,

I'm trying to configure an IRQ on pandaboard using device tree but I'm 
not able to understand how I can do it.
I want to configure the the gpio_139 pin and without device tree my 
command was:

OMAP4_MUX(MCSPI1_SIMO, OMAP_MUX_MODE3 | OMAP_PIN_INPUT_PULLUP),

I need to associate it to a i2c device, declared in this way:

&i2c4 {
     pinctrl-names = "default";
     pinctrl-0 = <&i2c4_pins>;

     clock-frequency = <400000>;

     lsm303d@03 {
         compatible = "st,lsm303d";
         reg = <0x03>;
     };
};

and it works, but I don't know how I can set the interrupt using:
interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>; /* example */


Thanks,

Denis