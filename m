From: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH V2 0/2] ARM: l2c: OMAP4/AM437x: Additional register programming
 support.
Date: Fri, 02 Jan 2015 10:46:54 -0800
Message-ID: <54A6E79E.7010203@oracle.com>
References: <1420220628-23742-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1420220628-23742-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Santosh <ssantosh@kernel.org>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

On 1/2/15 9:43 AM, Nishanth Menon wrote:
> Hi,
> OMAP4 and AM437x ROM code provides services to program PL310's latency
> registers and AM437x provides service for programming Address filter
> registers.
>
> Provide support in the kernel for the same.
>
> V2 of the series contains documentation update and a bug fix due to a
> typo introduced during patch split :(
>
> Nishanth Menon (2):
>    ARM: l2c: OMAP4/AM437x: Introduce support for cache latency
>      programming
>    ARM: l2c: AM437x: Introduce support for cache filter programming
>
Looks fine to me ...
Feel free to add my ack if you need one ...

Minor: The subject looks like I2C though it is L2C ;-)
