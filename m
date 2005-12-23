From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: Problem with flashing and/or starting UBoot with 2420
Date: Fri, 23 Dec 2005 03:22:35 -0800 (PST)
Message-ID: <20051223112235.86861.qmail@web32905.mail.mud.yahoo.com>
References: <3d3153f60512230139v57b3a30dh2346e44ad2b17da8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3d3153f60512230139v57b3a30dh2346e44ad2b17da8@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Ola Helm <ola.hel@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- Ola Helm <ola.hel@gmail.com> wrote:

> Hi all,
> 
> My problem is following one:
> 
> I flashed the newest H4 UBoot available to ou board and after restart
> I get
> following message in Hyperterminal:
> 
> U-Boot 1.1.3 (Sep  6 2005 - 14:24:25)
> 
> U-Boot code: 80E80000 -> 80E9F0E8  BSS: -> 80EA3F2C
> OMAP2420-GP revision 3, PRCM II
> TI H4 SDP Base Board + Menelaus Daughter Board + mDDR
> RAM Configuration:
> Bank #0: 80000000 32 MB
> Bank #1: 82000000 32 MB
> ## Unknown FLASH on Bank 0 - Size = 0x00000000 = 0 MB
> ## Unknown FLASH on Bank 1 - Size = 0x00000000 = 0 MB
> Flash:  0 kB
> NAND:

>From this I can make out that, you are trying to boot from NAND instead
of NOR ...!!! Switch positions on processor daughter card is wrong.

Does u-boot compiled for NAND or NOR? Please undefine
#CONFIG_NAND_BOOT.

Please see this:
http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005994.html

---Komal Shah
http://komalshah.blogspot.com/


	
		
__________________________________ 
Yahoo! for Good - Make a difference this year. 
http://brand.yahoo.com/cybergivingweek2005/
