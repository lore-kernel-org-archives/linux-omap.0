From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: Re: [PATCH v2 1/4] dwc3: exynos: Add support for SCLK present on Exynos7
Date: Wed, 8 Oct 2014 08:31:19 +0530
Message-ID: <CAFp+6iF9ttEGSVc9p+YSXFxKnVTGK5aqyT0nEiFXbpoXj8aW+w@mail.gmail.com>
References: <1412677176-3850-1-git-send-email-gautam.vivek@samsung.com>
	<1412677176-3850-2-git-send-email-gautam.vivek@samsung.com>
	<20141007141118.GD24720@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141007141118.GD24720@saruman>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Kukjin Kim <kgene.kim@samsung.com>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, robh+dt <robh+dt@kernel.org>, kishon <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 7, 2014 at 7:41 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Tue, Oct 07, 2014 at 03:49:33PM +0530, Vivek Gautam wrote:
>> Exynos7 also has a separate special gate clock going to the IP
>> apart from the usual AHB clock. So add support for the same.
>>
>> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
>
> I'll take this one once -rc1 is tagged. The others have no direct
> dependency on this so I'll leave them to Kishon.

Thanks Felipe !



-- 
Best Regards
Vivek Gautam
Samsung R&D Institute, Bangalore
India
