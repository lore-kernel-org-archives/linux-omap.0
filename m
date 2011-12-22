From: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 02/11] i2c: OMAP: Add DT support for i2c controller
Date: Thu, 22 Dec 2011 09:55:39 +0100
Message-ID: <4EF2F08B.4070907@ti.com>
References: <1324398444-23296-1-git-send-email-b-cousson@ti.com>
 <1324398444-23296-3-git-send-email-b-cousson@ti.com>
 <4EF0BB03.6040906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <4EF0BB03.6040906-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Rob,

On 12/20/2011 5:42 PM, Rob Herring wrote:
> On 12/20/2011 10:27 AM, Benoit Cousson wrote:
>> Add initial DT support to retrieve the frequency using a
>> DT attribute instead of the pdata pointer if of_node exist.
>>
>> Add documentation for omap i2c controller binding.
>>
>> Based on original patches from Manju and Grant.
>>
>> Signed-off-by: Benoit Cousson<b-cousson-l0cyMroinI0@public.gmane.org>
>> Cc: Ben Dooks<ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
>> Cc: Kevin Hilman<khilman-l0cyMroinI0@public.gmane.org>
>
> One issue below, otherwise:
>
> Reviewed-by: Rob Herring<rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
>
>
>> @@ -1001,15 +1019,24 @@ omap_i2c_probe(struct platform_device *pdev)
>>   		goto err_release_region;
>>   	}
>>
>> -	if (pdata != NULL) {
>> -		speed = pdata->clkrate;
>> +	match = of_match_device(omap_i2c_of_match,&pdev->dev);
>> +	if (match) {
>> +		u32 freq = 100000; /* default to 100000 Hz */
>> +
>> +		pdata = match->data;
>> +		dev->dtrev = pdata->rev;
>> +		dev->flags = pdata->flags;
>> +
>> +		of_property_read_u32(node, "clock-frequency",&freq);
>> +		/* convert DT freq value in Hz into kHz for speed */
>> +		dev->speed = freq / 1000;
>> +	} else if (pdata != NULL) {
>> +		dev->speed = pdata->clkrate;
>> +		dev->flags = pdata->flags;
>>   		dev->set_mpu_wkup_lat = pdata->set_mpu_wkup_lat;
>> -	} else {
>> -		speed = 100;	/* Default speed */
>> -		dev->set_mpu_wkup_lat = NULL;
>> +		dev->dtrev = pdata->rev;
>
> If you get here, pdata is NULL.

Mmm, it should not. It's true that the patch is not super readable, but 
here is the result:

	if (match) {
		u32 freq = 100000; /* default to 100000 Hz */

		pdata = match->data;
		dev->dtrev = pdata->rev;
		dev->flags = pdata->flags;

		of_property_read_u32(node, "clock-frequency", &freq);
		/* convert DT freq value in Hz into kHz for speed */
		dev->speed = freq / 1000;
	} else if (pdata != NULL) {
		dev->speed = pdata->clkrate;
		dev->flags = pdata->flags;
		dev->set_mpu_wkup_lat = pdata->set_mpu_wkup_lat;
		dev->dtrev = pdata->rev;
	}

I removed every other pdata reference after this point.

Regards,
Benoit
