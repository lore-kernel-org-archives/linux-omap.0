From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 0/6] usb: Replace the deprecated extcon API
Date: Tue, 10 Jan 2017 17:18:28 +0900
Message-ID: <587498D4.4010207@samsung.com>
References: <CGME20161230040816epcas5p4616cb93324a5d60bc2a763817e34e37d@epcas5p4.samsung.com>
 <1483070895-8213-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1483070895-8213-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, chanwoo@kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

These patches have already acked-by tag from you.
Could you please apply them if there is additional comment?

On 2016년 12월 30일 13:08, Chanwoo Choi wrote:
> This patches just replace the deprecated extcon API without any change
> of extcon operation and use the resource-managed function for
> extcon_register_notifier().
> 
> The new extcon API instead of deprecated API.
> - extcon_set_cable_state_() -> extcon_set_state_sync();
> - extcon_get_cable_state_() -> extcon_get_state();
> 
> Changes from v1:
> - Rebase these patches based on v4.10-rc1.
> - Add acked-by tag from usb maintainer and reviewer.
> - Drop the phy/power-supply/chipidea patches.
> 
> Chanwoo Choi (6):
>   usb: dwc3: omap: Replace the extcon API
>   usb: phy: msm: Replace the extcon API
>   usb: phy: omap-otg: Replace the extcon API
>   usb: phy: qcom-8x16-usb: Replace the extcon API
>   usb: phy: tahvo: Replace the deprecated extcon API
>   usb: renesas_usbhs: Replace the deprecated extcon API
> 
>  drivers/usb/dwc3/dwc3-omap.c        | 20 +++++++-------------
>  drivers/usb/phy/phy-msm-usb.c       | 33 +++++++++++----------------------
>  drivers/usb/phy/phy-omap-otg.c      | 24 ++++++------------------
>  drivers/usb/phy/phy-qcom-8x16-usb.c | 13 ++++---------
>  drivers/usb/phy/phy-tahvo.c         | 10 +++++-----
>  drivers/usb/renesas_usbhs/common.c  |  2 +-
>  6 files changed, 34 insertions(+), 68 deletions(-)
> 


-- 
Best Regards,
Chanwoo Choi
S/W Center, Samsung Electronics
