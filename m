From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 1/2] extcon: fix hang and extcon_get/set_cable_state().
Date: Tue, 7 Jul 2015 15:58:43 +0300
Message-ID: <559BCD03.30103@ti.com>
References: <1436194018-18696-1-git-send-email-rogerq@ti.com>	 <1436194018-18696-2-git-send-email-rogerq@ti.com> <1436272845.2190.3.camel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436272845.2190.3.camel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
Cc: cw00.choi@samsung.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On 07/07/15 15:40, Ivan T. Ivanov wrote:
>
> On Mon, 2015-07-06 at 17:46 +0300, Roger Quadros wrote:
>
>>
>> -static int find_cable_index_by_name(struct extcon_dev *edev, const char *name)
>> +static int find_cable_id_by_name(struct extcon_dev *edev, const char *name)
>>   {
>> -       unsigned int id = EXTCON_NONE;
>> +       unsigned int id = -EINVAL;
>>          int i = 0;
>>
>> -       if (edev->max_supported == 0)
>> -               return -EINVAL;
>> -
>> -       /* Find the the number of extcon cable */
>> +       /* Find the id of extcon cable */
>>          while (extcon_name[i]) {
>>                  if (!strncmp(extcon_name[i], name, CABLE_NAME_MAX)) {
>>                          id = i;
>> @@ -140,6 +137,19 @@ static int find_cable_index_by_name(struct extcon_dev *edev, const char *name)
>>                  }
>>          }
>>
>
> Thank you Roger, but this still hang. 'i' is not incremented.

You are right. Thanks for pointing out.
I will send out a v2.

>
> Ivan
>
>> +       return id;
>> +};
>>

cheers,
-roger
