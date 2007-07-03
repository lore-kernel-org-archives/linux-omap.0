From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: What is NAND sector size?
Date: Tue, 03 Jul 2007 06:51:55 -0500
Message-ID: <468A385B.7030109@gmail.com>
References: <c656a4d20707030006u71af1aaej1eac87122d195f67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <c656a4d20707030006u71af1aaej1eac87122d195f67@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: arun c <arun.edarath@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Arun,

arun c stated on 7/3/2007 2:06 AM:
>
> Is this sector size=pagesize?
In general - yes.
> And what is CFG_MAX_FLASH_SECT for my nand device?
Depends on the uboot version you are using.. grep for it's usage..
easier that way.
Regards,
Nishanth Menon
