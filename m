From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: HWMOD: make 'ocp2scp_usb_phy_phy_48m" as
 the main clock
Date: Tue, 9 Apr 2013 14:25:05 +0530
Message-ID: <5163D769.1040401@ti.com>
References: <1365496101-7829-1-git-send-email-kishon@ti.com>
 <5163D72B.5040205@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5163D72B.5040205@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux@arm.linux.org.uk, tony@atomide.com, Keerthy <j-keerthy@ti.com>, rnayak@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tuesday 09 April 2013 02:24 PM, Benoit Cousson wrote:
> Hi Kishon,
>
> On 04/09/2013 10:28 AM, Kishon Vijay Abraham I wrote:
>> commit 92702d (ARM: OMAP4: PM: fix PM regression introduced by recent
>> clock cleanup) makes the 'ocp2scp_usb_phy_phy_48m' as optional
>> functional clock causing regression in MUSB. But this 48MHz clock is a
>> mandatory clock for usb phy attached to ocp2scp and hence made as the main
>> clock for ocp2scp.
>
> It is a fix for 3.9-rcX?

Yeah.

Thanks
Kishon
