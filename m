From: =?ISO-8859-1?Q?Juha_Yrj=F6l=E4?= <juha.yrjola@solidboot.com>
Subject: Re: [PATCH] ARM: OMAP: Add minimal OMAP2430 support
Date: Sun, 11 Jun 2006 16:54:23 +0300
Message-ID: <448C208F.4020102@solidboot.com>
References: <EA12F909C0431D458B9D18A176BEE4A506200337@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A506200337@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Woodruff, Richard wrote:

> Along with my other biases I rationalized it this way... I like
> having  a private driver incompatible method to access the PRCM. It forces
> drivers to use API access functions and not directly access its
> registers. The PRCM has more and more things to manage and having some
> xyz driver mess up its state behind my back will break everything.

Exactly.  That's why I keep my read_reg/write_reg functions static. 
Usually I put even the register definitions to the .c file, since other 
drivers shouldn't have any business modifying them directly anyway.

Cheers,
Juha
