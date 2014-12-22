From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH 00/11] Exynos7: Adding USB 3.0 support
Date: Mon, 22 Dec 2014 15:47:41 +0100
Message-ID: <54982F0D.6040702@samsung.com>
References: <1416576954-11997-1-git-send-email-gautam.vivek@samsung.com>
 <20141121151130.GD7508@saruman> <54704BF0.1000903@ti.com>
 <5470A7C5.1070302@kernel.org>
 <CAFp+6iE5XJ+TGu+8TvRFd3Up-kzki3VPD4k6gPXaYbscfwnz4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAFp+6iE5XJ+TGu+8TvRFd3Up-kzki3VPD4k6gPXaYbscfwnz4w@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Vivek Gautam <gautamvivek1987@gmail.com>
Cc: Kukjin Kim <kgene@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Felipe Balbi <balbi@ti.com>, Vivek Gautam <gautam.vivek@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Linux USB Mailing List <linux-usb@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, robh+dt <robh+dt@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-omap@vger.kernel.org

Hi Vivek,

On 25/11/14 12:48, Vivek Gautam wrote:
> On Sat, Nov 22, 2014 at 8:42 PM, Kukjin Kim <kgene@kernel.org> wrote:
>> > On 11/22/14 17:40, Kishon Vijay Abraham I wrote:
>>> >> On Friday 21 November 2014 08:41 PM, Felipe Balbi wrote:
...
>>>> >>> I took dwc3 driver patches.
>>> >>
>>> >> I took the phy patches.
>>> >>
>> > I'll take DT changes once exynos7 is landing into samsung tree :)
>> >
> You too may want to pick the sole clock driver patch in this series
> for 3.19 ? :-)
> "clk: exynos7: Add required clock tree for USB"
> 
> Please let me know if the merge window is still open on your side so
> that you can pick this patch.

My apologies, it seems I have missed this patch. :/
Feel free to ping me off the list in future if there is no response
for more than week.
I queued this patch now for 3.20.  I'm putting all the exynos7 clk
patches on a separate branch which could then be pulled into samsung
arm tree for the dependant dts changes.

-- 
Thanks,
Sylwester
