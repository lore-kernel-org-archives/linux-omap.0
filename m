From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH 1/3] ARM: dts: overo: Add support for DVI output
Date: Thu, 13 Mar 2014 09:25:43 +0100
Message-ID: <53216B87.9070007@epfl.ch>
References: <1394541257-25605-1-git-send-email-florian.vaussard@epfl.ch> <1394541257-25605-2-git-send-email-florian.vaussard@epfl.ch> <53200894.5020602@ti.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:52314 "EHLO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753196AbaCMIZr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Mar 2014 04:25:47 -0400
In-Reply-To: <53200894.5020602@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: Ash Charles <ash@gumstix.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On 03/12/2014 08:11 AM, Tomi Valkeinen wrote:
> On 11/03/14 14:34, Florian Vaussard wrote:
>> Summit and Tobi expansion boards have a HDMI connector with a TFP410
>> encoder. Add a common include file for this configuration, and then
>> use it for Summit and Tobi.
>>
>> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
>> ---
>>  arch/arm/boot/dts/omap3-overo-common-dvi.dtsi    | 109 +++++++++++++++++++++++
>>  arch/arm/boot/dts/omap3-overo-summit-common.dtsi |   1 +
>>  arch/arm/boot/dts/omap3-overo-tobi-common.dtsi   |   1 +
>>  3 files changed, 111 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/omap3-overo-common-dvi.dtsi
> 
> <snip>
> 
>> +&dss {
>> +	status = "ok";
>> +
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&dss_dpi_pins
>> +		     &i2c3_pins>;
> 
> The i2c3 pins don't belong here, they are not related to dss. The
> dvi-connector uses i2c3, but I don't think they belong there either, as
> the i2c3 bus can be used by multiple devices. So I guess they should be
> set in &i2c3 node.
> 

You are right. And as I am already using i2c3 for other things, this
duplicates the pinctrl. I will drop it.

Regards,
Florian
