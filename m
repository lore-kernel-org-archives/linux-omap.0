From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4] power_supply: Add driver for TWL4030/TPS65950 BCI
 charger
Date: Tue, 28 Sep 2010 09:05:54 +0300
Message-ID: <20100928060554.GF2702@legolas.emea.dhcp.ti.com>
References: <1285618704-8985-1-git-send-email-notasas@gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1285618704-8985-1-git-send-email-notasas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Anton Vorontsov <cbouatmailru@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Sep 27, 2010 at 03:18:24PM -0500, Grazvydas Ignotas wrote:
>+static int twl4030_bci_usb_ncb(struct notifier_block *nb, unsigned long val,
>+                              void *priv)
>+{
>+       struct twl4030_bci *bci = container_of(nb, struct twl4030_bci, otg_nb);
>+
>+       dev_dbg(bci->dev, "OTG notify %lu\n", val);
>+
>+       switch (val) {
>+       case USB_EVENT_VBUS:
>+       case USB_EVENT_CHARGER:

you should have removed CHARGER from here :-)

-- 
balbi
