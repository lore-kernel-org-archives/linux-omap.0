From: Rob Clark <rob@ti.com>
Subject: Re: [PATCH] staging: drm/omap: fix missing include on omap_crtc
Date: Thu, 29 Nov 2012 15:13:16 -0600
Message-ID: <50B7CFEC.6040109@ti.com>
References: <1354107300-26619-1-git-send-email-eballetbo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46009 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754768Ab2K2VN4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Nov 2012 16:13:56 -0500
In-Reply-To: <1354107300-26619-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo i Serra <eballetbo@gmail.com>
Cc: gregkh@linuxfoundation.org, laurent.pinchart@ideasonboard.com, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, Enric Balletbo i Serra <eballetbo@iseebcn.com>

On 11/28/2012 06:55 AM, Enric Balletbo i Serra wrote:
> From: Enric Balletbo i Serra <eballetbo@iseebcn.com>
>
> This fixes following error:
>
> | ...
> | CC [M]  drivers/staging/omapdrm/omap_crtc.o
> | .../omapdrm/omap_crtc.c:22:22: fatal error: drm_mode.h: No such file or directory
> | ...

fwiw, I have this patch in my local tree that is fixing the same issue:

https://patchwork.kernel.org/patch/1588461/


and I think I've seen at least one other patch for the same thing..   it 
would be nice to at least get one version of this fix in 3.7..

BR,
-R

>
> Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
> ---
>   drivers/staging/omapdrm/omap_crtc.c |    4 ++--
>   1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/omapdrm/omap_crtc.c b/drivers/staging/omapdrm/omap_crtc.c
> index 732f2ad..1d54fe9 100644
> --- a/drivers/staging/omapdrm/omap_crtc.c
> +++ b/drivers/staging/omapdrm/omap_crtc.c
> @@ -17,9 +17,9 @@
>    * this program.  If not, see <http://www.gnu.org/licenses/>.
>    */
>   
> -#include "omap_drv.h"
> +#include <drm/drm_mode.h>
>   
> -#include "drm_mode.h"
> +#include "omap_drv.h"
>   #include "drm_crtc.h"
>   #include "drm_crtc_helper.h"
>   

