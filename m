From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2 2/7] usb: extcon: Fix USB-Host cable name
Date: Fri, 30 Jan 2015 16:05:49 +0200
Message-ID: <54CB8FBD.6050701@ti.com>
References: <1422274532-9488-1-git-send-email-rogerq@ti.com> <1422274532-9488-3-git-send-email-rogerq@ti.com> <54CB6539.1040703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54CB6539.1040703@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, cw00.choi@samsung.com
Cc: tony@atomide.com, myungjoo.ham@samsung.com, george.cherian@ti.com, nsekhar@ti.com, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 30/01/15 13:04, Roger Quadros wrote:
> Felipe & Chanwoo,
> 
> On 26/01/15 14:15, Roger Quadros wrote:
>> The recommended name for USB-Host cable state is "USB-Host" and not
>> "USB-HOST" as per drivers/extcon/extcon-class.c extcon_cable_name.
>>
>> Change all instances of "USB-HOST" to "USB-Host".
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Reviewed-by: Felipe Balbi <balbi@ti.com>
>> Acked-by: Felipe Balbi <balbi@ti.com>
> 
> This patch has no dependency to the rest so can be picked up as soon as possible.
> 
> Do you think it is better to go via the USB tree?
> If yes then Chanwoo, can you please Ack this one? Thanks.
> 
> This would mean that only the first patch needs to go through extcon tree as Tony
> will pick the rest.

Hold on. Let's first decide what we really want to go ahead with
"USB-Host" or "USB-HOST".

cheers,
-roger
