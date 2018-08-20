From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2 06/29] mtd: Add support for reading MTD devices via the
 nvmem API
Date: Mon, 20 Aug 2018 20:50:55 +0200
Message-ID: <CAMRc=McwEjofZKP93DxPa8vJLE6NceLLGfcbcK9-Pfk-dav_Zg@mail.gmail.com>
References: <20180810080526.27207-1-brgl@bgdev.pl> <20180810080526.27207-7-brgl@bgdev.pl>
 <20180817182720.6a6e5e8e@bbrezillon> <20180819133106.0420df5f@tock>
 <20180819184609.6dcdbb9a@bbrezillon> <5b8c30b8-41e1-d59e-542b-fef6c6469ff0@linaro.org>
 <20180820202038.5d3dc195@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180820202038.5d3dc195@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Alban <albeu@free.fr>, Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Naren <naren.kernel@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lukas Wunner <lukas@wunner.de>, Dan Carpenter <dan.carpenter@oracle.com>, Florian
List-Id: linux-omap@vger.kernel.org

2018-08-20 20:20 GMT+02:00 Boris Brezillon <boris.brezillon@bootlin.com>:
> On Mon, 20 Aug 2018 11:43:34 +0100
> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:
>
>>
>> Overall am still not able to clear visualize on how MTD bindings with
>> nvmem cells would look in both partition and un-partition usecases?
>> An example DT would be nice here!!
>
> Something along those lines:
>
>         mtdnode {
>                 nvmem-cells {
>                         #address-cells = <1>;
>                         #size-cells = <1>;
>
>                         cell@0 {
>                                 reg = <0x0 0x14>;
>                         };
>                 };
>
>                 partitions {
>                         compatible = "fixed-partitions";
>                         #address-cells = <1>;
>                         #size-cells = <1>;
>
>                         partition@0 {
>                                 reg = <0x0 0x20000>;
>
>                                 nvmem-cells {
>                                         #address-cells = <1>;
>                                         #size-cells = <1>;
>
>                                         cell@0 {
>                                                 reg = <0x0 0x10>;
>                                         };
>                                 };
>                         };
>                 };
>         };

If there'll be an agreement on the bindings: will you be willing to
merge Alban's patch even without support in the code for the above
(with the assumption that it will be added later)? My use-case is on
non-DT systems and creating nvmem devices corresponding to MTD
partitions if fine by me. I also don't have the means to test the
support for these bindings if I were to actually write them myself.

Best regards,
Bartosz Golaszewski
