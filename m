From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCHv2 2/3] Regulator: Add TPS6507x regulator driver
Date: Thu, 20 Aug 2009 19:38:18 +0100
Message-ID: <20090820183817.GA5032@sirena.org.uk>
References: <1250776230-18245-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1250776230-18245-1-git-send-email-anuj.aggarwal-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anuj Aggarwal <anuj.aggarwal-l0cyMroinI0@public.gmane.org>
Cc: lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 20, 2009 at 07:20:30PM +0530, Anuj Aggarwal wrote:

One very minor issue:

> +struct tps_pmic {
> +	struct regulator_desc desc[TPS6507X_NUM_REGULATOR];
> +	struct i2c_client *client;
> +	struct regulator_dev *rdev[TPS6507X_NUM_REGULATOR];
> +	struct tps_info *info[TPS6507X_NUM_REGULATOR];

This should be const struct tps_info * since the table of tps_info
structs that this points into is const; otherwise you'll get warnings
from at least sparse.

Otherwise this looks good - I'd be happy to ack this with a followup
patch fixing this issue.
