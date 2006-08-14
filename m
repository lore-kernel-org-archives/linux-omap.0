From: kabbin <kabbin26@yahoo.com.tw>
Subject: RE: Problems when porting linux kernel 2.6.10  on OMAP2420H4
Date: Mon, 14 Aug 2006 16:21:03 +0800 (CST)
Message-ID: <20060814082103.91425.qmail@web17803.mail.tpe.yahoo.com>
References: <EA12F909C0431D458B9D18A176BEE4A507010C5D@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A507010C5D@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Dear all
  When I build u-boot (download from 'git') with
arm-linux-gcc-4.0.2-glibc-2.3.6

#make distclean
#make omap2420h4_config
#make all
I got error message:
common/env_flash.c  row: 267 undefined reference to
'flash_probe'=20
  Dear Woodruff have told me there were a patch for
it! But I could not find it.I can only find=20
http://linux.omap.com/pipermail/linux-omap-open-source/2006-February/0064=
36.html
which seems similar problems to mine.
  He also send me some binary files but they did not
work very well. I have no idea how to deal with it.
Please HELP me, Thanks :-) =20

P.S. Especially thanks to Woodruff !Yor are so kind to
help me a lot

___________________________________________________=20
 =B3=CC=B7s=AA=A9 Yahoo!=A9_=BC=AF=A7Y=AE=C9=B3q=B0T 7.0=A1A=A7K=B6O=BA=F4=
=B8=F4=B9q=B8=DC=A5=F4=A7A=A5=B4=A1I=20
 http://messenger.yahoo.com.tw/
