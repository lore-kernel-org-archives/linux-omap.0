From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH v6 01/11] drivers: usb: otg: add a new driver for omap
 usb2 phy
Date: Mon, 30 Jul 2012 15:34:23 +0530
Message-ID: <50165C27.3010107@ti.com>
References: <1343639400-28725-1-git-send-email-kishon@ti.com> <1343639400-28725-2-git-send-email-kishon@ti.com> <501655F2.7070900@ti.com> <CAAe_U6LWEiAE8TVVEQ5LcKy0_+J7Er2vP71MrQVrg=ZteyAeCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAAe_U6LWEiAE8TVVEQ5LcKy0_+J7Er2vP71MrQVrg=ZteyAeCw@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Cc: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, gregkh@linuxfoundation.org, b-cousson@ti.com, rnayak@ti.com, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Monday 30 July 2012 03:16 PM, ABRAHAM, KISHON VIJAY wrote:
> Hi,
>
> On Mon, Jul 30, 2012 at 3:07 PM, Shubhrajyoti <shubhrajyoti@ti.com> wrote:
>> On Monday 30 July 2012 02:39 PM, Kishon Vijay Abraham I wrote:
>>> +                     writel(~PHY_PD, phy->control_dev);
>>> +                     /* XXX: add proper documentation for this delay */
>>> +                     mdelay(200);
>> Do you need this to be busy?
> This might be called from interrupt context. This delay was initially
> added in omap_phy_internal.c and I just inherited it.
Thanks for the explanation.

> Thanks
> Kishon

