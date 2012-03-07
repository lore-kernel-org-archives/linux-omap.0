From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC PATCH] OMAP: UART: Enable tx wakeup bit in wer
Date: Tue, 6 Mar 2012 22:57:22 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1203062251270.23214@utopia.booyaka.com>
References: <1327412249-31575-1-git-send-email-govindraj.raja@ti.com> <alpine.DEB.2.00.1201251217120.5324@utopia.booyaka.com> <alpine.DEB.2.00.1203051321580.1430@utopia.booyaka.com> <CAMrsUdJqmJ75=X_Qg3vQCr7zezs0jOK8L1ri8p5K=+6ZKsRFcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <CAMrsUdJqmJ75=X_Qg3vQCr7zezs0jOK8L1ri8p5K=+6ZKsRFcg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
To: "Raja, Govindraj" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Partha Basak <p-basak2@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi

On Tue, 6 Mar 2012, Raja, Govindraj wrote:

> I see two ways of adding this tx wake-up flag.
> 
> 1.) passing a feature flag from pdata and populating the feature value to wer.
> 
> 2.) Duplicating the uart1/2/3 hwmod for omap3430 without dev attrib
> and uart1/2/3/4
>      hwmod for omap3630 with dev attribs.
> 
> Approach-2 adds unnecessary code duplication in hwmod file with and without
> dev_attribs, So right now here is the patch to follow approach [1],
> 
> If its strongly recommended to use approach-2 will add it.
> (My concern is the diffstat it might produce with approach-2)

Both 1 and 2 are needed.

The current way that errata are handled in arch/arm/mach-omap2/serial.c 
needs to be changed.  Those should be flags that are passed from hwmod 
dev_attr data.  The presence of the TX wakeup bit should simply be another 
dev_attr flag.  These flags should be passed to the driver via the 
omap_up.errata field for the time being.

The exception to this is if the IP block's revision register was changed 
when TX wakeups became possible.  If that's the case, then that mechanism 
can be used in lieu of dev_attr and platform_data in this situation.


- Paul
