From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V2 2/2] Input: misc: introduce palmas-pwrbutton
Date: Thu, 21 Aug 2014 10:05:12 -0700
Message-ID: <20140821170512.GA3796@core.coreip.homeip.net>
References: <1408392810-16011-1-git-send-email-nm@ti.com>
 <1408636935-29515-1-git-send-email-nm@ti.com>
 <1408636935-29515-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1408636935-29515-3-git-send-email-nm@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Nishanth,

On Thu, Aug 21, 2014 at 11:02:15AM -0500, Nishanth Menon wrote:
> +
> +	ret = input_register_device(input_dev);
> +	if (ret) {
> +		free_irq(irq, pwron);

You can not use free_irq with devm-managed resources. As I mentioned, since you
need manual unwinding, I'd rather you not use managed resources in the driver
at all.

> +		cancel_delayed_work_sync(&pwron->input_work);
> +		dev_dbg(dev, "Can't register power button: %d\n", ret);
> +		return ret;

Thanks.

-- 
Dmitry
