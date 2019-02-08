From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] fbdev: omap2: no need to check return value of
 debugfs_create functions
Date: Fri, 8 Feb 2019 18:25:09 +0100
Message-ID: <5ad3b534-e673-9ff4-e171-a12445694938@samsung.com>
References: <CGME20190122152306epcas4p1c240839621d10e97226c657457805ea4@epcas4p1.samsung.com>
        <20190122152151.16139-15-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190122152151.16139-15-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org


On 01/22/2019 04:21 PM, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Cc: linux-omap@vger.kernel.org
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Patch queued for v5.1, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
