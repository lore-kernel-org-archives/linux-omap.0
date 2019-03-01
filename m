From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] fbdev: omap2: fix warnings in dss core
Date: Fri, 1 Mar 2019 15:45:52 +0100
Message-ID: <5ceb8653-055d-e4eb-a705-0bfd243e132c@samsung.com>
References: <CGME20190213084828epcas3p2d7f70d63c5e267197de5513ae96b4fc2@epcas3p2.samsung.com>
        <20190213084721.29624-1-anders.roxell@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213084721.29624-1-anders.roxell@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Anders Roxell <anders.roxell@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


On 02/13/2019 09:47 AM, Anders Roxell wrote:
> Commit 60d2fa0dad06 ("fbdev: omap2: no need to check return value of
> debugfs_create functions") changed the declaration of the return value
> of function dss_debugfs_create_file() and the following two warnings
> appeared:
> 
> drivers/video/fbdev/omap2/omapfb/dss/core.c: In function ‘dss_debugfs_create_file’:
> drivers/video/fbdev/omap2/omapfb/dss/core.c:139:9: warning: ‘return’ with a value,
>  in function returning void
>   return 0;
>          ^
> drivers/video/fbdev/omap2/omapfb/dss/core.c: In function ‘omap_dss_probe’:
> drivers/video/fbdev/omap2/omapfb/dss/core.c:172:6: warning: unused variable ‘r’
>  [-Wunused-variable]
>   int r;
>       ^
> 
> Rework so function dss_debugfs_create_file() that is declared to return
> void don't 'return 0' and remove the declaration of the unused variable
> 'r'.
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Patch queued for v5.1, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
