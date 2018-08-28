From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 01/29] nvmem: add support for cell lookups
Date: Tue, 28 Aug 2018 15:48:21 +0100
Message-ID: <626e6122-2e58-3317-89b2-77959c9310f7@linaro.org>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-2-brgl@bgdev.pl> <20180824170848.29594318@bbrezillon>
 <20180824152740.GD27483@lunn.ch> <20180825082722.567e8c9a@bbrezillon>
 <CAMRc=Men-MPk5DGshWcVEc0v=gH2WSpx1j-CawOeydwp59tejw@mail.gmail.com>
 <20180827110055.122988d0@bbrezillon>
 <CAMRc=MfpZJUEAhM4OoLbmJcnX3rTJk8fvdiL6=9BjNkVcsf=SA@mail.gmail.com>
 <8cb75723-dc87-f127-2aab-54dd0b08eee8@linaro.org>
 <CAMRc=Mex5WAm8uiV4T=0+bLduBBdj18iekuYT55W9gA_rzQ_sg@mail.gmail.com>
 <916e3e89-82b3-0d52-2b77-4374261a9d0f@linaro.org>
 <CAMRc=MeALxpyBQhWxGPt9BubO_ZwKGih1d8zhRzFYZ0+3kHFAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMRc=MeALxpyBQhWxGPt9BubO_ZwKGih1d8zhRzFYZ0+3kHFAA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, linux-doc <linux-doc@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-i2c <linux-i2c@vger.kernel.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Marek Vasut <marek.vasut@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Dan Carpenter <dan.carpenter@oracle.com>, Grygorii Strashko <grygorii.strashko@ti.com>, David Lechner <david@lechnology.com>, Arnd Bergmann <arnd@arndb.de>, Sven Van Asbroeck <svendev@arcx.com>, open list:
List-Id: linux-omap@vger.kernel.org



On 28/08/18 15:41, Bartosz Golaszewski wrote:
> 2018-08-28 15:45 GMT+02:00 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>:
>>
>>
...
>>> I would like to support an additional use case here: the provider is
>>> generic and is not aware of its cells at all. Since the only way of
>>> defining nvmem cells is through DT or nvmem_config, we lack a way to
>>> allow machine code to define cells without the provider code being
>>> aware.
>>
>>
>> machine driver should be able to do
>> nvmem_device_get()
>> nvmem_add_cells()
>>
> 
> Indeed, I missed the fact that you can retrieve the nvmem device by
> name. Except that we cannot know that the nvmem provider has been
> registered yet when calling nvmem_device_get(). This could potentially
> be solved by my other patch that adds notifiers to nvmem, but it would
> require much more boilerplate code in every board file. I think that
> removing nvmem_cell_info from nvmem_config and having external cell
> definitions would be cleaner.

Yes, notifiers would work!

...
>>>
>>> Yes, I would like to rework nvmem a bit. I don't see any non-DT users
>>> defining nvmem-cells using nvmem_config. I think that what we need is
>>> a way of specifying cell config outside of nvmem providers in some
>>> kind of structures. These tables would reference the provider by name
>>> and define the cells. Then we would have an additional lookup
>>> structure which would associate the consumer (by dev_id and con_id,
>>> where dev_id could optionally be NULL and where we would fall back to
>>> using con_id only) and the nvmem provider + cell together. Similarly
>>> to how GPIO consumers are associated with the gpiochip and hwnum. How
>>> does it sound?
>>
>> Yes, sounds good.
>>
>> Correct me if am wrong!
>> You should be able to add the new cells using struct nvmem_cell_info and add
>> them to particular provider using nvmem_add_cells().
>>
>> Sounds like thats exactly what nvmem_add_lookup_table() would look like.
>>
>> We should add new nvmem_device_cell_get(nvmem, conn_id) which would return
>> nvmem cell which is specific to the provider. This cell can be used by the
>> machine driver to read/write.
> 
> Except that we could do it lazily - when the nvmem provider actually
> gets registered instead of doing it right away and risking that the
> device isn't even there yet.
> 
Yes, it makes more sense to do it once the provider is actually present!

>>
>>>>>
>>>>> BTW: of_nvmem_cell_get() seems to always allocate an nvmem_cell
>>>>> instance even if the cell for this node was already added to the nvmem
>>>>> device.
>>>>
>>>>
>>>> I hope you got the reason why of_nvmem_cell_get() always allocates new
>>>> instance for every get!!
>>>
>>>
>>>
>>> I admit I didn't test it, but just from reading the code it seems like
>>> in nvmem_cell_get() for DT-users we'll always get to
>>> of_nvmem_cell_get() and in there we always end up calling line 873:
>>> cell = kzalloc(sizeof(*cell), GFP_KERNEL);
>>>
>> That is correct, this cell is created when we do a get and release when we
>> do a put().
>>
> 
> Shouldn't we add the cell to the list, and check first if it's there
> and only create it if not?
Yes I agree, duplicate entry checks are missing!

--srini
> 
> Bart
> 
