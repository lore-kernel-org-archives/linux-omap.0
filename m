From: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: How to handle named resources with DT?
Date: Tue, 9 Aug 2011 23:08:09 +0200
Message-ID: <4E41A1B9.1060400@ti.com>
References: <4E40FC88.5090403@ti.com>
	<20110809162907.GA630@manju-WNB7PBC4801-0006>
	<4E4166F0.9050401@ti.com>
	<CACxGe6tbEW1EZhqXy78EZVM_sQLH0Qbr7QOzbgbsKBRn1FtVrg@mail.gmail.com>
	<4E4172A8.3030101@ti.com> <4E417BD5.8080409@freescale.com>
	<20110809205723.GE11568@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20110809205723.GE11568-e0URQFbLeQY2iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: "Hilman, Kevin" <khilman-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, "G,
	Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 8/9/2011 10:57 PM, Grant Likely wrote:
> On Tue, Aug 09, 2011 at 01:26:29PM -0500, Scott Wood wrote:
>> On 08/09/2011 12:47 PM, Cousson, Benoit wrote:
>>> On 8/9/2011 7:23 PM, Grant Likely wrote:
>>>> There is no analogous mechanism for _byname in the device tree.  The
>>>> DT binding for a device must explicitly state what order the register
>>>> ranges are in.  The driver will need to be adapted.
>>>
>>> That seems to be a small regression for my point of view. Relying on the
>>> order is not super safe. This is not very readable either. That's for
>>> that exact reason that we changed our drivers to use
>>> platform_get_resource_byname. That's probably the reason why that API is
>>> there as well.
>>> For the same IP, the number of entries can vary depending of the SoC
>>> revision.
>>> By using the _byname, we can check if the resource is there or not
>>> without having to care about the position.
>>
>> You could have a named u32 property that contains the reg index, e.g.:
>>
>> dev {
>> 	reg =<0x20000 0x200 0x24000 0x200>;
>> 	foo-reg =<0>;
>> 	bar-reg =<1>;
>> };
>
> That's a little nasty.  A reg-names = "foo", "bar"; would probably be
> better.

Yep, I agree.

And what about something like that?
   reg = <0x20000 0x200>, "foo",
	<0x20000 0x200>, "bar" ;

It is doable?

Regards,
Benoit
