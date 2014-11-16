From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC] adp1653: Add device tree bindings for LED controller
Date: Sun, 16 Nov 2014 09:11:04 +0100
Message-ID: <54685C18.1020109@metafoo.de>
References: <20141116075928.GA9763@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141116075928.GA9763@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, freemangordon@abv.bg, bcousson@baylibre.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, sakari.ailus@iki.fi, devicetree@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/16/2014 08:59 AM, Pavel Machek wrote:
>[...]
> +	adp1653: adp1653@30 {
> +		compatible = "ad,adp1653";

The Analog Devices vendor prefix is adi.
