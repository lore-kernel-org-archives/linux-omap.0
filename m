From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 7/8] Regulator: Added board-dependent code for TPS65023
Date: Sat, 8 Aug 2009 08:45:24 +0100
Message-ID: <20090808074523.GA5005@sirena.org.uk>
References: <1249658970-11100-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933689AbZHHHpa@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1249658970-11100-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: lrg@slimlogic.co.uk, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 07, 2009 at 08:59:30PM +0530, Anuj Aggarwal wrote:

> +		},
> +		.num_consumer_supplies = 1,
> +		.consumer_supplies = &tps65023_core_consumers,
> +	},

This is all OK but as a style thing it's better to use ARRAY_SIZE() for
the number of consumers even if there's just one since that way if
someone adds another consumer they don't need to remember to adjust the
array length.
