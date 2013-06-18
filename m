From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v2 2/4] MFD: Palmas: Add SMPS10_BOOST feature
Date: Tue, 18 Jun 2013 09:53:15 -0600
Message-ID: <51C0826B.4060101@wwwdotorg.org>
References: <1371549794-7406-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1371549794-7406-1-git-send-email-j-keerthy@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: J Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, broonie@kernel.org, ldewangan@nvidia.com, sameo@linux.intel.com, grant.likely@secretlab.ca, swarren@nvidia.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, gg@slimlogic.co.uk
List-Id: linux-omap@vger.kernel.org

On 06/18/2013 04:03 AM, J Keerthy wrote:
> The SMPS10 regulator is not presesnt in all the variants
> of the PALMAS PMIC family. Hence adding a feature to distingush
> between them.

> diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c

> +	match = of_match_device(of_match_ptr(of_palmas_match_tbl), &i2c->dev);
> +
> +	if (match) {
> +		features = (unsigned int *)match->data;
> +		palmas->features = *features;
> +	} else {
> +		return -ENODATA;
> +	}


I think it's more common to do the error-checking first. That way, the
success-case code doesn't need an indent:

match = of_match...(...);
if (!match)
    return -ENODATA;

features = ...;
palmas->features = *features;

