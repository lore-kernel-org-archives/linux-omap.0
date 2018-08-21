From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 06/29] mtd: Add support for reading MTD devices via the
 nvmem API
Date: Tue, 21 Aug 2018 10:50:07 +0100
Message-ID: <e0ec3194-fd3a-9b3d-fba8-f88447eb56e9@linaro.org>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-7-brgl@bgdev.pl> <20180817182720.6a6e5e8e@bbrezillon>
 <20180819133106.0420df5f@tock> <20180819184609.6dcdbb9a@bbrezillon>
 <5b8c30b8-41e1-d59e-542b-fef6c6469ff0@linaro.org>
 <20180820202038.5d3dc195@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180820202038.5d3dc195@bbrezillon>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Alban <albeu@free.fr>, Bartosz Golaszewski <brgl@bgdev.pl>, Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Naren <naren.kernel@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lukas Wunner <lukas@wunner.de>, Dan Carpenter <dan.carpenter@oracle.com>, Florian Fainelli <f.fainelli@gmail.co>
List-Id: linux-omap@vger.kernel.org



On 20/08/18 19:20, Boris Brezillon wrote:
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
This looks good to me.
> 	mtdnode {
> 		nvmem-cells {
> 			#address-cells = <1>;
> 			#size-cells = <1>;
> 
> 			cell@0 {
> 				reg = <0x0 0x14>;
> 			};
> 		};
> 
> 		partitions {
> 			compatible = "fixed-partitions";
> 			#address-cells = <1>;
> 			#size-cells = <1>;
> 
> 			partition@0 {
> 				reg = <0x0 0x20000>;
> 
> 				nvmem-cells {
> 					#address-cells = <1>;
> 					#size-cells = <1>;
> 
> 					cell@0 {
> 						reg = <0x0 0x10>;
> 					};
> 				};
> 			};
> 		};
> 	}; >

Just curious...Is there a reason why we can't do it like this?:
Is this because of issue of #address-cells and #size-cells Or mtd 
bindings always prefer subnodes?

	mtdnode {
		reg = <0x0123000 0x40000>;
		#address-cells = <1>;
		#size-cells = <1>;
		cell@0 {
			compatible = "nvmem-cell";
			reg = <0x0 0x14>;
		};

		partitions {
			compatible = "fixed-partitions";
			#address-cells = <1>;
			#size-cells = <1>;

			partition@0 {
				reg = <0x0 0x20000>;
				cell@0 {
					compatible = "nvmem-cell";
					reg = <0x0 0x10>;
				};
			};
		};
	};

Am okay either way!

thanks,
srini
