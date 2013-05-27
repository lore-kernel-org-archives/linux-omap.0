From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 3/3] usb: dwc3: use extcon fwrk to receive
 connect/disconnect notification
Date: Mon, 27 May 2013 14:38:07 +0900
Message-ID: <51A2F13F.80703@samsung.com>
References: <1369405896-30246-1-git-send-email-kishon@ti.com>
 <1369405896-30246-4-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-reply-to: <1369405896-30246-4-git-send-email-kishon@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: myungjoo.ham@samsung.com, balbi@ti.com, ldewangan@nvidia.com, gg@slimlogic.co.uk, lgirdwood@gmail.com, broonie@kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, grant.likely@linaro.org, rob.herring@calxeda.com, rob@landley.net, gregkh@linuxfoundation.org, george.cherian@ti.com, sameo@linux.intel.com
List-Id: linux-omap@vger.kernel.org

On 05/24/2013 11:31 PM, Kishon Vijay Abraham I wrote:
> Modified dwc3-omap to receive connect and disconnect notification using
> extcon framework. Also did the necessary cleanups required after
> adapting to extcon framework.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/usb/dwc3/dwc3-omap.c  | 80 +++++++++++++++++++++++++++++++++----------
>  include/linux/usb/dwc3-omap.h | 30 ----------------
>  2 files changed, 62 insertions(+), 48 deletions(-)
>  delete mode 100644 include/linux/usb/dwc3-omap.h
>
>
I check the code about extcon framework.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi
