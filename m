From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: Re: I2C not working in uboot
Date: Tue, 17 Jul 2007 07:51:17 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D9130274290170DCCC@dlee13.ent.ti.com>
References: <c656a4d20707170409g6f9b294eyec6f9f798c9b25d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <u-boot-users-bounces@lists.sourceforge.net>
Content-class: urn:content-classes:message
In-Reply-To: <c656a4d20707170409g6f9b294eyec6f9f798c9b25d3@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/u-boot-users>,
	<mailto:u-boot-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=u-boot-users>
List-Post: <mailto:u-boot-users@lists.sourceforge.net>
List-Help: <mailto:u-boot-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/u-boot-users>,
	<mailto:u-boot-users-request@lists.sourceforge.net?subject=subscribe>
Sender: u-boot-users-bounces@lists.sourceforge.net
Errors-To: u-boot-users-bounces@lists.sourceforge.net
To: arun c <arun.edarath@gmail.com>, linux-omap-open-source@linux.omap.com
Cc: u-boot-users@lists.sourceforge.net
List-Id: linux-omap@vger.kernel.org

> Please somebody tell me the correct way use the
> I2C bus for checking the keypad in uboot.

- I'll assume you used the u-boot snapshot from the TI download site for 2430.

- I've used the i2c commands in the past with out issues for 24xx/343x targets.  I've not tried this is a while on 24xx but it worked last time I tried.

- T2 shows up as 4 separate i2c chips.  Below is an example accessing into it.  You should be able to go look at the revision register and others.

- Below is an example writing to the power section to select a high voltage level.  The example was part of some over clocking tests which required a higher voltage.

OMAP34XX SDP # imm 4b b9
000000b9: 30 ?
000000ba: 00 ?
000000bb: 00 ? 43
000000bc: 00 ? 43
000000bd: 00 ? .
OMAP34XX SDP # imm 4b b9
000000b9: 30 ?
000000ba: 00 ? 3
000000bb: 43 ? . 

Regards,
Richard W.


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
