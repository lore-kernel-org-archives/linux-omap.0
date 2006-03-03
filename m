From: Tony Lindgren <tony@atomide.com>
Subject: Re: Bad data CRC problem after i restart the OSK 5912
Date: Fri, 3 Mar 2006 11:04:33 -0800
Message-ID: <20060303190432.GH4398@atomide.com>
References: <26d3a31c0603022252i50c46104qe2aad374479156b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <26d3a31c0603022252i50c46104qe2aad374479156b0@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: prafulla chandra vejendla <v.prafulla@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* prafulla chandra vejendla <v.prafulla@gmail.com> [060302 22:53]:
> Hi all,
> i am using u-boot 1.1.1 with linux2.6.11.3 i made an uimage.cc of 1143783
> bytes (nearly 1.1MB) with out any error by following new-bie guide for my
> osk 5912 board i downloaded that through  the hyperterminal by using the
> kermit protocol . once i restarted the board or if i use
>  bootm 0x100000 it is giving verifying checksum....... Bad Data CRC. and
> remained in the uboot prompt only.
> why i am getting this error .where will be the problem.whether that kernal
> and u-boot combination that i have choosen is correct or not.
> please clear my doubt

Probably bad memory timings set in the bootloader.

Tony
