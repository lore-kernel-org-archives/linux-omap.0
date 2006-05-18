From: =?ISO-8859-1?Q?Juha_Yrj=F6l=E4?= <juha.yrjola@nokia.com>
Subject: Re: [PATCH] ARM: OMAP: OMAP_GPIO_SWITCH doesn't need OMAP_BOOT_TAG
Date: Thu, 18 May 2006 11:34:26 +0300
Message-ID: <446C3192.5070402@nokia.com>
References: <20060517172547.GA3778@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060517172547.GA3778@earth.li>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Jonathan McDowell <noodles@earth.li>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Jonathan McDowell wrote:

> I can't see any reason why OMAP_GPIO_SWITCH depends on OMAP_BOOT_TAG;
> it compiles fine without it. This patch removes the Kconfig dependency.

Yeah, that's a legacy restriction.

> Also the description is wrong; it doesn't hook into the input layer at
> all from what I can tell. Are there patches around that add this? The
> Amstrad Delta has a phone hook on a GPIO that I plan to support with
> this driver and being able to produce a keypress would be nice.

It doesn't anymore.  We replaced that with uevents.  Nowadays the right 
way to go is to use the sysfs_notify() API.

The patches for the input stuff are probably long gone (but you might 
find something in the BitKeeper repository).  I won't object to someone 
re-adding the input layer functionality again, though.

Cheers,
Juha
