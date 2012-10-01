From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCHv3 2/4] Input: keypad: Add smsc ece1099 keypad driver
Date: Mon, 01 Oct 2012 20:28:20 +0530
Message-ID: <5069AF8C.2070807@ti.com>
References: <1349089310-22134-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1349089310-22134-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, b-cousson@ti.com, balbi@ti.com, santosh.shilimkar@ti.com, dmitry.torokhov@gmail.com
List-Id: linux-omap@vger.kernel.org

On Monday 01 October 2012 04:31 PM, Sourav Poddar wrote:
> +smsc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct smsc *smsc = dev_get_drvdata(pdev->dev.parent);
> +	struct input_dev *input;
> +	struct smsc_keypad *kp;
> +	int ret = 0, error;
> +	int col, i, max_keys, row_shift;
> +	int irq;
> +	int addr;
> +
> +	kp = devm_kzalloc(dev, sizeof(*kp), GFP_KERNEL);
> +
> +	input = input_allocate_device();
> +	if (!kp || !input) {
> +		error = -ENOMEM;
> +		goto err1;
> +	}
> +
> +	error = smsc_keypad_parse_dt(&pdev->dev, kp);
> +	if (error)
> +		return error;
>
Are we leaking input here?
