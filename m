From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v3 1/6] mfd: TPS65910: Handle non-existent devices
Date: Fri, 4 Nov 2011 05:53:01 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A9018E59@DBDE01.ent.ti.com>
References: <1320340086-15371-1-git-send-email-kyle.manna@fuel7.com>
 <1320340086-15371-2-git-send-email-kyle.manna@fuel7.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1320340086-15371-2-git-send-email-kyle.manna@fuel7.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle Manna <kyle.manna@fuel7.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Girdwood, Liam" <lrg@ti.com>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

Hi Kyla,

On Thu, Nov 03, 2011 at 22:38:01, Kyle Manna wrote:
> The JTAGREVNUM register contains a silicon revision number in the lower
> four bits and the upper four bits are to always read 0.
> 
> To detect the presence of the device, attempt to read JTAGREVNUM
> register and check that it returns a valid value.  If the I2C device
> fails to respond or returns an invalid value, return -ENODEV.
> 
:
:
> +	/* Check that the device is there */
> +	ret = tps65910_i2c_read(tps65910, TPS65910_JTAGVERNUM, 1, &reg);
> +	if (ret < 0 || (reg & ~JTAGVERNUM_VERNUM_MASK)) {
> +		dev_err(tps65910->dev, "unknown version: JTAGREVNUM = 0x%x\n",
> +				       reg);
> +		ret = -ENODEV;
>  		goto err;
> +	}

If i2c read fails, "0" would get printed as version.

Perhaps it would be better to print version irrespective of whether it
is unknown or not, and return error for unknown value, something like,

        unsigned char buff;

        /* Check that the device is actually there */
        ret = tps65910_i2c_read(tps65910, 0x0, 1, &buff);
        if (ret < 0) {
                dev_err(tps65910->dev, "could not be detected\n");
                ret = -ENODEV;
                goto err;
        }

        dev_info(tps65910->dev, "JTAGREVNUM 0x%x\n", buff);

        if (buff & ~JTAGVERNUM_VERNUM_MASK) {
                dev_err(tps65910->dev, "unknown version\n");
                ret = -ENODEV;
                goto err;
        }



Regards
Afzal
