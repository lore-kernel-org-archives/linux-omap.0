From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: JFFS2 on NAND Flash
Date: Wed, 02 May 2007 06:34:46 -0500
Message-ID: <46387756.5040107@gmail.com>
References: <2EE5E03B4244D94F850FC93C0B7172234C45F0@BLR-SGM-MSG01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <2EE5E03B4244D94F850FC93C0B7172234C45F0@BLR-SGM-MSG01.wipro.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: parthasarathy.muniswamy@wipro.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

parthasarathy.muniswamy@wipro.com stated on 5/2/2007 6:20 AM:
> ------------
>
> # nftl_format /dev/mtd12
>
> /sbin/nftl_format: 1: Syntax error: "(" unexpected
>
> ---------
first see which binary is executing - "which nftl_format"-same as what
you intended.., then try strace. Looks most probably to be a filesystem
issue.. mebbe check thru the mtd compilation path once.. do a "file
binary_name" to see ABI versions etc..
Regards,
NM
