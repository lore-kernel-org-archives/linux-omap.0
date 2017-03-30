From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv3] iio: adc: cpcap: Add minimal support for CPCAP PMIC ADC
Date: Thu, 30 Mar 2017 19:26:50 +0100
Message-ID: <3837adac-5dec-c645-1aeb-9425c0e73076@kernel.org>
References: <20170324033842.12541-1-tony@atomide.com>
 <20170329212637.syluvxy5cp2qub3h@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170329212637.syluvxy5cp2qub3h@rob-hp-laptop>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 29/03/17 22:26, Rob Herring wrote:
> On Thu, Mar 23, 2017 at 08:38:42PM -0700, Tony Lindgren wrote:
>> On Motorola phones like droid 4 there is a custom CPCAP PMIC. This PMIC
>> has ADCs that are used for battery charging and USB PHY VBUS and ID pin
>> detection.
>>
>> Unfortunately the only documentation for this ADC seems to be the
>> Motorola mapphone Linux kernel tree. I have tested that reading raw and
>> scaled values works, but I have not used the timed sampling that the ADC
>> seems to support.
>>
>> Let's add a minimal support for it so we can eventually provide IIO
>> channels for the related battery charging and USB PHY drivers.
>>
>> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
>> Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>> ---
>>
>> Changes since v2:
>>
>> - Simplify things further by using channel based indexing and
>>   remove more drivers specific enumerations
>>
>> Changes since v1:
>>
>> - Fix numerous issues pointed out by Peter Meerwald-Stadler
>>   <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org> and Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>>
>> - Simplify things further by limiting read functions to a
>>   single channel instead of a bank and got rid of the driver
>>   specific cpcap_adc_conv_type in favor of IIO generic types
>>
>> ---
>>  .../devicetree/bindings/iio/adc/cpcap-adc.txt      |   18 +
> 
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Been long enough now that I'm happy to take this.
Thanks for looking at the bindings Rob!

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Jonathan
> 
>>  drivers/iio/adc/Kconfig                            |   11 +
>>  drivers/iio/adc/Makefile                           |    1 +
>>  drivers/iio/adc/cpcap-adc.c                        | 1007 ++++++++++++++++++++
>>  4 files changed, 1037 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/cpcap-adc.txt
>>  create mode 100644 drivers/iio/adc/cpcap-adc.c
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
