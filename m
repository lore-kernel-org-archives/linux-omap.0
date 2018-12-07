From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am335x-pdu001: Fix polarity of card detection
 input
Date: Fri, 7 Dec 2018 08:54:29 -0800
Message-ID: <20181207165429.GQ6707@atomide.com>
References: <20181130145446.3819-1-fb@ltec.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181130145446.3819-1-fb@ltec.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Felix Brack <fb@ltec.ch>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, bcousson@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Felix Brack <fb@ltec.ch> [181130 07:30]:
> When a micro SD card is inserted in the PDU001 card cage, the card
> detection switch is opened and the corresponding GPIO input is driven
> by a pull-up. Hence change the active level of the card detection
> input from low to high.

Applying into omap-for-v4.20/fixes thanks,

Tony
