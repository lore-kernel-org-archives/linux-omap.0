From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC PATCH 7/8] misc: emif: add one-time settings
Date: Thu, 16 Feb 2012 16:14:16 +0530
Message-ID: <4F3CDE00.1080407@ti.com>
References: <1328357771-31644-1-git-send-email-aneesh@ti.com> <1328357771-31644-8-git-send-email-aneesh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1328357771-31644-8-git-send-email-aneesh@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aneesh V <aneesh@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-omap@vger.kernel.org

On Saturday 04 February 2012 05:46 PM, Aneesh V wrote:
> Add settings that are not dependent on frequency
> or any other transient parameters
> 
Expand the changelog a bit. One time settings like
SDRAM_CONFIG, PHY_CONTROL, TEMP alert etc.

> Signed-off-by: Aneesh V <aneesh@ti.com>
> ---
Patch looks fine.

Regards
santosh
