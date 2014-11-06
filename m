From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH/v2] ARM: OMAP2: Remove unnecessary KERN_* in
 omap_phy_internal.c
Date: Thu, 6 Nov 2014 10:11:49 -0800
Message-ID: <20141106181149.GA31454@atomide.com>
References: <20141006162151.GA21908@kahuna>
 <1412691376-7895-1-git-send-email-standby24x7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1412691376-7895-1-git-send-email-standby24x7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masanari Iida <standby24x7@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, nm@ti.com
List-Id: linux-omap@vger.kernel.org

* Masanari Iida <standby24x7@gmail.com> [141007 07:17]:
> This patch remove unnecessary KERN_INFO and KERN_ERR from omap_phy_internal.c.
> Add pr_fmt. 

Applying into omap-for-v3.19/fixes-not-urgent thanks.

Tony
