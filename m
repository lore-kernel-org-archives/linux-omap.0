From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [usb-next PATCH v11 3/8] usb: core: add a wrapper for the USB
 PHYs on the HCD
Date: Fri, 6 Apr 2018 17:28:52 +0900
Message-ID: <CAK7LNAQ=ke2MJVx2Fs-bSAO40QT7ceMNfPXJy2AOREfNb_7r_g@mail.gmail.com>
References: <20180303214309.25643-1-martin.blumenstingl@googlemail.com>
 <20180303214309.25643-4-martin.blumenstingl@googlemail.com>
 <CAK7LNARM=F3Ey0aO9PiNftxkcLVo4z10jdrkSrQE1f74nK1=Ng@mail.gmail.com>
 <CAFBinCCRhJLxOCz6_a23XnVcSo35MpE8huA8keNFBrWmr_mR=A@mail.gmail.com>
 <CAK7LNASN4mgSVXw425CEuFzJdgmgiv=u9h7T+_zSbqU7dwRRcA@mail.gmail.com>
 <CAFBinCDThyLeeHaB4WrtCCf_91jf68MohaUF7UbdgWxBDBq6LQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAFBinCDThyLeeHaB4WrtCCf_91jf68MohaUF7UbdgWxBDBq6LQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Peter.Chen@nxp.com, Neil Armstrong <narmstrong@baylibre.com>, linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Tony Prisk <linux@prisktech.co.nz>, Felipe Balbi <felipe.balbi@linux.intel.com>, Jon Hunter <jonathanh@nvidia.com>, Alan Stern <stern@rowland.harvard.edu>, Chunfeng Yun <chunfeng.yun@mediatek.com>, DTML <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, yixun.lan@amlogic.com, Rob Herring <robh+dt@kernel.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, linux-amlogic@lists.infradead.org, Linux-OMAP <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, mathias.nyman@intel.com
List-Id: linux-omap@vger.kernel.org

2018-04-06 14:15 GMT+09:00 Martin Blumenstingl
<martin.blumenstingl@googlemail.com>:

>>
>> When will this be available in Linus' tree?   In the current MW?
> this is already available in Linus' tree. the commit for this specific
> patch (#3) is known as 07dbff0ddbd86c


Oh, great!  Thank you.



>> Sure, I can send a patch after some flaws are ironed-out.
> great, thank you!
> could you also let me know once you have tested this on one of your SoCs?

I will.





-- 
Best Regards
Masahiro Yamada
