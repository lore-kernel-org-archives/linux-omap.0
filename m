From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM:DTS:OMAP3:Fix Card Detect and Write Protect on Logic
 PD SOM-LV
Date: Tue, 17 Jan 2017 13:53:33 -0800
Message-ID: <20170117215332.GU7403@atomide.com>
References: <1484681646-16124-1-git-send-email-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1484681646-16124-1-git-send-email-aford173@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: linux-omap@vger.kernel.org, stable@vger.kernel.org, adam.ford@logicpd.com
List-Id: linux-omap@vger.kernel.org

* Adam Ford <aford173@gmail.com> [170117 11:36]:
> This fixes commit ab8dd3aed011 ("ARM: DTS: Add minimal Support for
> Logic PD DM3730 SOM-LV") where the Card Detect and Write Protect
> pins were improperly configured.

OK applying into omap-for-v4.10/fixes. I corrected the following:

- Unified the subject to start with "ARM: dts: omap3: ..."
- Added a Fixes: tag

Can you please check those next time so I don't have to manually
edit patches?

Thanks,

Tony
