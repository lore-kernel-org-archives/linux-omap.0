From: <simonchu47@yahoo.com.tw>
Subject: Cannot ping localhost
Date: Fri, 13 Jul 2007 09:27:01 +0800 (CST)
Message-ID: <395493.54739.qm@web72703.mail.tp2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi:
I am using an OMAP5912 OSK board, and I have build a
kernal image and root file system running in it.
After booting up, I found that I cannot ping
localhost, but my application needs to chect it.
The error is as following:

# ping localhost
ping: bad address 'localhost'

my U-Boot is 1.1.5, Linux kernel version 2.6.12-omap1,
and BusyBox v1.5.0. I have added /etc/hosts and
/etc/host.conf

# cat /etc/hosts
# Do not remove the following line, or various
programs
# that require network functionality will fail.
127.0.0.1               localhost.localdomain
localhost

But it doesn't work. Can anybody tell me why?


      ___________________________________________________________________=
_________________
=B7Q=A4=CE=AE=C9=B3q=AA=BE=B3q=B0T=BF=FD=B8=CC=AA=BA=A9=D2=A6=B3=BF=CB=AA=
B=A6n=A4=CD=A6n=AE=F8=AE=A7=A1A=B4N=A8=D3 Yahoo!=A9_=BC=AF=B9q=A4l=ABH=BD=
c=B5o=C2=B2=B0T=A1I
http://tw.mobile.yahoo.com/texts/mail.php
