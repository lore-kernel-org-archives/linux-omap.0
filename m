From: Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH 05/12] staging:tidspbridge - set5 remove hungarian from
 structs
Date: Wed, 15 Dec 2010 11:53:05 +0300
Message-ID: <20101215085305.GC1639@bicker>
References: <1292358798-25875-1-git-send-email-rene.sapiens@ti.com>
 <1292358798-25875-2-git-send-email-rene.sapiens@ti.com>
 <1292358798-25875-3-git-send-email-rene.sapiens@ti.com>
 <1292358798-25875-4-git-send-email-rene.sapiens@ti.com>
 <1292358798-25875-5-git-send-email-rene.sapiens@ti.com>
 <1292358798-25875-6-git-send-email-rene.sapiens@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1292358798-25875-6-git-send-email-rene.sapiens@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rene Sapiens <rene.sapiens@ti.com>
Cc: omar.ramirez@ti.com, nm@ti.com, ohad@wizery.com, ionut.nicu@mindbit.ro, devel@driverdev.osuosl.org, ivan.gomez@ti.com, x0095078@ti.com, felipe.contreras@gmail.com, ernesto@ti.com, linux-kernel@vger.kernel.org, x0095840@ti.com, linux-omap@vger.kernel.org, ameya.palande@nokia.com
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 14, 2010 at 02:33:11PM -0600, Rene Sapiens wrote:
> -				    pfn_unload(pnode->nldr_node_obj,
> +				    load(pnode->nldr_node_obj,
>  					       NLDR_EXECUTE);

Unload got swapped with load here.

This might have been easier to with Coccinelle instead of by hand...

regards,
dan carpenter
