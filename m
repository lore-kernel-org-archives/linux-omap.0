From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v2 14/14] rpmsg: pru: add a PRU RPMsg driver
Date: Mon, 4 Feb 2019 09:26:02 -0600
Message-ID: <e97f7bfc-a3c2-92a9-953e-572d9438d020@ti.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-15-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549290167-876-15-git-send-email-rogerq@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, tony@atomide.com, ohad@wizery.com, bjorn.andersson@linaro.org
Cc: s-anna@ti.com, david@lechnology.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 2/4/19 8:22 AM, Roger Quadros wrote:
> From: Jason Reeder <jreeder@ti.com>
> 

[...]

> +/* .name matches on RPMsg Channels and causes a probe */
> +static const struct rpmsg_device_id rpmsg_driver_pru_id_table[] = {
> +	{ .name	= "rpmsg-pru" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(rpmsg, rpmsg_driver_pru_id_table);
> +
> +static struct rpmsg_driver rpmsg_pru_driver = {
> +	.drv.name	= KBUILD_MODNAME,
> +	.id_table	= rpmsg_driver_pru_id_table,
> +	.probe		= rpmsg_pru_probe,
> +	.callback	= rpmsg_pru_cb,
> +	.remove		= rpmsg_pru_remove,
> +};
> +
> +static int __init rpmsg_pru_init(void)
> +{
> +	int ret;
> +
> +	rpmsg_pru_class = class_create(THIS_MODULE, "rpmsg_pru");
> +	if (IS_ERR(rpmsg_pru_class)) {
> +		pr_err("Unable to create class\n");
> +		ret = PTR_ERR(rpmsg_pru_class);
> +		goto fail_create_class;
> +	}
> +
> +	ret = alloc_chrdev_region(&rpmsg_pru_devt, 0, PRU_MAX_DEVICES,
> +				  "rpmsg_pru");
> +	if (ret) {
> +		pr_err("Unable to allocate chrdev region\n");
> +		goto fail_alloc_region;
> +	}
> +
> +	ret = register_rpmsg_driver(&rpmsg_pru_driver);
> +	if (ret) {
> +		pr_err("Unable to register rpmsg driver");
> +		goto fail_register_rpmsg_driver;
> +	}
> +
> +	return 0;
> +
> +fail_register_rpmsg_driver:
> +	unregister_chrdev_region(rpmsg_pru_devt, PRU_MAX_DEVICES);
> +fail_alloc_region:
> +	class_destroy(rpmsg_pru_class);
> +fail_create_class:
> +	return ret;
> +}
> +
> +static void __exit rpmsg_pru_exit(void)
> +{
> +	unregister_rpmsg_driver(&rpmsg_pru_driver);
> +	idr_destroy(&rpmsg_pru_minors);
> +	mutex_destroy(&rpmsg_pru_lock);
> +	class_destroy(rpmsg_pru_class);
> +	unregister_chrdev_region(rpmsg_pru_devt, PRU_MAX_DEVICES);
> +}
> +
> +module_init(rpmsg_pru_init);
> +module_exit(rpmsg_pru_exit);
> +
> +MODULE_AUTHOR("Jason Reeder <jreeder@ti.com>");
> +MODULE_ALIAS("rpmsg:rpmsg-pru");

MODULE_ALIAS not needed, MODULE_DEVICE_TABLE will generate the alias.

Andrew

> +MODULE_DESCRIPTION("PRU Remote Processor Messaging Driver");
> +MODULE_LICENSE("GPL v2");
> 
