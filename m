From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 00/13] extcon: major rework
Date: Thu, 24 Apr 2014 12:52:03 -0700
Message-ID: <20140424195203.GG12809@kroah.com>
References: <1397475984-28001-1-git-send-email-r.baldyga@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1397475984-28001-1-git-send-email-r.baldyga@samsung.com>
Sender: linux-doc-owner@vger.kernel.org
To: Robert Baldyga <r.baldyga@samsung.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rob@landley.net, myungjoo.ham@samsung.com, cw00.choi@samsung.com, dbaryshkov@gmail.com, dwmw2@infradead.org, balbi@ti.com, grant.likely@linaro.org, ldewangan@nvidia.com, kishon@ti.com, gg@slimlogic.co.uk, anton@enomsg.org, jonghwa3.lee@samsung.com, rongjun.ying@csr.com, linux@roeck-us.net, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, aaro.koskinen@iki.fi, m.szyprowski@samsung.com, t.figa@samsung.com
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 14, 2014 at 01:46:11PM +0200, Robert Baldyga wrote:
> This patchset adds many improvements to extcon class driver and extcon
> provider drivers. It changes extcon API to faster and safer by replaceing
> function taking extcon and cable names with functions working with
> structures representing this objects.

What is "faster" exactly?  How did you measure this?  What benchmarks
can be run to test this claim?

thanks,

greg k-h
