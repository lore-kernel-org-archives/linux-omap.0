From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2 01/15] nvmem: add support for cell lookups
Date: Thu, 28 Jun 2018 09:56:18 +0200
Message-ID: <CAMRc=Md8TM+zLn=T=BQeVHG-PGAvx-PHrs9y1t5zhdYo+m0ovg@mail.gmail.com>
References: <20180626102245.30711-1-brgl@bgdev.pl> <20180626102245.30711-2-brgl@bgdev.pl>
 <25ebceca-8cdd-edae-6393-dd29eb323c53@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <25ebceca-8cdd-edae-6393-dd29eb323c53@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, David Lechner <david@lechnology.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

2018-06-26 13:06 GMT+02:00 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>:
> Thanks for the patch,
>
> On 26/06/18 11:22, Bartosz Golaszewski wrote:
>>
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> We can currently only register nvmem cells from device tree or by
>> manually calling nvmem_add_cells(). The latter options however forces
>> users to make sure that the nvmem provider with which the cells are
>> associated is registered before the call.
>>
>> This patch proposes a new solution inspired by other frameworks that
>> offer resource lookups (GPIO, PWM etc.). It adds a function that allows
>> machine code to register nvmem lookup which are later lazily used to
>> add corresponding nvmem cells.
>>
> Overall the idea look fine to me.
>
> This needs to be documented in ./Documentation/nvmem/nvmem.txt
>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>   drivers/nvmem/core.c           | 57 +++++++++++++++++++++++++++++++++-
>>   include/linux/nvmem-consumer.h |  6 ++++
>>   include/linux/nvmem-provider.h |  6 ++++
>>   3 files changed, 68 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>> index b5b0cdc21d01..a2e87b464319 100644
>> --- a/drivers/nvmem/core.c
>> +++ b/drivers/nvmem/core.c
>> @@ -62,6 +62,9 @@ static DEFINE_IDA(nvmem_ida);
>>   static LIST_HEAD(nvmem_cells);
>>   static DEFINE_MUTEX(nvmem_cells_mutex);
>>   +static LIST_HEAD(nvmem_cell_lookups);
>> +static DEFINE_MUTEX(nvmem_lookup_mutex);
>> +
>>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>>   static struct lock_class_key eeprom_lock_key;
>>   #endif
>> @@ -247,6 +250,23 @@ static const struct attribute_group
>> *nvmem_ro_root_dev_groups[] = {
>>         NULL,
>>   };
>>   +/**
>> + * nvmem_register_lookup() - register a number of nvmem cell lookup
>> entries
>> + *
>
>
> Can we rename this to nvmem_add_lookup_table()?
> register sound bit heavy here.
>
> We should also have something like nvmem_remove_lookup_table() for
> consistency, and it should ensure that it clears the cells entry too.
>

What do you mean by clearing the cells entry exactly?

Bart

>
>> + * @lookup: array of nvmem cell lookup entries
>> + * @nentries: number of lookup entries in the array
>> + */
>> +void nvmem_register_lookup(struct nvmem_cell_lookup *lookup, size_t
>> nentries)
>> +{
>> +       int i;
>> + > +   mutex_lock(&nvmem_lookup_mutex);
>> +       for (i = 0; i < nentries; i++)
>> +               list_add_tail(&lookup[i].list, &nvmem_cell_lookups);
>> +       mutex_unlock(&nvmem_lookup_mutex);
>> +}
>> +EXPORT_SYMBOL_GPL(nvmem_register_lookup);
>> +
>>   static void nvmem_release(struct device *dev)
>>   {
>>         struct nvmem_device *nvmem = to_nvmem_device(dev);
>> @@ -916,6 +936,37 @@ struct nvmem_cell *of_nvmem_cell_get(struct
>> device_node *np,
>>   EXPORT_SYMBOL_GPL(of_nvmem_cell_get);
>>   #endif
>>
