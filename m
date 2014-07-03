From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 1/3] ARM: DRA7: hwmod: Add OCP2SCP3 module
Date: Thu, 3 Jul 2014 19:48:41 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1407031948110.1515@utopia.booyaka.com>
References: <1404385274-5093-1-git-send-email-rogerq@ti.com> <1404385274-5093-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404385274-5093-2-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, rnayak@ti.com, kishon@ti.com, george.cherian@ti.com, balbi@ti.com, balajitk@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 3 Jul 2014, Roger Quadros wrote:

> This module is needed for the SATA and PCIe PHYs.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Reviewed-by: Rajendra Nayak <rnayak@ti.com>
> Tested-by: Sekhar Nori <nsekhar@ti.com>>

This looks like adding support for a new device, so, after 
discussing with Tony, queuing for v3.17.


- Paul
