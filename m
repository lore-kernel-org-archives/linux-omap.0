From: David Brownell <david-b@pacbell.net>
Subject: Re: Using SPI
Date: Tue, 12 Sep 2006 23:21:29 -0700
Message-ID: <20060913062129.29FDD1A0082@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <20060911033810.89093.qmail@web55802.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060911033810.89093.qmail@web55802.mail.re3.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux-omap-open-source@linux.omap.com, abo_gwapo@yahoo.com
List-Id: linux-omap@vger.kernel.org

> I've been exploring SPI on the kernel. I've started
> reading on how SPI works. I've learned that all SPI
> drivers are currently kernel drivers.

That's normal for drivers that may use IRQs and/or DMA.


>	I would to know
> if anybody have tried to do a userspace driver API? Or
> anybody knows of an opensource userspace driver that
> offers low-level access?

A patch was recently posted on the SPI developers' list
providing a userspace/filesystem API ... I've not had
time to look at this incarnation of the patch.

- Dave
