From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Letux-kernel] [PATCH v2] musb: omap2430: do not assume balanced
 enable()/disable()
Date: Thu, 4 Aug 2016 07:29:19 -0700
Message-ID: <20160804142919.GG28140@atomide.com>
References: <1470238731-32358-1-git-send-email-andreas@kemnade.info>
 <FFDA9A63-599B-44CA-B244-C8860D9E01D9@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <FFDA9A63-599B-44CA-B244-C8860D9E01D9@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux USB Mailing List <linux-usb@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org

Hi,

* H. Nikolaus Schaller <hns@goldelico.com> [160803 10:07]:
> All this prevents detection of cable plugin-events and VBUS measurement
> and setting OTG_EN before charging is attempted.

So I gave this patch a try but it now blocks all deeper SoC idle
states as the PHY stays active. I think the real fix is to make
sure the charger behaves independent of the USB PHY state. So
probably this needs to be fixed in phy-twl4030-usb.c and
twl4030_charger.c instead. Now it sounds like we're also shutting
down the charger with the USB PHY.

Regards,

Tony
