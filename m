From: Lars Melin <larsm17@gmail.com>
Subject: Re: [PATCH] USB: serial: option: Add Motorola modem UARTs
Date: Wed, 24 Jul 2019 09:34:09 +0700
Message-ID: <75e9bccc-d76d-2bc6-f9f3-a0efc25e8238@gmail.com>
References: <20190723144956.55753-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190723144956.55753-1-tony@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?Q?Bj=c3=b8rn_Mork?= <bjorn@mork.no>, Dan Williams <dan.j.williams@intel.com>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Scott <hashcode0f@gmail.com>, NeKit <nekit1000@gmail.com>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

On 7/23/2019 21:49, Tony Lindgren wrote:

> +#define MOTOROLA_VENDOR_ID			0x22b8
> +#define MOTOROLA_PRODUCT_MDM6600		0x2a70
> +#define MOTOROLA_PRODUCT_MDM9600		0x2e0a
> +#define MOTOROLA_PRODUCT_MDM_RAM_DL		0x4281
> +#define MOTOROLA_PRODUCT_MDM_QC_DL		0x900e
> +

Johan, when he is back from vacation, will tell you to drop those 
defines and instead use the values directly in the list with a comment 
behind reflecting the device model.
Just telling you so you can save time by sending out your v2 early..


best rgds
/Lars
