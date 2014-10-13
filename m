From: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/4] dwc3: exynos: Add support for SCLK present on
 Exynos7
Date: Tue, 14 Oct 2014 00:51:06 +0200
Message-ID: <543C575A.1030105@gmail.com>
References: <1412677176-3850-1-git-send-email-gautam.vivek@samsung.com> <1412677176-3850-2-git-send-email-gautam.vivek@samsung.com> <00f101cfe6a1$d772c5a0$865850e0$%tikhomirov@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <00f101cfe6a1$d772c5a0$865850e0$%tikhomirov-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anton Tikhomirov <av.tikhomirov-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Vivek Gautam' <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Anton,

On 13.10.2014 06:54, Anton Tikhomirov wrote:
> Hi Vivek,
> 
>> Exynos7 also has a separate special gate clock going to the IP
>> apart from the usual AHB clock. So add support for the same.
> 
> As we discussed before, Exynos7 SoCs have 7 clocks to be controlled
> by the driver. Adding only sclk is not enough. 
> 

I'm quite interested in this discussion. Has it happened on mailing lists?

In general, previous SoCs also gave the possibility of controlling all
the bus clocks separately, in addition to bulk gates, but there was no
real advantage in using those, while burdening the clock tree with
numerous clocks. Isn't Exynos7 similar in this aspect?

Best regards,
Tomasz
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
