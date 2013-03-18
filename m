From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 4/8] staging: rename omap-thermal driver to ti-soc-thermal
Date: Mon, 18 Mar 2013 22:17:10 +0300
Message-ID: <20130318191710.GV9138@mwanda>
References: <1363618756-15851-1-git-send-email-eduardo.valentin@ti.com>
 <1363618756-15851-5-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1363618756-15851-5-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, Nishanth Menon <nm@ti.com>, Benoit <b-cousson@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Mar 18, 2013 at 10:59:12AM -0400, Eduardo Valentin wrote:
> Because this driver will support also OMAP derivatives,
> this patch does a big rename inside this driver, so it
> better fits its usage.
> 

It would be better to do a minimal move patch which just renames the
files and updated the Makefile.  The following patches would rename
the functions.  That makes it easier to review.


> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Benoit <b-cousson@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> 
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>

Put a --- line here after the Signed-off-by line so that "git am"
doesn't include the diff stat in the changelog.

regards,
dan carpenter
