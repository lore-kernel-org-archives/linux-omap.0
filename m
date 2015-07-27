From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 0/5] ARM: dts: OMAP2+: Enable USB dual-role on supported
 boards
Date: Mon, 27 Jul 2015 12:27:50 +0300
Message-ID: <55B5F996.20504@ti.com>
References: <1436352154-28966-1-git-send-email-rogerq@ti.com> <20150721105433.GZ17550@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150721105433.GZ17550@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: balbi@ti.com, Joao.Pinto@synopsys.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Tony,

On 21/07/15 13:54, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [150708 03:45]:
>> Hi,
>>
>> Enables dual-role feaure on supported boards.
>>
>> Depends on
>> [1] - core USB DRD support - http://thread.gmane.org/gmane.linux.kernel/1991413
>> [2] - dwc3 DRD support - http://thread.gmane.org/gmane.linux.usb.general/127890
> 
> Is this series safe to apply separately actually? Adding the
> interrupts and the mode name may not be a problem without
> the related driver changes?

The interrupt changes (patches 1 to 3) should be fine but let's not
add the otg mode change yet till we have the driver OTG patches in.

cheers,
-roger
