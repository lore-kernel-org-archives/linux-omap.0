From: Sneeker Yeh <sneeker.yeh@gmail.com>
Subject: Re: [PATCH v4 5/5] usb: dwc3: add Fujitsu Specific Glue layer
Date: Wed, 18 Feb 2015 21:55:27 +0800
Message-ID: <CAJ1gpc1D_siNXPjfGrE2OJVzYaEz19TcAqCwjxMXPt7g6VFncQ@mail.gmail.com>
References: <1424151697-2084-1-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
	<1424151697-2084-6-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
	<20150217192612.GH31167@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150217192612.GH31167@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mathias Nyman <mathias.nyman@intel.com>, Grant Likely <grant.likely@linaro.org>, Huang Rui <ray.huang@amd.com>, Kishon Vijay Abraham I <kishon@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Andy Green <andy.green@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>, Sneeker Yeh <Sneeker.Yeh@tw.fujitsu.com>
List-Id: linux-omap@vger.kernel.org

hi Felipe:

thanks for the suggestion,

2015-02-18 3:26 GMT+08:00 Felipe Balbi <balbi@ti.com>:
> On Tue, Feb 17, 2015 at 01:41:37PM +0800, Sneeker Yeh wrote:
>> This patch adds support for Synopsis DesignWare USB3 IP Core found
>> on Fujitsu Socs.
>>
>> Signed-off-by: Sneeker Yeh <Sneeker.Yeh@tw.fujitsu.com>
>> ---
>>  .../devicetree/bindings/usb/fujitsu-dwc3.txt       |   33 ++++
>>  drivers/usb/dwc3/Kconfig                           |   11 ++
>>  drivers/usb/dwc3/Makefile                          |    1 +
>>  drivers/usb/dwc3/dwc3-mb86s70.c                    |  206 ++++++++++++++++++++
>>  4 files changed, 251 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/usb/fujitsu-dwc3.txt
>>  create mode 100644 drivers/usb/dwc3/dwc3-mb86s70.c
>
> what's the possibility that fujitsu will make another SoC with dwc3 in
> it ? I wonder if we should use a slightly more generic name here:
>
> dwc3-fujitsu.c ?

We did have several SoC that has dwc3 in it,
"dwc3-fujitsu.c" looks fine, and I would like to take this to next patchset.

Much appreciate,
Sneeker

>
> --
> balbi
