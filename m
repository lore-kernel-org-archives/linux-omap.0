From: Robert Baldyga <r.baldyga@samsung.com>
Subject: Re: [PATCH v2 00/13] extcon: major rework
Date: Mon, 28 Apr 2014 11:34:02 +0200
Message-ID: <535E208A.4050305@samsung.com>
References: <1397475984-28001-1-git-send-email-r.baldyga@samsung.com>
 <20140424195203.GG12809@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-reply-to: <20140424195203.GG12809@kroah.com>
Sender: linux-doc-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rob@landley.net, myungjoo.ham@samsung.com, cw00.choi@samsung.com, dbaryshkov@gmail.com, dwmw2@infradead.org, balbi@ti.com, grant.likely@linaro.org, ldewangan@nvidia.com, kishon@ti.com, gg@slimlogic.co.uk, anton@enomsg.org, jonghwa3.lee@samsung.com, rongjun.ying@csr.com, linux@roeck-us.net, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, aaro.koskinen@iki.fi, m.szyprowski@samsung.com, t.figa@samsung.com
List-Id: linux-omap@vger.kernel.org

On 04/24/2014 09:52 PM, Greg KH wrote:
> On Mon, Apr 14, 2014 at 01:46:11PM +0200, Robert Baldyga wrote:
>> This patchset adds many improvements to extcon class driver and extcon
>> provider drivers. It changes extcon API to faster and safer by replaceing
>> function taking extcon and cable names with functions working with
>> structures representing this objects.
> 
> What is "faster" exactly?  How did you measure this?  What benchmarks
> can be run to test this claim?
> 

Most of new API functions are O(1), because they take as argument
pointer to struct extcon_cable, and operates on it. In contrast,
previous API functions needed to compare given cable name with name of
each cable specified in extcon controller. This solution was also prone
to errors - when you make typo in extcon name or cable name it will not
be detected at compilation time. The new API uses names only at
initialization, and after that each function takes pointer to struct
extcon_cable.

The old API is also fragile because defined list of cables could be
different in each extcon provider (the same cable could have different
name in each extcon provider), so using different extcon providers with
different drivers would need doing modifications in drivers.

Best regards
Robert Baldyga
Samsung R&D Institute Poland
