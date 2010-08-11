From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/4]  Low-level initialization for hsmmc controller on LogicPD's OMAP3 SOM and TORPEDO dev kits
Date: Wed, 11 Aug 2010 11:07:05 -0700
Message-ID: <87lj8d2fcm.fsf@deeprootsystems.com>
References: <1281544297-18015-1-git-send-email-Jacob.Tanenbaum@logicpd.com>
	<1281544297-18015-2-git-send-email-Jacob.Tanenbaum@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1281544297-18015-2-git-send-email-Jacob.Tanenbaum@logicpd.com>
	(Jacob Tanenbaum's message of "Wed, 11 Aug 2010 12:31:35 -0400")
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Tanenbaum <Jacob.Tanenbaum@logicpd.com>
Cc: linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Jacob Tanenbaum <Jacob.Tanenbaum@logicpd.com> writes:

>     	ARM: OMAP3LOGIC: Adding SDMMC support
>              Add low-level initialization for hsmmc controller for
>              LogicPD's OMAP 3530 LV SOM and OMAP 35x Torpedo board.

Also removes mux setup of SDRC pins which is not described here.

Kevin
