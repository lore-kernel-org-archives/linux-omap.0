From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: AM33xx: PRM: Remove wrongly defined RSTST offset
 for PER Domain
Date: Wed, 22 Jun 2016 01:00:29 -0700
Message-ID: <20160622080028.GD22406@atomide.com>
References: <1466503706-5292-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1466503706-5292-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: rnayak@codeaurora.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, afzal@ti.com, d-gerlach@ti.com, s-anna@ti.com, paul@pwsan.com, linux@armlinux.org.uk
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [160621 03:11]:
> As per the TRM: http://www.ti.com/lit/ug/spruh73m/spruh73m.pdf
> offset 0x4 is reserved for PRM_PER. Hence removing the wrongly
> defined address offset.

Applying into omap-for-v4.8/dt thanks.

Tony
