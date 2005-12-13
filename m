From: "Mihail Georgiev" <georgiev@students.cc.tut.fi>
Subject: das U-boot loader on omap 1510
Date: Tue, 13 Dec 2005 14:34:40 +0200
Message-ID: <op.s1p2j2cvtqqdru@tsunami.it.tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

I am trying to flas u-boot loader on my OMAP system
but i somehow not succeed with that...
For now i am booting from ram - where i prevously load
u-boot..and with bootm command start flashed linux..
everything is ok..
but i can't flash u-boot..or probably i do not know where i am wrong
I am sure that bin version of u-boot is working...

i use following commands:
protect off 1:0-4
erase 1:0-4
loadb uboot.bin
...
....
cp.b 0x10000000 0 0x....
protect on 1:0-4

Is thos somehow connected with configuration switch SW2-
in two different tutorials i found two different configuration for flashi=
ng
u-boot..
Can you tell whether i am wrong with something or how exactly to tell
to OMAP(with SW2) to boot my flashed u-boot...
