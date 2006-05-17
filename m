From: =?ISO-8859-1?Q?Juha_Yrj=F6l=E4?= <juha.yrjola@nokia.com>
Subject: Re: Userspace GPIO
Date: Wed, 17 May 2006 12:49:26 +0300
Message-ID: <446AF1A6.90703@nokia.com>
References: <09D3F703EF3B0A4CBE28449EA9F3D320477ADA@nicta-atp-mail.in.nicta.com.au>
	<fb249edb0605170156u63eceb3fja5fa915c8e2c405d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <fb249edb0605170156u63eceb3fja5fa915c8e2c405d@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: balrogg@gmail.com
Cc: linux-omap-open-source@linux.omap.com, Marco Candiago <Marco.Candiago@nicta.com.au>
List-Id: linux-omap@vger.kernel.org

andrzej zaborowski wrote:

> You could create it by modifying one of the drivers already present in
> the tree, I know the Intel PXA hackers have one of these and use it as
> a keypad driver because each key is associated with one GPIO line on
> their boards.

Or you could GPIO switch framework (arch/arm/plat-omap/gpio-switch.c), 
which interfaces to user-space using sysfs.  It will need a small amount 
of work to operate properly with the platform_data mechanism, though.

Cheers,
Juha
