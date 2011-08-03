From: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: Shouldn't DT preserve pdev name and id to allow platform_match
	to work?
Date: Wed, 3 Aug 2011 18:27:04 +0200
Message-ID: <4E3976D8.20602@ti.com>
References: <4E396361.3060307@ti.com>
	<CAC63_iRa1qc7pO9Eub1A+cC+R=tSkwzigVPDHqcbvOngACYWqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CAC63_iRa1qc7pO9Eub1A+cC+R=tSkwzigVPDHqcbvOngACYWqQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: "G, Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>
Cc: "Hilman, Kevin" <khilman-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "Nayak, Rajendra" <rnayak-l0cyMroinI0@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Manju,

On 8/3/2011 6:17 PM, G, Manjunath Kondaiah wrote:
> Hi Benoit,
>
> On Wed, Aug 3, 2011 at 8:34 PM, Cousson, Benoit<b-cousson-l0cyMroinI0@public.gmane.org>  wrote:
>> Hi Grant,
>>
>> Going further with the usage of OF_DEV_AUXDATA_ID, I realized that this is is not doing what I was expecting. My expectation might be silly, but in order to make platform_match to work without DT matching mechanism, you need to have the driver name in the pdev->name field:
>>
>>         /* fall-back to driver name match */
>>         return (strcmp(pdev->name, drv->name) == 0);
>>
>> Except that the of_device_add function is doing that:
>>         pdev->name = dev_name(&ofdev->dev);
>>         pdev->id = -1;
>
> This is taken here:
> http://git.secretlab.ca/?p=linux-2.6.git;a=commitdiff;h=04f51955dc690666467252015a931d71d5c56696
>
> and it is pending for upstream.
>
> With the above patch, both pdev->name and pdev->id can be set as per
> hwmod requirement through aux_data lookup table.

Mmm, but I'm already using that patch, and it is only taking care of the 
pdev->id, hence my email. Did I miss something?

> we might have to append pdev->id to pdev->name so that
> it can used for device look up in the hwmod
> device list.

I'm not sure to get your point here.

Benoit
