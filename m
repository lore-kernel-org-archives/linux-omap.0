From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 0/5] cpsw interrupt pacing and get/set phy setting
 implementation
Date: Wed, 13 Mar 2013 04:39:09 -0400 (EDT)
Message-ID: <20130313.043909.1985225524093989490.davem@davemloft.net>
References: <1363079798-18147-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1363079798-18147-1-git-send-email-mugunthanvnm@ti.com>
Sender: netdev-owner@vger.kernel.org
To: mugunthanvnm@ti.com
Cc: netdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, b-cousson@ti.com, paul@pwsan.com
List-Id: linux-omap@vger.kernel.org

From: Mugunthan V N <mugunthanvnm@ti.com>
Date: Tue, 12 Mar 2013 14:46:33 +0530

> This patch serires implements the following features in CPSW driver
> * get/set phy link settings
> * interrupt pacing
> * get phy id via ioctl cmd SIOCGMIIPHY
> 
> Changes from initial version
> * Made active-slave common for cpts, ethtool and SIOCGMIIPHY ioctl
> * Cleaned CPSW DT binding documentation by seperating slave nodes
>   under sub-section
> * implemented get phy id via ioctl cmd SIOCGMIIPHY

Series applied, thanks.
