From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v6 07/12] usb: otg: add OTG/dual-role core
Date: Wed, 20 Apr 2016 09:54:49 +0300
Message-ID: <571727B9.7090807@ti.com>
References: <1459865117-7032-1-git-send-email-rogerq@ti.com>
 <1459865117-7032-8-git-send-email-rogerq@ti.com>
 <20160415092534.GA21274@shlinux2.ap.freescale.net> <5710C9DE.2050106@ti.com>
 <20160418020929.GA32090@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160418020929.GA32090@shlinux2.ap.freescale.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: stern@rowland.harvard.edu, balbi@kernel.org, gregkh@linuxfoundation.org, peter.chen@freescale.com, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, abrestic@chromium.org, r.baldyga@samsung.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 18/04/16 05:09, Peter Chen wrote:
> On Fri, Apr 15, 2016 at 02:00:46PM +0300, Roger Quadros wrote:
>> On 15/04/16 12:25, Peter Chen wrote:
>>> On Tue, Apr 05, 2016 at 05:05:12PM +0300, Roger Quadros wrote:
>>>> + * usb_otg_register() - Register the OTG/dual-role device to OTG core
>>>> + * @dev: OTG/dual-role controller device.
>>>> + * @config: OTG configuration.
>>>> + *
>>>> + * Registers the OTG/dual-role controller device with the USB OTG core.
>>>> + *
>>>> + * Return: struct usb_otg * if success, ERR_PTR() if error.
>>>> + */
>>>> +struct usb_otg *usb_otg_register(struct device *dev,
>>>> +				 struct usb_otg_config *config)
>>>> +{
>>>> +	struct usb_otg *otg;
>>>> +	struct otg_wait_data *wait;
>>>> +	int ret = 0;
>>>> +
>>>> +	if (!dev || !config || !config->fsm_ops)
>>>> +		return ERR_PTR(-EINVAL);
>>>> +
>>>> +	/* already in list? */
>>>> +	mutex_lock(&otg_list_mutex);
>>>> +	if (usb_otg_get_data(dev)) {
>>>> +		dev_err(dev, "otg: %s: device already in otg list\n",
>>>> +			__func__);
>>>> +		ret = -EINVAL;
>>>> +		goto unlock;
>>>> +	}
>>>> +
>>>> +	/* allocate and add to list */
>>>> +	otg = kzalloc(sizeof(*otg), GFP_KERNEL);
>>>> +	if (!otg) {
>>>> +		ret = -ENOMEM;
>>>> +		goto unlock;
>>>> +	}
>>>> +
>>>> +	otg->dev = dev;
>>>> +	otg->caps = config->otg_caps;
>>>> +
>>>> +	if ((otg->caps->hnp_support || otg->caps->srp_support ||
>>>> +	     otg->caps->adp_support) && !config->otg_work)
>>>> +		dev_info(dev, "otg: limiting to dual-role\n");
>>>
>>> What does above mean? Customized otg_work item may be dual-role,
>>> may be full otg.
>>
>> I'm checking for !config->otg_work so we're sure of using the
>> default dual-role only work function.
>>
> 
> I see. But whether it is dual-role or fully otg should depend on
> otg->caps, the work item may be different according to design.
> Besides, your code seems to depend on one of the otg capabilities
> for dual-role.
> 
Which capability? Id/vbus status?

Are you OK with this patch?

cheers,
-roger
