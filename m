From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/4] staging: omap-thermal: Correct checkpatch.pl warnings
Date: Wed, 12 Sep 2012 11:11:27 +0300
Message-ID: <20120912081127.GB19396@mwanda>
References: <1347379615-6881-1-git-send-email-eduardo.valentin@ti.com>
 <1347379615-6881-2-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1347379615-6881-2-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, b-cousson@ti.com, j-keerthy@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 11, 2012 at 07:06:52PM +0300, Eduardo Valentin wrote:
> From: J Keerthy <j-keerthy@ti.com>
> 
> Removes checkpatch warnings on omap-bandgap.c.
> 

Which checkpatch.pl warnings?

> +				omap_bandgap_writel(bg_ptr,
> +					rval->tshut_threshold,
> +						   tsr->tshut_threshold);

That's just whacky.

Personally, I've never cared much about long lines, so I'd prefer
to leave these as is until someone can break the functions up and
remove them in a proper way instead of just shifting everything
randomly to the left.

regards,
dan carpenter
