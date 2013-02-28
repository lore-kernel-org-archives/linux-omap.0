From: Vivek Gautam <gautamvivek1987-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH RFC] usb: dwc3: Get PHY from platform specific dwc3 dt
 node.
Date: Thu, 28 Feb 2013 20:09:33 +0530
Message-ID: <CAFp+6iGTqZY=+crcYyu9o5uEP9Nv2=haSqB+nCuqA2_iUand6A@mail.gmail.com>
References: <1359631232-7107-1-git-send-email-gautam.vivek@samsung.com>
 <510A56BF.3040804@ti.com>
 <CAFp+6iFkb=U0CJA=3zmQvd5XfMwbROuRJjXoJG7zvvq4_upzNw@mail.gmail.com>
 <20130131152527.GE4064@arwen.pp.htv.fi>
 <CAFp+6iHvKYiF_neANRq5roAEJwhvcaLk7pAd7Dy94Z5XiDkhgA@mail.gmail.com>
 <20130131153836.GF4064@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130131153836.GF4064-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, kishon <kishon-l0cyMroinI0@public.gmane.org>, Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Jan 31, 2013 at 9:08 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> On Thu, Jan 31, 2013 at 09:00:37PM +0530, Vivek Gautam wrote:
>> Hi Felipe,
>>
>>
>> On Thu, Jan 31, 2013 at 8:55 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
>> > Hi,
>> >
>> > On Thu, Jan 31, 2013 at 08:53:27PM +0530, Vivek Gautam wrote:
>> >> >> Moreover, SoCs having multiple dwc3 controllers will have multiple
>> >> >> PHYs, which eventually be added using usb_add_phy_dev(), and not
>> >> >> using usb_add_phy(). So each dwc3 controller won't be able to
>> >> >> get PHYs by simply calling devm_usb_get_phy() also.
>> >> >
>> >> > No. We have added usb_get_phy_dev() for that purpose in the case of non-dt.
>> >> > I think, instead you can have a patch to use devm_usb_get_phy_dev() here and
>> >> > in exynos platform specific code use usb_bind_phy() to bind the phy and
>> >> > controller till you change it to dt.
>> >> >
>> >>
>> >> We have dt support for dwc3-exynos, in such case we should go ahead with
>> >> of_platform_populate(), right ?
>> >> But if when i use of_platform_populate() i will not be able to set
>> >> dma_mask to dwc3->dev. :-(
>> >
>> > do you have a special need for dma_mask because OF already sets it.
>> >
>> If i am not wrong of_platform_device_create_pdata() will set
>> "dev->dev.coherent_dma_mask = DMA_BIT_MASK(32)"
>> and not dma_mask.
>> I fact we had some discussion sometime back when we needed the same
>> for dwc3-exynos in the thread:
>> [PATCH v2 1/2] USB: dwc3-exynos: Add support for device tree
>>
>> But couldn't get final node on it.
>> So suggestions here please. :-)
>
> hmm.. you're right there. Grant, Rob ? Any hints ?
>

Any suggestions on this ?

> --
> balbi



-- 
Thanks & Regards
Vivek
