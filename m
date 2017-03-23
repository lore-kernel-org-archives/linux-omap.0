From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv2] iio: adc: cpcap: Add minimal support for CPCAP PMIC ADC
Date: Thu, 23 Mar 2017 15:14:52 -0700
Message-ID: <20170323221452.GU10760@atomide.com>
References: <20170322233726.5391-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170322233726.5391-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [170322 16:39]:
> +/**
> + * enum cpcap_adc_type - cpcap adc types
> + *
> + * Two banks of channels with eight channels in each. The first two channels
> + * in bank0 can be muxed for other functionality with CPCAP_ADC_TYPE_BATT_PI.
> + */
> +enum cpcap_adc_type {
> +	CPCAP_ADC_TYPE_BANK_0,
> +	CPCAP_ADC_TYPE_BANK_1,
> +	CPCAP_ADC_TYPE_BATT_PI,
> +};

Hmm looks like I only got half done yesterday.. I can now get
rid of the above in favor of using just channels.

> +static void cpcap_adc_phase(struct cpcap_adc_request *req, int index)
> +{
> +	const struct cpcap_adc_conversion_tbl *conv_tbl;
> +	const struct cpcap_adc_phasing_tbl *phase_tbl;
> +	int tbl_index;
> +
> +	switch (req->type) {
> +	case CPCAP_ADC_TYPE_BANK_0:
> +		conv_tbl = bank0_conversion;
> +		phase_tbl = bank0_phasing;
> +		tbl_index = index;
> +		break;
> +	case CPCAP_ADC_TYPE_BANK_1:
> +		conv_tbl = bank1_conversion;
> +		phase_tbl = bank1_phasing;
> +		tbl_index = index;
> +		break;
> +	case CPCAP_ADC_TYPE_BATT_PI:
> +		conv_tbl = bank0_conversion;
> +		phase_tbl = bank0_phasing;
> +		tbl_index = (index % 2) ? CPCAP_ADC_BATTI :
> +			CPCAP_ADC_BATTP;
> +		break;
> +	default:
> +		return;
> +	}

And then the above switch will go away.

> +static void cpcap_adc_convert(struct cpcap_adc_request *req, int index)
> +{
> +	const struct cpcap_adc_conversion_tbl *conv_tbl;
> +	int tbl_index;
> +
> +	switch (req->type) {
> +	case CPCAP_ADC_TYPE_BANK_0:
> +		conv_tbl = bank0_conversion;
> +		tbl_index = index;
> +		break;
> +	case CPCAP_ADC_TYPE_BANK_1:
> +		conv_tbl = bank1_conversion;
> +		tbl_index = index;
> +		break;
> +	case CPCAP_ADC_TYPE_BATT_PI:
> +		conv_tbl = bank0_conversion;
> +		tbl_index = (index % 2) ?
> +			CPCAP_ADC_BATTI : CPCAP_ADC_BATTP;
> +		break;
> +	default:
> +		return;
> +	}

And here too.

> +static int cpcap_adc_init_request(struct cpcap_adc_request *req,
> +				  int channel)
> +{
> +	switch (channel) {
> +	case 0 ... 7:
> +		req->bank_index = channel;
> +		req->type = CPCAP_ADC_TYPE_BANK_0;
> +		break;
> +	case 8 ... 15:
> +		req->bank_index = channel - 8;
> +		req->type = CPCAP_ADC_TYPE_BANK_1;
> +		break;
> +	case 16 ... 17:
> +		req->bank_index = channel - 16;
> +		req->type = CPCAP_ADC_TYPE_BATT_PI;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

And this can be done by indexing everything with just the
channels. So I'll be posting v3 of this patch at some point
hopefully later on today.

Regards,

Tony
