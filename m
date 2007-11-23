From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: USB: Define OMAP34XX_HSUSB_OTG_BASE
Date: Fri, 23 Nov 2007 13:13:39 -0800
Message-ID: <20071123211338.GG559@atomide.com>
References: <31e679430711191127q158bd600q3e399617b343eec0@mail.gmail.com>
	<5DF83221BE20114E9C331F665ACBC08003ED7054@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <5DF83221BE20114E9C331F665ACBC08003ED7054@dbde01.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Pandita, Vikram <vikram.pandita@ti.com> [071123 04:45]:
> Tony 
>  This patch: 
>  1) Correctly defines the base address for HSUSB_OTG block (MUSB)
>     Patch by Filipe had incorrect base address for 34xx
> 
>  2) Includes the base addresses of: USBTLL and USBHOST present in 3430ES2.0
> 
> Felipe
>  I see that for 34XX the base address for HSUSB_OTG is not correctly defined
>  by your patch so resending with modifications

Pushing this patch and the two others by Felipe.

Tony
